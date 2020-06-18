
import 'package:flutter/foundation.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/providers/local_storage_provider.dart';
import 'package:ifly_corporate_app/data/providers/user_provider.dart';
enum UserLoginRememberOption {read, write, remove}
class UserRepository {
  UserRepository(
      {UserProvider userProvider, LocalStorageProvider localStorageProvider})
      : _userProvider = userProvider ?? UserProvider(),
        _localStorageProvider = localStorageProvider ?? LocalStorageProvider();

  final UserProvider _userProvider;
  final LocalStorageProvider _localStorageProvider;

  Future<UserPreference> getUserPreference() async {

    try {
       final user = await _localStorageProvider.read(LocalStorageEntity.user);
       return user;
    } catch (ex){
       rethrow;
    }
  }
    
    Future<bool> rememberLogin(UserLoginRememberOption option) async {
      switch (option) {
        case UserLoginRememberOption.read:
          return _localStorageProvider.isRememberLoginAdded();
          break;
          case UserLoginRememberOption.write:
          return _localStorageProvider.addRememberLogin();
          break;
          case UserLoginRememberOption.remove:
          return _localStorageProvider.removeRememberLogin();
          break;
        default:
         return false;
      }
    }
  

   Future<bool> clearUserPreference() async {
      try {
       final isRemoved = await _localStorageProvider.remove(LocalStorageEntity.user);
       return isRemoved;
    } catch (ex){
       rethrow;
    }
  }

  Future<bool> updateToken(String token) async {

    final userPreference = await getUserPreference();
    userPreference.token =  token;
    return _localStorageProvider.update(LocalStorageEntity.user, userPreference);
  }

  Future<bool> updateUserPreference(UserModel user) async {

    return _localStorageProvider.update(LocalStorageEntity.user, UserPreference.fromModel(model: user));
  }

   Future<UserModel> resendOtp({
    @required String corporateId,
    @required String airlineId,
  }) async {
    final user = await getUserPreference();
    return _userProvider.resendOtp(username: user.info.username ,corporateId: corporateId, airlineId: airlineId, token: user.token);
  }


   Future<UserModel> authenticate({
    @required String username,
    @required String password,
    @required String corporateId,
    @required String airlineId
  }) async {
    return _userProvider.authenticate(username: username, password: password, corporateId: corporateId, airlineId: airlineId);
  }

  Future<UserModel> validateOtp({
    @required String otp,
    @required String corporateId,
    @required String airlineId,
  }) async {
    final user = await getUserPreference();
    return _userProvider.validateOtp(otp: otp, corporateId: corporateId, airlineId: airlineId, token: user.token, userName: user.info.username);
  }


}
