import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/bloc/two_factor_auth/twofactorauth_bloc.dart';
import 'package:ifly_corporate_app/presentation/pages/two_factor_validation/widgets/otp_timer.dart';

abstract class ResendOtpButtonState extends Equatable {
  const ResendOtpButtonState();
}

class ResendOtpButtonEnableResendOption extends ResendOtpButtonState {
  ResendOtpButtonEnableResendOption();

  @override
  List<Object> get props => [];
}

class ResendOtpButtonRemainingTime extends ResendOtpButtonState {
  ResendOtpButtonRemainingTime({@required this.remainingTime});
  final int remainingTime;
  @override
  List<Object> get props => [remainingTime];
}

class ResendOtpButtonInProgress extends ResendOtpButtonState {
  ResendOtpButtonInProgress();
  @override
  List<Object> get props => [];
}

class ResendOtpButtonSuccess extends ResendOtpButtonState {
  ResendOtpButtonSuccess({@required this.remainingAttempts});
  final remainingAttempts;
  @override
  List<Object> get props => [];
}

class ResendOtpButtonFailure extends ResendOtpButtonState {
  ResendOtpButtonFailure();
  @override
  List<Object> get props => [];
}

class ResendOtpButtonLocked extends ResendOtpButtonState {
  ResendOtpButtonLocked();
  @override
  List<Object> get props => [];
}

/// Resend otp button.
class ResendOtpButton extends StatefulWidget {
  ResendOtpButton({this.onTap});
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() {
    return _ResendOtpButtonState();
  }
}

class _ResendOtpButtonState extends State<ResendOtpButton> {
  ResendOtpTimer _timer;
  ResendOtpButtonState _state = ResendOtpButtonEnableResendOption();
  Widget _childForState() {
    if (_state is ResendOtpButtonRemainingTime) {
      final __state = _state as ResendOtpButtonRemainingTime;
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Resend OTP in'),
            Text(
              ' ${__state.remainingTime}s',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    if (_state is ResendOtpButtonEnableResendOption) {
      return Container(
        child: Text(
          'Resend OTP',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      );
    }
    if (_state is ResendOtpButtonInProgress) {
      return Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primaryVariant),
                )),
            SizedBox(height: 8.0),
            Text('Resending OTP ...'),
          ],
        ),
      );
    }
    if (_state is ResendOtpButtonSuccess) {
        final __state = _state as ResendOtpButtonSuccess;
      return Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('OTP Sent!', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 16.0),
            Text('You have ${__state.remainingAttempts} more attempts'),
          ],
        ),
      );

    }

    if (_state is ResendOtpButtonFailure) {
      return Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('OTP sending failed!, Please try again', style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      );
    }
    if (_state is ResendOtpButtonLocked) {
      return Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Too many attempts, resend OTP is locked, Please contact your system admin.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
          ],
        ),
      );
    }
    return Container(
      child: Text('dsdsds'),
    );
  }
  @override void dispose() {
    _timer.dispode();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<TwoFactorAuthBloc, TwoFactorAuthState>(
      bloc: BlocProvider.of<TwoFactorAuthBloc>(context),
      listener: (context, state) {
        if (state is TwoFactorAuthDisableResend) {
          if (_timer != null) {
            _timer.dispode();
          }
          _timer = ResendOtpTimer(duration: state.timeLimit);
          _timer.start();
          _timer.resendOtpStates.map((event) {
            if (event == 0) {
              return ResendOtpButtonEnableResendOption();
            } else {
              return ResendOtpButtonRemainingTime(remainingTime: event);
            }
          }).listen((event) {
            setState(() {
              _state = event;
            });
          });
        }

        if (state is ResendOtpInProgress) {
          setState(() {
            _state = ResendOtpButtonInProgress();
          });
        }

        if (state is ResendOtpInProgress) {
          setState(() {
            _state = ResendOtpButtonInProgress();
          });
        }

        if (state is TwoFactorAuthResendOptSuccess) {
          setState(() {
            _state = ResendOtpButtonSuccess(
                remainingAttempts: state.noOfAttemptsRemaining);
          });
        } 
        if (state is TwoFactorAuthResendOptFaliure) {
           setState(() {
            _state = ResendOtpButtonFailure();
          });
        }

        if (state is TwoFactorAuthResendOptLocked) {
           setState(() {
            _state = ResendOtpButtonLocked();
          });
        }

      },
      child: AbsorbPointer(
        absorbing: !(_state is ResendOtpButtonEnableResendOption),
        child: Material(
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              height: 80.0,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[_childForState()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
