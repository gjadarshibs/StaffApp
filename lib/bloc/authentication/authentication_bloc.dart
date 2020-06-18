import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/splash/splash_screen.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {@required CorporateRepository corporateRepository,
      @required UserRepository userRepository})
      : assert(corporateRepository != null),
        assert(userRepository != null),
        _corporateRepository = corporateRepository,
        _userRepository = userRepository;

  final CorporateRepository _corporateRepository;
  final UserRepository _userRepository;




  AuthenticationType _findAuthType(CorporateModel corporateModel) {

    final int authCount = int.parse(corporateModel.authCount) ?? 1;
    if (authCount == 1) {
      switch (corporateModel.authMode) {
        case UserAuthenticationType.lcl:
          return AuthenticationType.lcl;
        case UserAuthenticationType.ldap:
          return AuthenticationType.ldap;
        case UserAuthenticationType.smal:
          return AuthenticationType.smal;
        case UserAuthenticationType.okta:
          return AuthenticationType.okta;
        default:
          return AuthenticationType.undefined;
      }
    } else if (authCount > 1) {
      return AuthenticationType.multiple;
    } else {
      return AuthenticationType.undefined;
    }
  }

  Stream<AuthenticationState> _mapAppStartedToHome(
      CorporatePreference corporate) async* {
    yield AuthenticationAdptiveSplash(
        splashData: SplashScreenConfig.corporateAdaptive(
      corporateLogo: corporate.corporatesLogo(),
      airLineLogo: corporate.airlinesLogo(),
    ));
    await Future.delayed(Duration(seconds: 2));
    yield AuthenticationUserIdentified();
   
  }

  Stream<AuthenticationState> _mapAppStartedToUserAuth(
      CorporatePreference corporate) async* {
   yield AuthenticationAdptiveSplash(
        splashData: SplashScreenConfig.corporateAdaptive(
      corporateLogo: corporate.corporatesLogo(),
      airLineLogo: corporate.airlinesLogo(),
    ));
    await Future.delayed(Duration(seconds: 2));
    yield AuthenticationCorporateIdentified(authType: _findAuthType(corporate.toModel()));
  }

  Stream<AuthenticationState> _mapAppStartedToCorporateAuth() async* {
    yield AuthenticationAdptiveSplash(
        splashData: SplashScreenConfig.iflyCorporate());
    await Future.delayed(Duration(seconds: 2));
    yield AuthenticationCorporateUnidentified(authType: AuthenticationType.corporate);
  }

  @override
  AuthenticationState get initialState =>
      AuthenticationAdptiveSplash(splashData: SplashScreenConfig.basic());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    /// Checking in storage.
    if (event is AppStarted) {
      try {
        final CorporatePreference corporate =
            await _corporateRepository.getCorporatePreference();
        try {
          final isRemberLogin = await _userRepository.rememberLogin(UserLoginRememberOption.read);
          if (isRemberLogin) {
              yield* _mapAppStartedToHome(corporate);
          } else {
                 yield* _mapAppStartedToUserAuth(corporate);
          }
          // Show coporate  splash
          // then home screen
         
        //  yield* _mapAppStartedToHome(corporate);
        }  catch (ex) {
          // Show coporate  splash
          // then show user login
          yield* _mapAppStartedToUserAuth(corporate);
        }
      }  catch (ex) {
        // Show ifly splash
        // then show corporate login
        yield* _mapAppStartedToCorporateAuth();
      }
    }

    // Save corporate details into storage.
    if (event is CorporateAuthenticated) {
      await _corporateRepository.updateCorporatePreference(event.corporate);
      yield AuthenticationCorporateIdentified(authType: _findAuthType(event.corporate));
    }
    // Clear corporate details from storage and show corporate auth
    if (event is CorporateUnAuthenticated) {
       yield AuthenticationCorporateUnidentified(authType: AuthenticationType.corporate);
    }
    if (event is UserTwoFactorAuthCompleted) {
      yield AuthenticationFinishUserLogin();
    }
    // Save user details in to storage
    if (event is UserAuthenticated) {
      if (event.needToRemeber) {
       await  _userRepository.rememberLogin(UserLoginRememberOption.write);
      } 
      yield AuthenticationUserIdentified();

    }
    // Clear user details from the storage
    if (event is UserUnauthenticated) {
       await  _userRepository.rememberLogin(UserLoginRememberOption.remove);
        final CorporatePreference corporate =
            await _corporateRepository.getCorporatePreference();
        yield* _mapAppStartedToUserAuth(corporate);
    }
  }
}
