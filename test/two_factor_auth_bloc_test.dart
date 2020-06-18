import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifly_corporate_app/bloc/two_factor_auth/twofactorauth_bloc.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockCorporateRepository extends Mock implements CorporateRepository {}

void main() {
  MockCorporateRepository corporateRepository;
  MockUserRepository userRepository;
  TwoFactorAuthBloc twoFactorAuthBloc;

  setUp(() {
    userRepository = MockUserRepository();
    corporateRepository = MockCorporateRepository();
    twoFactorAuthBloc = TwoFactorAuthBloc(
      corporateRepository: corporateRepository,
      userRepository: userRepository,
    );
  });

  tearDown(() {
    twoFactorAuthBloc.close();
  });

  test('Checking Initial State', () {
    expect(twoFactorAuthBloc.initialState, TwoFactorAuthInitial());
  });

  blocTest('Otp Screen Display Bloc', build: () async {
    return twoFactorAuthBloc;
  }, act: (bloc) {
    return bloc.add(TwoFactorAuthStartedDisplay());
  }, expect: [TwoFactorAuthDisableResend(timeLimit: 10)]);
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
  group('Otp send Success and Token is saved', () {
    UserModel otpsuccess = UserModel(
        status: StatusModel(statusCode: '0', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    blocTest('Otp send Sucessfully and Token is Saved', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.resendOtp(
              corporateId: corporatePreferencemodel.companyCode,
              airlineId: corporatePreferencemodel.airlineCode))
          .thenAnswer((_) async => otpsuccess);
      when(userRepository.updateToken(otpsuccess.token))
          .thenAnswer((realInvocation) async => true);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthResendOtp());
    }, expect: [
      ResendOtpInProgress(),
      TwoFactorAuthResendOptSuccess(
          noOfAttemptsRemaining: otpsuccess.noOfAttemptsRemaining),
      TwoFactorAuthDisableResend(timeLimit: 10)
    ]);

    blocTest('Otp send Sucessfully and Token is not Saved', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.resendOtp(
              corporateId: corporatePreferencemodel.companyCode,
              airlineId: corporatePreferencemodel.airlineCode))
          .thenAnswer((_) async => otpsuccess);
      when(userRepository.updateToken(otpsuccess.token))
          .thenAnswer((realInvocation) async => false);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthResendOtp());
    }, expect: [
      ResendOtpInProgress(),
      TwoFactorAuthResendOptFaliure(),
      TwoFactorAuthDisableResend(timeLimit: 10)
    ]);
  });

  group('Maximum OTP send', () {
    UserModel accountlockedmodel = UserModel(
        status: StatusModel(statusCode: '-2', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    blocTest('account locked', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.resendOtp(
              corporateId: corporatePreferencemodel.companyCode,
              airlineId: corporatePreferencemodel.airlineCode))
          .thenAnswer((_) async => accountlockedmodel);

      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthResendOtp());
    }, expect: [ResendOtpInProgress(), TwoFactorAuthResendOptLocked()]);
  });

  group('Error in OTP Sending', () {
    UserModel errormodel = UserModel(
        status: StatusModel(statusCode: '-1', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    blocTest('Error locked', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.resendOtp(
              corporateId: corporatePreferencemodel.companyCode,
              airlineId: corporatePreferencemodel.airlineCode))
          .thenAnswer((_) async => errormodel);

      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthResendOtp());
    }, expect: [
      ResendOtpInProgress(),
      TwoFactorAuthResendOptFaliure(),
      TwoFactorAuthDisableResend(timeLimit: 10)
    ]);
  });

  group('Otp Validation', () {
    UserModel successmodel = UserModel(
        status: StatusModel(statusCode: '0', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    UserModel changepasswordmodel = UserModel(
        status: StatusModel(statusCode: '-3', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    UserModel codeexpiredmodel = UserModel(
        status: StatusModel(statusCode: '-4', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    UserModel lockedmodel = UserModel(
        status: StatusModel(statusCode: '-2', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    UserModel invalidcredmodel = UserModel(
        status: StatusModel(statusCode: '-1', statusDescription: ''),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '3',
        userInfo: UserInfoModel());

    UserModel maxattemptreachedmodel = UserModel(
        status: StatusModel(statusCode: '-1', statusDescription: 'invalid OTP'),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: '-1',
        userInfo: UserInfoModel());

    UserModel noretryattemptsmodel = UserModel(
        status: StatusModel(statusCode: '-1', statusDescription: 'invalid OTP'),
        twoFactorAuthNeeded: 'N',
        googleRecaptcha: '',
        token: '',
        customErrorMessage: '',
        noOfAttemptsRemaining: null,
        userInfo: UserInfoModel());

    blocTest('Success', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.validateOtp(
        otp: '4856',
        corporateId: corporatePreferencemodel.companyCode,
        airlineId: corporatePreferencemodel.airlineCode,
      )).thenAnswer((_) async => successmodel);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthValidateOtp(otp: '4856'));
    }, expect: [TwoFactorAuthInProgress(), TwoFactorAuthSuccess()]);

    blocTest('And Change Password', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.validateOtp(
        otp: '4856',
        corporateId: corporatePreferencemodel.companyCode,
        airlineId: corporatePreferencemodel.airlineCode,
      )).thenAnswer((_) async => changepasswordmodel);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthValidateOtp(otp: '4856'));
    }, expect: [
      TwoFactorAuthInProgress(),
      TwoFactorAuthInitiateChangePassword()
    ]);

    blocTest('But Code Expired', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.validateOtp(
        otp: '4856',
        corporateId: corporatePreferencemodel.companyCode,
        airlineId: corporatePreferencemodel.airlineCode,
      )).thenAnswer((_) async => codeexpiredmodel);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthValidateOtp(otp: '4856'));
    }, expect: [
      TwoFactorAuthInProgress(),
      TwoFactorAuthDenied(
          reason: TwoFactorAuthDenialReason.codeExpired,
          reasonDescription: 'OTP has expired, please request a new one.')
    ]);

    blocTest('Account Locked', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.validateOtp(
        otp: '4856',
        corporateId: corporatePreferencemodel.companyCode,
        airlineId: corporatePreferencemodel.airlineCode,
      )).thenAnswer((_) async => lockedmodel);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthValidateOtp(otp: '4856'));
    }, expect: [
      TwoFactorAuthInProgress(),
      TwoFactorAuthDenied(
          reason: TwoFactorAuthDenialReason.accountLocked,
          reasonDescription: 'Account is locked, please contact system admin.')
    ]);

    blocTest('Inavlid OTP and Have attempts left', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.validateOtp(
        otp: '7956',
        corporateId: corporatePreferencemodel.companyCode,
        airlineId: corporatePreferencemodel.airlineCode,
      )).thenAnswer((_) async => invalidcredmodel);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthValidateOtp(otp: '7956'));
    }, expect: [
      TwoFactorAuthInProgress(),
      TwoFactorAuthFaliure(
          isUnlimitedAttemptsAvailable: false, remainingAttempts: 3)
    ]);

    blocTest('Inavlid OTP and Max Attempts Reached', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.validateOtp(
        otp: '7956',
        corporateId: corporatePreferencemodel.companyCode,
        airlineId: corporatePreferencemodel.airlineCode,
      )).thenAnswer((_) async => maxattemptreachedmodel);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthValidateOtp(otp: '7956'));
    }, expect: [
      TwoFactorAuthInProgress(),
      TwoFactorAuthFaliure(
          isUnlimitedAttemptsAvailable: true,
          failureDescription: 'Invalid otp.')
    ]);

    blocTest('Inavlid OTP and No Retry Attempts', build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.validateOtp(
        otp: '7956',
        corporateId: corporatePreferencemodel.companyCode,
        airlineId: corporatePreferencemodel.airlineCode,
      )).thenAnswer((_) async => noretryattemptsmodel);
      return twoFactorAuthBloc;
    }, act: (bloc) {
      return bloc.add(TwoFactorAuthValidateOtp(otp: '7956'));
    }, expect: [
      TwoFactorAuthInProgress(),
      TwoFactorAuthFaliure(
          isUnlimitedAttemptsAvailable: true,
          failureDescription: 'Invalid otp.')
    ]);
  });
}
