part of 'twofactorauth_bloc.dart';

abstract class TwoFactorAuthState extends Equatable {
  const TwoFactorAuthState();
}

class TwoFactorAuthInitial extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}

class TwoFactorAuthInProgress extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}

class ResendOtpInProgress extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}

class ResendOtpOnEdit extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}

class TwoFactorAuthDisableResend extends TwoFactorAuthState {
  TwoFactorAuthDisableResend({@required this.timeLimit});
  final int timeLimit;
  @override
  List<Object> get props => [timeLimit];
}

class TwoFactorAuthResendOptSuccess extends TwoFactorAuthState {
  TwoFactorAuthResendOptSuccess({@required this.noOfAttemptsRemaining});
  final String noOfAttemptsRemaining;
  @override
  List<Object> get props => [noOfAttemptsRemaining];
}

class TwoFactorAuthResendOptFaliure extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}
class TwoFactorAuthResendOptLocked extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}

class TwoFactorAuthSuccess extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}

class TwoFactorAuthInitiateChangePassword extends TwoFactorAuthState {
  @override
  List<Object> get props => [];
}

enum TwoFactorAuthDenialReason {
  accountLocked,
  codeExpired
}

class TwoFactorAuthDenied extends TwoFactorAuthState {
  TwoFactorAuthDenied({@required this.reason, @required this.reasonDescription});
  final TwoFactorAuthDenialReason reason;
  final String reasonDescription;
  @override
  List<Object> get props => [reason, reasonDescription];
  
}

class TwoFactorAuthFaliure extends TwoFactorAuthState {
  TwoFactorAuthFaliure({@required this.isUnlimitedAttemptsAvailable, this.remainingAttempts = 0, this.failureDescription});
  final String failureDescription;
  final bool isUnlimitedAttemptsAvailable;
  final int remainingAttempts; 
  @override
  List<Object> get props => [isUnlimitedAttemptsAvailable, remainingAttempts];
}