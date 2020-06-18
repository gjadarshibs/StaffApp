part of 'twofactorauth_bloc.dart';

abstract class TwoFactorAuthEvent extends Equatable {
  const TwoFactorAuthEvent();
}
class TwoFactorAuthStartedDisplay extends TwoFactorAuthEvent {
  @override
  List<Object> get props => [];
}

class TwoFactorAuthResendOtp extends TwoFactorAuthEvent {
  @override
  List<Object> get props => [];
}

class TwoFactorAuthStartEditing extends TwoFactorAuthEvent {
  TwoFactorAuthStartEditing({this.otp});
  final String otp;
  @override
  List<Object> get props => [];
}

class TwoFactorAuthValidateOtp extends TwoFactorAuthEvent {
  TwoFactorAuthValidateOtp({@required this.otp});
  final String otp;
  @override
  List<Object> get props => [otp];
}