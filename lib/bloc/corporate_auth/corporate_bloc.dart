import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';

part 'corporate_event.dart';
part 'corporate_state.dart';

class CorporateAuthBloc extends Bloc<CorporateAuthEvent, CorporateAuthState> {
  CorporateAuthBloc(
      {@required this.corporateRepository, @required this.authenticationBloc})
      : assert(corporateRepository != null),
        assert(authenticationBloc != null);

  final CorporateRepository corporateRepository;
  final AuthenticationBloc authenticationBloc;

  @override
  CorporateAuthState get initialState => CorporateAuthInitial();

  @override
  Stream<CorporateAuthState> mapEventToState(
    CorporateAuthEvent event,
  ) async* {
    if (event is CorporateAuthCodeSubmitted) {
      yield CorporateAuthLoading();
      final CorporateModel corporateModel =
          await corporateRepository.authenticate(
        corporateCode: event.corporatCode,
      );
      if (corporateModel.status.statusCode == '0') {
        yield CorporatAuthSucess(corporate: corporateModel);
        authenticationBloc
            .add(CorporateAuthenticated(corporate: corporateModel));
      } else if (corporateModel.status.statusCode == '-1') {
        yield CorporatAuthFailed(status: corporateModel.status);
      }
    }
    if (event is CorporateAuthStartEditing) {
      yield CorporateAuthOnEdit();
    }

    if (event is CorporateAuthUserSwitched) {
      await corporateRepository.clearCorporatePreference();
      authenticationBloc.add(CorporateUnAuthenticated());
    }
  }
}
