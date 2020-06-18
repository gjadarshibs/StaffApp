import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/bloc/corporate_auth/corporate_bloc.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';

class MockCorporateRepository extends Mock implements CorporateRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository userRepository;
  CorporateAuthBloc corporateAuthBloc;
  MockCorporateRepository corporateRepository;

  setUp(() {
    userRepository = MockUserRepository();
    corporateRepository = MockCorporateRepository();
    authenticationBloc = AuthenticationBloc(
        corporateRepository: corporateRepository,
        userRepository: userRepository);
    corporateAuthBloc = CorporateAuthBloc(
        corporateRepository: corporateRepository,
        authenticationBloc: authenticationBloc);
  });

  tearDown(() {
    corporateAuthBloc?.close();
  });

  test('initial state is correct', () {
    expect(corporateAuthBloc.initialState, CorporateAuthInitial());
  });

  group('CorporateCode Submitted', () {
    final CorporateModel corporateModel = CorporateModel(
        status: StatusModel(statusCode: '0', statusDescription: ''),
        airlineCode: '',
        airlineName: '',
        airlineLogo: '',
        companyCode: '',
        companyLogo: '',
        companyName: '',
        webServiceUrl: '',
        desktopUrl: '',
        authMode: 'lcl',
        authCount: '1');
    final CorporateModel errorModel = CorporateModel(
        status: StatusModel(statusCode: '-1', statusDescription: ''),
        airlineCode: '',
        airlineName: '',
        airlineLogo: '',
        companyCode: '',
        companyLogo: '',
        companyName: '',
        webServiceUrl: '',
        desktopUrl: '',
        authMode: 'lcl',
        authCount: '1');
    blocTest('Corporate Identified', build: () async {
      when(corporateRepository.authenticate(corporateCode: 'valid-code'))
          .thenAnswer((_) async => corporateModel);
      authenticationBloc;
      return corporateAuthBloc;
    }, act: (bloc) {
      return bloc.add(CorporateAuthCodeSubmitted(corporatCode: 'valid-code'));
    }, expect: [
      CorporateAuthLoading(),
      CorporatAuthSucess(corporate: corporateModel),
    ]);

    blocTest('Corporate UnIdentified', build: () async {
      when(corporateRepository.authenticate(corporateCode: 'invalid-code'))
          .thenAnswer((_) async => errorModel);
      return corporateAuthBloc;
    }, act: (bloc) {
      return bloc.add(CorporateAuthCodeSubmitted(corporatCode: 'invalid-code'));
    }, expect: [
      CorporateAuthLoading(),
      CorporatAuthFailed(status: errorModel.status)
    ]);
  });
  group('When Corporate is switched', () {
    blocTest('Corporate is Switched', build: () async {
      return corporateAuthBloc;
    }, act: (bloc) {
      return bloc.add(CorporateAuthUserSwitched());
    }, expect: []);
  });

  blocTest('When Input fields in Corporate Login page is edited',
      build: () async {
    return corporateAuthBloc;
  }, act: (bloc) {
    return bloc.add(CorporateAuthStartEditing());
  }, expect: [CorporateAuthOnEdit()]);
}
