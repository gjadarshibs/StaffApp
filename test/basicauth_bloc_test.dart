import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/bloc/basic_auth/basicauth_bloc.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockCorporateRepository extends Mock implements CorporateRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository userRepository;
  BasicauthBloc basicauthBloc;
  MockCorporateRepository corporateRepository;

  setUp(() {
    userRepository = MockUserRepository();
    corporateRepository = MockCorporateRepository();
    authenticationBloc = AuthenticationBloc(
        corporateRepository: corporateRepository,
        userRepository: userRepository);
    basicauthBloc = BasicauthBloc(
        corporateRepository: corporateRepository,
        authenticationBloc: authenticationBloc,
        userRepository: userRepository);
  });

  tearDown(() {
    basicauthBloc.close();
  });

  test('initial State is tested', () {
    expect(basicauthBloc.initialState, BasicAuthInitial());
  });

  CorporatePreference corporatePreferencemodel = CorporatePreference(
      airlineCode: 'airlinecode',
      airlineLogo: '',
      airlineName: '',
      companyCode: 'companycode',
      companyLogo: '',
      companyName: '',
      webServiceUrl: '',
      desktopUrl: 'url',
      authCount: '',
      authMode: '');
  group('App starting event', () {
    blocTest('App Started', act: (bloc) {
      return bloc.add(BasicauthStartedDisplay());
    }, build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      return basicauthBloc;
    }, expect: [
      BasicAuthDetailDisplay(
          airlineLogo: corporatePreferencemodel.airlinesLogo(),
          corporateLogo: corporatePreferencemodel.corporatesLogo(),
          desktopUrl: corporatePreferencemodel.desktopUrl)
    ]);
  });

  group('User Switched', () {
    blocTest('User Switched', act: (bloc) {
      return bloc.add(BasicAuthUserSwitched());
    }, build: () async {
      return basicauthBloc;
    }, expect: []);
  });

  group('User Credentials Submitted', () {
    group('Two Fcator Authentication Dependent', () {
      UserModel twoFactorNeededResponseModel = UserModel(
          status: StatusModel(statusCode: '0', statusDescription: ''),
          twoFactorAuthNeeded: 'Y',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '',
          userInfo: UserInfoModel());
      UserModel userSignedResponseModel = UserModel(
          status: StatusModel(statusCode: '0', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '',
          userInfo: UserInfoModel());
      blocTest('User Credentials Verified and Two Factor Authentication needed',
          act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'valid-email', password: 'valid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'valid-email',
                password: 'valid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => twoFactorNeededResponseModel);
        return basicauthBloc;
      }, expect: [BasicAuthInProgress(), BasicAuthInitiateTwoFactorAuth()]);

      blocTest(
          'User Credentials Verified and Two Factor Authentication not needed',
          act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'valid-email', password: 'valid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'valid-email',
                password: 'valid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => userSignedResponseModel);
        return basicauthBloc;
      }, expect: [BasicAuthInProgress(), BasicAuthSuccess()]);
    });

    group('Change password factor', () {
      UserModel changePasswordResponseModel = UserModel(
          status: StatusModel(statusCode: '-3', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '',
          userInfo: UserInfoModel());
      blocTest('User Credentials Verified and Change Password needed',
          act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'valid-email', password: 'valid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'valid-email',
                password: 'valid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => changePasswordResponseModel);
        return basicauthBloc;
      }, expect: [BasicAuthInProgress(), BasicAuthInitiateChangePassword()]);
    });

    group('Account locked or Access Denied by Admin', () {
      UserModel acessDeniedModelResponse = UserModel(
          status: StatusModel(statusCode: '-6', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '',
          userInfo: UserInfoModel());
      UserModel accountLockedModelResponse = UserModel(
          status: StatusModel(statusCode: '-2', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '',
          userInfo: UserInfoModel());
      blocTest('Access Denied by Admin', act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'valid-email', password: 'valid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'valid-email',
                password: 'valid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => acessDeniedModelResponse);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthDenied(
            reason: BasicAuthDenialReason.deniedByAdmin,
            reasonDescription: acessDeniedModelResponse.customErrorMessage)
      ]);

      blocTest('User Account Locked', act: (bloc) {
        return bloc
            .add(BasicAuthSubmitted(username: 'email', password: 'password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'email',
                password: 'password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => accountLockedModelResponse);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthDenied(
            reason: BasicAuthDenialReason.accountLocked,
            reasonDescription:
                'Account is locked, please contact system admin.')
      ]);
    });

    group('Email Id not Configured', () {
      UserModel emailNotConfiguredModelResponse = UserModel(
          status: StatusModel(statusCode: '-4', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '',
          userInfo: UserInfoModel());
      blocTest('User Email Id not Configured', act: (bloc) {
        return bloc
            .add(BasicAuthSubmitted(username: 'email', password: 'password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'email',
                password: 'password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => emailNotConfiguredModelResponse);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthDenied(
            reason: BasicAuthDenialReason.noEmailConfigured,
            reasonDescription: 'Email ID is not configured to send the OTP.')
      ]);
    });

    group('Invalid Credentials and Retry Attempts', () {
      UserModel noAttemptRemainingResponseModel = UserModel(
          status: StatusModel(statusCode: '-1', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: null,
          userInfo: UserInfoModel());
      UserModel maxAttemptsReachedResponseModel = UserModel(
          status: StatusModel(statusCode: '-1', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '-1',
          userInfo: UserInfoModel());
      UserModel attemptsRemainingResponseModel = UserModel(
          status: StatusModel(statusCode: '-1', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '2',
          userInfo: UserInfoModel());
      blocTest(
          'Invalid Credentials and no attempt to retry is given to the account',
          act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'invalid-email', password: 'invalid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'invalid-email',
                password: 'invalid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => noAttemptRemainingResponseModel);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthFailure(
            isUnlimitedAttemptsAvailable: true,
            failureDescription: 'Invalid username/password.')
      ]);

      blocTest('Invalid Credentials and maximum attempts reached', act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'invalid-email', password: 'invalid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'invalid-email',
                password: 'invalid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => maxAttemptsReachedResponseModel);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthFailure(
            isUnlimitedAttemptsAvailable: true,
            failureDescription: 'Invalid username/password.')
      ]);

      blocTest('Invalid Credentials and attempts remaining', act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'invalid-email', password: 'invalid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'invalid-email',
                password: 'invalid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => attemptsRemainingResponseModel);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthFailure(
            isUnlimitedAttemptsAvailable: false,
            remainingAttempts:
                int.parse(attemptsRemainingResponseModel.noOfAttemptsRemaining))
      ]);
    });

    group('Google Recaptcha', () {
      UserModel googleRecaptchaResponseModel = UserModel(
          status: StatusModel(statusCode: '-5', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: 'Y',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '2',
          userInfo: UserInfoModel());
      UserModel noGoogleRecaptchaResponseModel = UserModel(
          status: StatusModel(statusCode: '-5', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '2',
          userInfo: UserInfoModel());
      blocTest('Too many Attempts and google Recaptcha is provided',
          act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'invalid-email', password: 'invalid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'invalid-email',
                password: 'invalid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => googleRecaptchaResponseModel);
        return basicauthBloc;
      }, expect: [BasicAuthInProgress(), BasicAuthInitiateGoogleRecaptcha()]);

      blocTest('Too many Attempts and google Recaptcha not provided',
          act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'invalid-email', password: 'invalid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'invalid-email',
                password: 'invalid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => noGoogleRecaptchaResponseModel);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthFailure(
            isUnlimitedAttemptsAvailable: true,
            failureDescription: 'Invalid username/password.')
      ]);
    });

    group('Error Response', () {
      UserModel errorResponseModel = UserModel(
          status: StatusModel(statusCode: '', statusDescription: ''),
          twoFactorAuthNeeded: 'N',
          googleRecaptcha: '',
          token: '',
          customErrorMessage: '',
          noOfAttemptsRemaining: '2',
          userInfo: UserInfoModel());
      blocTest('Response not Given', act: (bloc) {
        return bloc.add(BasicAuthSubmitted(
            username: 'invalid-email', password: 'invalid-password'));
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => corporatePreferencemodel);
        when(userRepository.authenticate(
                username: 'invalid-email',
                password: 'invalid-password',
                airlineId: corporatePreferencemodel.airlineCode,
                corporateId: corporatePreferencemodel.companyCode))
            .thenAnswer((_) async => errorResponseModel);
        return basicauthBloc;
      }, expect: [
        BasicAuthInProgress(),
        BasicAuthTerminated(
            terminationDescription: 'Un unexpected error happened')
      ]);
    });
  });
}
