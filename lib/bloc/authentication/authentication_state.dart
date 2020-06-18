part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}
/// Waiting to see if the user is authenticated or not.
class AuthenticationUnidentified extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class AuthenticationAdptiveSplash extends AuthenticationState {
  AuthenticationAdptiveSplash({@required this.splashData});
  final SplashScreenConfig splashData;
  @override
  List<Object> get props => [splashData];
}
/// User selected the corporate by entering corporate unique id, but not logged in. 
class AuthenticationCorporateIdentified extends AuthenticationState {
  AuthenticationCorporateIdentified({@required this.authType});
  final AuthenticationType authType;
  @override
  List<Object> get props => [authType];
}
/// User didn't selected his corporate by entering corporate unique id,
/// provide an option to enter his corporate id.
class AuthenticationCorporateUnidentified extends AuthenticationState {
   AuthenticationCorporateUnidentified({@required this.authType});
  final AuthenticationType authType;
  @override
  List<Object> get props => [authType];
}
/// User selected the corporate, and also logged in sucessfully by login method. 
class AuthenticationUserIdentified extends AuthenticationState {
  @override
  List<Object> get props => [];
}
/// User is logouted from the app.
class AuthenticationUserUnidentified extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationFinishUserLogin extends AuthenticationState {
  @override
  List<Object> get props => [];
}