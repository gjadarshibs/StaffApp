import 'package:flutter/foundation.dart';
import 'package:ifly_corporate_app/app_environment/setup/config/flavor_conf.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/models/remote/user_table_model.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/utils/json_client.dart';

class UserProvider {
  /// For demo purpose only.

  final authenticateUserAttemptsCounter =
      AttemptsCounter(lockAttempts: 3, permittedAttempts: 1);

  final otpValidatioAttemptsCounter =
      AttemptsCounter(lockAttempts: 3, permittedAttempts: 1);

  final resendOtpValidatioAttemptsCounter =
      AttemptsCounter(lockAttempts: 3, permittedAttempts: 1);

  UserProvider({JsonClient client}) : _client = client ?? JsonClient();
  static const userTablefileName = 'user_table.json';
  static const userListfileName = 'user_main_list.json';
  final JsonClient _client;

  Future<List<UserTableInfoModel>> _getUserInfoTable() async {
    final basePath = FlavorConfig.instance.properties['dummy_json_data'];
    final filePath = '$basePath$userTablefileName';
    final map = await _client.fecth(filePath);
    final userInfoListModel = UserInfoListModel.fromJson(map);
    return userInfoListModel.userList;
  }

  Future<List<UserModel>> _getAllUsers() async {
    final basePath = FlavorConfig.instance.properties['dummy_json_data'];
    final filePath = '$basePath$userListfileName';

    final map = await _client.fecth(filePath);
    final userInfoListModel = UserListModel.fromJson(map);
    return userInfoListModel.userList;
  }

  Future<UserModel> resendOtp(
      {@required String token,
      @required String username,
      @required String airlineId,
      @required String corporateId}) async {
    //resend_otp_error_user
    await Future.delayed(Duration(seconds: 2));
    final errorUsername =
        FlavorConfig.instance.properties['resend_otp_error_user'];
    if (errorUsername == username) {
      return UserModel(
          status: StatusModel(
        statusCode: '-1',
        statusDescription: 'Failed to send OTP',
      ));
    } else {
      final counterState =
          await resendOtpValidatioAttemptsCounter.nextAttempt();

      switch (counterState) {
        case AttemptsCounterState.onLock:
          resendOtpValidatioAttemptsCounter.reset();
          return UserModel(
            status: StatusModel(
              statusCode: '-2',
              statusDescription: 'User account is locked',
            ),
          );
          break;
        case AttemptsCounterState.onRemainingAttempt:
          final attemptsRemaining =
              resendOtpValidatioAttemptsCounter.attemptsRemaining;
          return UserModel(
              status: StatusModel(
                statusCode: '0',
                statusDescription: 'OTP is sent to you email address',
              ),
              noOfAttemptsRemaining: '${attemptsRemaining}');
          break;
        case AttemptsCounterState.onConsicuttiveAttempt:
          return UserModel(
            status: StatusModel(
              statusCode: '-1',
              statusDescription: 'The authentication failed',
            ),
          );
          break;
        default:
          return UserModel(
              status: StatusModel(
            statusCode: '-1',
            statusDescription: 'The authentication failed',
          ));
      }
    }
  }

  Future<UserModel> validateOtp(
      {@required String token,
      @required String userName,
      @required String corporateId,
      @required String airlineId,
      @required String otp}) async {
    ///   "valide_otp": "4856",
    /// "expired_otp": "7834"
    await Future.delayed(Duration(seconds: 3));
    final validOtp = FlavorConfig.instance.properties['valide_otp'];
    final expiredOtp = FlavorConfig.instance.properties['expired_otp'];
    final changePasswordUsername =
        FlavorConfig.instance.properties['change_password_user'];

    if (validOtp == otp) {
      otpValidatioAttemptsCounter.reset();

      if (changePasswordUsername == userName) {
        return UserModel(
            status: StatusModel(
          statusCode: '-3',
          statusDescription:
              'Authentication is successful and change password has to be done.',
        ));
      } else {
        return UserModel(
            status: StatusModel(
          statusCode: '0',
          statusDescription: 'Authentication is successful',
        ));
      }
    } else if (expiredOtp == otp) {
      otpValidatioAttemptsCounter.reset();
      return UserModel(
          status: StatusModel(
        statusCode: '-4',
        statusDescription: 'OTP has expired, please request a new one.',
      ));
    } else {
      final counterState = await otpValidatioAttemptsCounter.nextAttempt();

      switch (counterState) {
        case AttemptsCounterState.onLock:
          otpValidatioAttemptsCounter.reset();
          return UserModel(
            status: StatusModel(
              statusCode: '-2',
              statusDescription: 'User account is locked',
            ),
          );
          break;
        case AttemptsCounterState.onRemainingAttempt:
          final attemptsRemaining =
              otpValidatioAttemptsCounter.attemptsRemaining;
          return UserModel(
              status: StatusModel(
                statusCode: '-1',
                statusDescription: 'Username or password is wrong',
              ),
              noOfAttemptsRemaining: '${attemptsRemaining}');
          break;
        case AttemptsCounterState.onConsicuttiveAttempt:
          return UserModel(
            status: StatusModel(
              statusCode: '-1',
              statusDescription: 'The authentication failed',
            ),
          );
          break;
        default:
          return UserModel(
              status: StatusModel(
            statusCode: '-1',
            statusDescription: 'The authentication failed',
          ));
      }
    }
  }

