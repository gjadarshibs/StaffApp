part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}
 /// This event is to notify the bloc that it needs to check the current user auth state.
class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}


class UserAuthenticated extends AuthenticationEvent {
  UserAuthenticated({@required this.needToRemeber});
  final bool needToRemeber;
  @override
  List<Object> get props => [needToRemeber];

}

class UserUnauthenticated extends AuthenticationEvent {
  @override

  List<Object> get props => [];
  
}
class CorporateAuthenticated extends AuthenticationEvent {
  CorporateAuthenticated({@required this.corporate});
  final CorporateModel corporate;
  @override
  List<Object> get props => [corporate];
  
}

class CorporateUnAuthenticated extends AuthenticationEvent {
  @override

  List<Object> get props => [];
  
}

class UserTwoFactorAuthCompleted extends AuthenticationEvent {
  @override

  List<Object> get props => [];
  
}