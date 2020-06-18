part of 'corporate_bloc.dart';

abstract class CorporateAuthEvent extends Equatable {
  const CorporateAuthEvent();
}

class CorporateAuthCodeSubmitted extends CorporateAuthEvent {
  const CorporateAuthCodeSubmitted({@required this.corporatCode});
  final String corporatCode;
  @override
  List<Object> get props => [corporatCode];
  
}

class CorporateAuthStartEditing extends CorporateAuthEvent {
  CorporateAuthStartEditing({this.corporatCode});
  final String corporatCode;
  @override
  List<Object> get props => [];
}

class CorporateAuthUserSwitched extends CorporateAuthEvent {
  @override
  List<Object> get props => [];
}