  Future<UserModel> authenticate(
      {@required String username,
      @required String password,
      @required String corporateId,
      @required String airlineId}) async {
    final userTable = await _getUserInfoTable();
    final userInfo = userTable.firstWhere(
        (element) =>
            element.password == password && element.username == username,
        orElse: () {
      return null;
    });
    if (userInfo == null) {
      final error = await _isUserNameIsCorrect(username, userTable);
      return error;
    }
    final users = await _getAllUsers();
    final int userId = int.parse(userInfo.userId);
    final user = users[userId];
    return user;
  }

  /// For demo purpose
  ///
  ///
  ///

  Future<UserModel> _isUserNameIsCorrect(
      String username, List<UserTableInfoModel> userTable) async {
    final userInfo = userTable
        .firstWhere((element) => element.username == username, orElse: () {
      return null;
    });
    if (userInfo == null) {
      authenticateUserAttemptsCounter.reset();
      return UserModel(
          status: StatusModel(
        statusCode: '-1',
        statusDescription: 'Username or password is wrong',
      ));
    } else {
      final attemptsCounterState =
          await authenticateUserAttemptsCounter.nextAttempt();
      switch (attemptsCounterState) {
        case AttemptsCounterState.onLock:
          authenticateUserAttemptsCounter.reset();
          return UserModel(
              status: StatusModel(
            statusCode: '-2',
            statusDescription: 'User account is locked',
          ));

          break;
        case AttemptsCounterState.onRemainingAttempt:
          final attemptsRemaining =
              authenticateUserAttemptsCounter.attemptsRemaining;
          return UserModel(
              status: StatusModel(
                statusCode: '-1',
                statusDescription: 'Username or password is wrong',
              ),
              noOfAttemptsRemaining: '${attemptsRemaining}');
          break;
        case AttemptsCounterState.onConsicuttiveAttempt:
          return UserModel(
              status: StatusModel(
            statusCode: '-1',
            statusDescription: 'Username or password is wrong',
          ));
          break;

        default:
          return UserModel(
              status: StatusModel(
            statusCode: '-1',
            statusDescription: 'Username or password is wrong',
          ));
      }
    }
  }
}

enum AttemptsCounterState { onLock, onConsicuttiveAttempt, onRemainingAttempt }

class AttemptsCounter {
  AttemptsCounter(
      {@required this.lockAttempts, @required this.permittedAttempts}) {
    _attemptsRemaining =
        (lockAttempts + permittedAttempts) - _consicuttiveAttempts;
  }
  final int lockAttempts;
  final int permittedAttempts;

  int get attemptsRemaining {
    return _attemptsRemaining;
  }

  int _consicuttiveAttempts = 0;
  int _attemptsRemaining;

  void reset() {
    _consicuttiveAttempts = 0;
    _attemptsRemaining =
        (lockAttempts + permittedAttempts) - _consicuttiveAttempts;
  }

  Future<AttemptsCounterState> nextAttempt() async {
    _consicuttiveAttempts++;
    if (permittedAttempts == 0) {
      _attemptsRemaining = lockAttempts - _consicuttiveAttempts;
      if (_attemptsRemaining == 0) {
        return AttemptsCounterState.onLock;
      } else {
        return AttemptsCounterState.onRemainingAttempt;
      }
    } else if (_consicuttiveAttempts >= permittedAttempts) {
      _attemptsRemaining =
          (lockAttempts + permittedAttempts) - _consicuttiveAttempts;
      if (_attemptsRemaining == 0) {
        return AttemptsCounterState.onLock;
      } else {
        return AttemptsCounterState.onRemainingAttempt;
      }
    } else {
      return AttemptsCounterState.onConsicuttiveAttempt;
    }
  }
}
