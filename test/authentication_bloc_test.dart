import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockCorporateRepository extends Mock implements CorporateRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository userRepository;
  MockCorporateRepository corporateRepository;

  setUp(() {
    userRepository = MockUserRepository();
    corporateRepository = MockCorporateRepository();
    authenticationBloc = AuthenticationBloc(
        corporateRepository: corporateRepository,
        userRepository: userRepository);
  });

  tearDown(() {
    authenticationBloc.close();
  });

  test('initial state is correct', () {
    expect(
      authenticationBloc.initialState,
      isA<AuthenticationAdptiveSplash>(),
    );
  });
  CorporatePreference corporatePreferencemodel = CorporatePreference(
      airlineCode: 'QF',
      airlineLogo: '',
      airlineName: '',
      companyCode: 'corp001',
      companyLogo: '',
      companyName: '',
      webServiceUrl: '',
      desktopUrl: '',
      authCount: '1',
      authMode: 'LCL');

  CorporatePreference lclcorporatePreferencemodel = CorporatePreference(
      airlineCode: 'QF',
      airlineLogo: '',
      airlineName: '',
      companyCode: 'corp001',
      companyLogo: '',
      companyName: '',
      webServiceUrl: '',
      desktopUrl: '',
      authCount: '1',
      authMode: 'LCL');

  CorporatePreference ldapcorporatePreferencemodel = CorporatePreference(
      airlineCode: 'QF',
      airlineLogo: '',
      airlineName: '',
      companyCode: 'corp001',
      companyLogo: '',
      companyName: '',
      webServiceUrl: '',
      desktopUrl: '',
      authCount: '1',
      authMode: 'LDAP');

  CorporatePreference oktacorporatePreferencemodel = CorporatePreference(
      airlineCode: 'QF',
      airlineLogo: '',
      airlineName: '',
      companyCode: 'corp001',
      companyLogo: '',
      companyName: '',
      webServiceUrl: '',
      desktopUrl: '',
      authCount: '1',
      authMode: 'OKTA');

  CorporatePreference samlcorporatePreferencemodel = CorporatePreference(
      airlineCode: 'QF',
      airlineLogo: '',
      airlineName: '',
      companyCode: 'corp001',
      companyLogo: '',
      companyName: '',
      webServiceUrl: '',
      desktopUrl: '',
      authCount: '1',
      authMode: 'SAML');

  CorporatePreference multiplecorporatePreferencemodel = CorporatePreference(
      airlineCode: 'QF',
      airlineLogo: '',
      airlineName: '',
      companyCode: 'corp001',
      companyLogo: '',
      companyName: '',
      webServiceUrl: '',
      desktopUrl: '',
      authCount: '2',
      authMode: '');

  group('App starting event', () {
    blocTest('App starting into HomePage ', act: (bloc) {
      return bloc.add(AppStarted());
    }, build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.rememberLogin(UserLoginRememberOption.read))
          .thenAnswer((_) async => true);
      return authenticationBloc;
    }, expect: [
      isA<AuthenticationAdptiveSplash>(),
      AuthenticationUserIdentified()
    ]);

    blocTest('App starting into Basic Login Page ', act: (bloc) {
      return bloc.add(AppStarted());
    }, build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      when(userRepository.getUserPreference()).thenThrow(Exception());
      return authenticationBloc;
    }, expect: [
      isA<AuthenticationAdptiveSplash>(),
      AuthenticationCorporateIdentified(authType: AuthenticationType.lcl)
    ]);

    blocTest('App starting into Corporate Authentication Page', act: (bloc) {
      return bloc.add(AppStarted());
    }, build: () async {
      when(corporateRepository.getCorporatePreference()).thenThrow(Exception());
      return authenticationBloc;
    }, expect: [
      isA<AuthenticationAdptiveSplash>(),
      AuthenticationCorporateUnidentified(
          authType: AuthenticationType.corporate)
    ]);

    group('Corporate Authenticated', () {
      blocTest('Corporate has lcl authentication', act: (bloc) {
        return bloc.add(AppStarted());
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => lclcorporatePreferencemodel);
        when(userRepository.getUserPreference())
            .thenThrow((lclcorporatePreferencemodel));
        return authenticationBloc;
      }, expect: [
        isA<AuthenticationAdptiveSplash>(),
        AuthenticationCorporateIdentified(authType: AuthenticationType.lcl)
      ]);

      blocTest('Corporate has ldap authentication', act: (bloc) {
        return bloc.add(AppStarted());
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => ldapcorporatePreferencemodel);
        when(userRepository.getUserPreference())
            .thenThrow((ldapcorporatePreferencemodel));
        return authenticationBloc;
      }, expect: [
        isA<AuthenticationAdptiveSplash>(),
        AuthenticationCorporateIdentified(authType: AuthenticationType.ldap)
      ]);

      blocTest('Corporate has okta authentication', act: (bloc) {
        return bloc.add(AppStarted());
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => oktacorporatePreferencemodel);
        when(userRepository.getUserPreference())
            .thenThrow((oktacorporatePreferencemodel));
        return authenticationBloc;
      }, expect: [
        isA<AuthenticationAdptiveSplash>(),
        AuthenticationCorporateIdentified(authType: AuthenticationType.okta)
      ]);

      blocTest('Corporate has smal authentication', act: (bloc) {
        return bloc.add(AppStarted());
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => samlcorporatePreferencemodel);
        when(userRepository.getUserPreference())
            .thenThrow((samlcorporatePreferencemodel));
        return authenticationBloc;
      }, expect: [
        isA<AuthenticationAdptiveSplash>(),
        AuthenticationCorporateIdentified(authType: AuthenticationType.smal)
      ]);

      blocTest('Corporate has multiple authentication', act: (bloc) {
        return bloc.add(AppStarted());
      }, build: () async {
        when(corporateRepository.getCorporatePreference())
            .thenAnswer((_) async => multiplecorporatePreferencemodel);
        when(userRepository.getUserPreference())
            .thenThrow((multiplecorporatePreferencemodel));
        return authenticationBloc;
      }, expect: [
        isA<AuthenticationAdptiveSplash>(),
        AuthenticationCorporateIdentified(authType: AuthenticationType.multiple)
      ]);
    });

    blocTest('Corporate is not Authenticated', act: (bloc) {
      return bloc.add(AppStarted());
    }, build: () async {
      when(corporateRepository.getCorporatePreference())
          .thenThrow(corporatePreferencemodel);
      return authenticationBloc;
    }, expect: [
      isA<AuthenticationAdptiveSplash>(),
      AuthenticationCorporateUnidentified(
          authType: AuthenticationType.corporate)
    ]);
  });

  group('User Authentication', () {
    blocTest('User Authentication Succesful and remember', build: () async {
      when(userRepository.rememberLogin(UserLoginRememberOption.write))
          .thenAnswer((_) async => true);
      return authenticationBloc;
    }, act: (bloc) {
      return bloc.add(UserAuthenticated(needToRemeber: true));
    }, expect: [AuthenticationUserIdentified()]);

    blocTest('User Authentication Successful and not remember',
        build: () async {
      return authenticationBloc;
    }, act: (bloc) {
      return bloc.add(UserAuthenticated(needToRemeber: false));
    }, expect: [AuthenticationUserIdentified()]);

    blocTest('User Authentication Failed', build: () async {
      when(userRepository.rememberLogin(UserLoginRememberOption.remove))
          .thenAnswer((_) async => true);
      when(corporateRepository.getCorporatePreference())
          .thenAnswer((_) async => corporatePreferencemodel);
      return authenticationBloc;
    }, act: (bloc) {
      return bloc.add(UserUnauthenticated());
    }, expect: [
      isA<AuthenticationAdptiveSplash>(),
      AuthenticationCorporateIdentified(authType: AuthenticationType.lcl)
    ]);
  });
}
