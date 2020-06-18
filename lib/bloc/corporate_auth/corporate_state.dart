part of 'corporate_bloc.dart';

abstract class CorporateAuthState extends Equatable {
  const CorporateAuthState();
}

class CorporateAuthInitial extends CorporateAuthState {
  @override
  List<Object> get props => [];
 
}

class CorporateAuthLoading extends CorporateAuthState {
  @override
  List<Object> get props => [];
 
}

class CorporateAuthOnEdit extends CorporateAuthState {
  @override
  List<Object> get props => [];
}

class CorporatAuthSucess extends CorporateAuthState {
  CorporatAuthSucess({@required this.corporate});
  final CorporateModel corporate;
  @override
  List<Object> get props => [corporate];
 
}

class CorporatAuthFailed extends CorporateAuthState {
  CorporatAuthFailed({@required this.status});
  final StatusModel status;
  @override
  List<Object> get props => [status];
 
}