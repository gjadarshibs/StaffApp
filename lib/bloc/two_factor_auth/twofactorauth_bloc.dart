import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';

part 'twofactorauth_event.dart';
part 'twofactorauth_state.dart';

class TwoFactorAuthBloc extends Bloc<TwoFactorAuthEvent, TwoFactorAuthState> {
  TwoFactorAuthBloc(
      {@required CorporateRepository corporateRepository,
      @required UserRepository userRepository,})
      : assert(userRepository != null),
        assert(userRepository != null),
        _corporateRepository = corporateRepository,
        _userRepository = userRepository;

  final CorporateRepository _corporateRepository;
  final UserRepository _userRepository;

  @override
  TwoFactorAuthState get initialState => TwoFactorAuthInitial();

  @override
  Stream<TwoFactorAuthState> mapEventToState(
    TwoFactorAuthEvent event,
  ) async* {
    if (event is TwoFactorAuthStartedDisplay) {
      yield TwoFactorAuthDisableResend(timeLimit: 10);
    }

    if (event is TwoFactorAuthResendOtp) {
      yield* _initiateResendingOtp();
    }

    if (event is TwoFactorAuthValidateOtp) {
      yield* _initiateOtpValidation(event.otp);
    }
    if (event is TwoFactorAuthStartEditing) {
       yield ResendOtpOnEdit();
    }
  }

  Stream<TwoFactorAuthState> _initiateOtpValidation(String otp) async* {
    /// Show loading indicator.
    yield TwoFactorAuthInProgress();

    /// Fetch corporate information for validaring otp.
    final corporate = await _corporateRepository.getCorporatePreference();

    /// Calling validate otp service woth corporate info.
    final user = await _userRepository.validateOtp(
      otp: otp,
      corporateId: corporate.companyCode,
      airlineId: corporate.airlineCode,
    );
    final status = user.status.statusCode;
    switch (status) {
      case TwoFactorAuthStatus.success:
        yield TwoFactorAuthSuccess();
        break;
      case TwoFactorAuthStatus.changePassword:
        yield TwoFactorAuthInitiateChangePassword();
        break;
      case TwoFactorAuthStatus.codeExpired:
        yield TwoFactorAuthDenied(
          reason: TwoFactorAuthDenialReason.codeExpired,
          reasonDescription: 'OTP has expired, please request a new one.',
        );
        break;
      case TwoFactorAuthStatus.locked:
        yield TwoFactorAuthDenied(
          reason: TwoFactorAuthDenialReason.accountLocked,
          reasonDescription: 'Account is locked, please contact system admin.',
        );
        break;
      case TwoFactorAuthStatus.invalidCredentials:

        /// Checking the number of attempts remaining.
        if (user.noOfAttemptsRemaining != null) {
          /// There is no number of attempts is defined for the account, basic faliure error.
          if (user.noOfAttemptsRemaining == '-1') {
            yield TwoFactorAuthFaliure(
                isUnlimitedAttemptsAvailable: true,
                failureDescription: 'Invalid otp.');

            /// Finding the number of attempts is defined for the account,  basic faliure error with number of attempts remaning.
          } else {
            final int noOfRemainingAttemptes =
                int.parse(user.noOfAttemptsRemaining);
            yield TwoFactorAuthFaliure(
                isUnlimitedAttemptsAvailable: false,
                remainingAttempts: noOfRemainingAttemptes);
          }

          /// There is no number of attempts is defined for the account, basic faliure error.
        } else {
          yield TwoFactorAuthFaliure(
              isUnlimitedAttemptsAvailable: true,
              failureDescription: 'Invalid otp.');
        }
        break;
      default:
    }
  }

  Stream<TwoFactorAuthState> _initiateResendingOtp() async* {
    /// Show loading indicator.
    yield ResendOtpInProgress();
    /// Fetch corporate information for validaring otp.
    final corporate = await _corporateRepository.getCorporatePreference();
    final user = await _userRepository.resendOtp(
        corporateId: corporate.companyCode, airlineId: corporate.airlineCode);
    final status = user.status.statusCode;
    switch (status) {
      case TwoFactorAuthResendOtpStatus.success:
        final isTokenSaved = await _userRepository.updateToken(user.token);
        if (isTokenSaved) {
          yield TwoFactorAuthResendOptSuccess(
              noOfAttemptsRemaining: user.noOfAttemptsRemaining);
          await Future.delayed(Duration(seconds: 7)); 
          yield TwoFactorAuthDisableResend(timeLimit: 10);   
         /// Expected to not happen
        } else {
          yield TwoFactorAuthResendOptFaliure();
          await Future.delayed(Duration(seconds: 7)); 
          yield TwoFactorAuthDisableResend(timeLimit: 10); 
        }
        break;
      case TwoFactorAuthResendOtpStatus.locked:
        yield TwoFactorAuthResendOptLocked();
        break;
      case TwoFactorAuthResendOtpStatus.error:
        yield TwoFactorAuthResendOptFaliure();
        await Future.delayed(Duration(seconds: 7)); 
        yield TwoFactorAuthDisableResend(timeLimit: 10); 
        break;
      default:
    }
  }
}
