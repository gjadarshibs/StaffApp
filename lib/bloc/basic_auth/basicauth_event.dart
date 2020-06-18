part of 'basicauth_bloc.dart';

abstract class BasicAuthEvent extends Equatable {
  const BasicAuthEvent();
}

class BasicauthStartedDisplay extends BasicAuthEvent {
  @override
  List<Object> get props => [];
}

class BasicAuthSubmitted extends BasicAuthEvent {
  BasicAuthSubmitted({@required this.username, @required this.password});
  final String username;
  final String password;
  @override
  List<Object> get props => [username, password];
}

class BasicAuthUserSwitched extends BasicAuthEvent {
  @override
  List<Object> get props =>[];
  
}
