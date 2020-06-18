part of 'basicauth_bloc.dart';

abstract class BasicAuthState extends Equatable {
  const BasicAuthState();
}

class BasicAuthInitial extends BasicAuthState {
  // Corporate and airline info.
  @override
  List<Object> get props => [];
}

class BasicAuthDetailDisplay extends BasicAuthState {
  BasicAuthDetailDisplay(
      {@required this.corporateLogo,
      @required this.airlineLogo,
      @required this.desktopUrl});
  final String corporateLogo;
  final String airlineLogo;
  final String desktopUrl;
  // Corporate and airline info.
  @override
  List<Object> get props => [corporateLogo, airlineLogo, desktopUrl];
}

class BasicAuthInProgress extends BasicAuthState {
  @override
  List<Object> get props => [];
}

class BasicAuthSuccess extends BasicAuthState {
  @override
  List<Object> get props => [];
}

class BasicAuthFailure extends BasicAuthState {
  BasicAuthFailure({@required this.isUnlimitedAttemptsAvailable, this.remainingAttempts = 0, this.failureDescription});
  final String failureDescription;
  final bool isUnlimitedAttemptsAvailable;
  final int remainingAttempts; 
  @override
  List<Object> get props => [isUnlimitedAttemptsAvailable, remainingAttempts];
}

enum BasicAuthDenialReason {
  accountLocked,
  deniedByAdmin,
  noEmailConfigured
}

class BasicAuthDenied extends BasicAuthState {
  BasicAuthDenied({@required this.reason, @required this.reasonDescription});
  final BasicAuthDenialReason reason;
  final String reasonDescription;
  @override
  List<Object> get props => [reason, reasonDescription];
  
}

class BasicAuthInitiateTwoFactorAuth extends BasicAuthState {
  @override
  List<Object> get props => [];
}

class BasicAuthInitiateChangePassword extends BasicAuthState {
  @override
  List<Object> get props => [];
}

class BasicAuthInitiateGoogleRecaptcha extends BasicAuthState {
  @override
  List<Object> get props => [];
}

class BasicAuthTerminated extends BasicAuthState {
  BasicAuthTerminated({this.terminationDescription});
  final String terminationDescription; 
  @override
  List<Object> get props => [terminationDescription];
}


