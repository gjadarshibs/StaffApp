import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';

part 'basicauth_event.dart';
part 'basicauth_state.dart';

class BasicauthBloc extends Bloc<BasicAuthEvent, BasicAuthState> {
  BasicauthBloc(
      {@required CorporateRepository corporateRepository, @required AuthenticationBloc authenticationBloc, @required UserRepository userRepository})
      : assert(userRepository != null),
        assert(corporateRepository != null),
        assert(authenticationBloc != null),
         _userRepository = userRepository,
        _corporateRepository = corporateRepository ,
        _authenticationBloc = authenticationBloc;
       

  final CorporateRepository _corporateRepository;
  final AuthenticationBloc _authenticationBloc;
  final UserRepository _userRepository;

  @override
  BasicAuthState get initialState => BasicAuthInitial();

  @override
  Stream<BasicAuthState> mapEventToState(
    BasicAuthEvent event,
  ) async* {
    if (event is BasicauthStartedDisplay) {
      final CorporatePreference corporate =
          await _corporateRepository.getCorporatePreference();
      yield BasicAuthDetailDisplay(
          airlineLogo: corporate.airlinesLogo(),
          corporateLogo: corporate.corporatesLogo(),
          desktopUrl: corporate.desktopUrl);
    }
    if (event is BasicAuthUserSwitched) {
       await _corporateRepository.clearCorporatePreference();
       _authenticationBloc.add(CorporateUnAuthenticated());
    }
    if (event is BasicAuthSubmitted) {
      yield* _initiateBasicAuthentication(event.username, event.password);
    }
  }

  Stream<BasicAuthState> _initiateBasicAuthentication(String username, String password)  async* {
    yield BasicAuthInProgress();
    /// Fetch corporate information for validaring otp.
    final corporate = await _corporateRepository.getCorporatePreference();
    final user = await _userRepository.authenticate(username: username, password: password, corporateId: corporate.companyCode, airlineId: corporate.airlineCode);
    final basicAuthStatus = user.status.statusCode;
    switch (basicAuthStatus) {
      /// Authentication is sucessfull, user may navigate to dashboard.
      case BasicAuthStatus.success:
      /// Checking if two factor authentication is need or not.
      /// if needed start the two factor auth procedure.
      /// Save user name.
      user.userInfo.username = username;
      if (user.twoFactorAuthNeeded == 'Y') {
        await _userRepository.updateUserPreference(user);
        yield BasicAuthInitiateTwoFactorAuth();
      /// else navigate user to the dashboard,   
      } else {
        await _userRepository.updateUserPreference(user);
        yield BasicAuthSuccess();
      }
      break;
      /// Authentication is sucessfull, but password need to be change.
      case BasicAuthStatus.changePassword:
      yield BasicAuthInitiateChangePassword();
      break;
      /// Authentication is sucessfull, but currenlty account can't access due to admin restriection.
      case BasicAuthStatus.acessDenied:
      yield BasicAuthDenied(reason: BasicAuthDenialReason.deniedByAdmin, reasonDescription: user.customErrorMessage);
      break;
      /// Authentication is sucessfull, but currenlty accounct is locked.
      case BasicAuthStatus.locked:
      yield BasicAuthDenied(reason: BasicAuthDenialReason.accountLocked, reasonDescription: 'Account is locked, please contact system admin.');
      break;
       /// Authentication is sucessfull, but no email configured.
      case BasicAuthStatus.configureEmail:
      yield BasicAuthDenied(reason: BasicAuthDenialReason.noEmailConfigured, reasonDescription: 'Email ID is not configured to send the OTP.');
      break;
      /// Authentication failed due to invalid username or password.
      case BasicAuthStatus.invalidCredentials:
      /// Checking the number of attempts remaining.
      if (user.noOfAttemptsRemaining != null) {
         /// There is no number of attempts is defined for the account, basic faliure error.  
        if (user.noOfAttemptsRemaining == '-1') {
           yield BasicAuthFailure(isUnlimitedAttemptsAvailable: true, failureDescription: 'Invalid username/password.');
        /// Finding the number of attempts is defined for the account,  basic faliure error with number of attempts remaning.  
        } else {
          final int noOfRemainingAttemptes = int.parse(user.noOfAttemptsRemaining);
          yield BasicAuthFailure(isUnlimitedAttemptsAvailable: false, remainingAttempts: noOfRemainingAttemptes);
        }
      /// There is no number of attempts is defined for the account, basic faliure error.  
      } else {
         yield BasicAuthFailure(isUnlimitedAttemptsAvailable: true, failureDescription: 'Invalid username/password.');
      }
      break;
      /// Authentication failed too many times due to invalid username or password, 
      /// so google recpitcha is need to contiuue.
      case BasicAuthStatus.tooManyAttempts:
      if (user.googleRecaptcha == 'Y') {
        yield BasicAuthInitiateGoogleRecaptcha();
      /// basic faliure error.    
      } else {
        yield BasicAuthFailure(isUnlimitedAttemptsAvailable: true, failureDescription :'Invalid username/password.');
      }
      break;
      default:
      yield BasicAuthTerminated(terminationDescription: 'Un unexpected error happened');
    }
  }
}
