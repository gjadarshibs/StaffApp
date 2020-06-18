import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifly_corporate_app/bloc/basic_auth/basicauth_bloc.dart';

class BasicAuthValidationErrorModel {
  BasicAuthValidationErrorModel.empty() {
    _title = SizedBox(
      height: 22.0,
      width: double.infinity,
    );
    _icon = SizedBox(
      height: 30.0,
      width: 30,
    );
    _subTitle = SizedBox(
      height: 22.0,
      width: double.infinity,
    );
  }
  BasicAuthValidationErrorModel.wrongCredentials(
      {@required BasicAuthFailure state,
      errorColor = Colors.red,
      onErrorColor = Colors.white}) {
    if (state.isUnlimitedAttemptsAvailable) {
      _title = Text(
        'Invalid Credentials',
        style: TextStyle(color: onErrorColor, fontWeight: FontWeight.bold),
      );
      _subTitle = Text(
        state.failureDescription,
        style: TextStyle(color: onErrorColor, fontWeight: FontWeight.w600),
      );

      _icon = Image(
        image: AssetImage('assets/images/icn-alert.png'),
        height: 30.0,
        width: 30.0,
        color: onErrorColor,
      );
    } else {
//Too many failed login attempts, after 3 attempts your account will be locked.
      _title = RichText(
        text: TextSpan(
          style: TextStyle(color: onErrorColor),
          text: 'Too many',
          children: <TextSpan>[
            TextSpan(
              text: ' Failed Login',
              style:
                  TextStyle(color: onErrorColor, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ' attempts',
              style: TextStyle(
                color: onErrorColor,
              ),
            )
          ],
        ),
      );
      _subTitle = RichText(
        text: TextSpan(
          style: TextStyle(color: onErrorColor, fontWeight: FontWeight.w500),
          text: 'Invalid credentials, you have ',
          children: <TextSpan>[
            TextSpan(
              text: ' ${state.remainingAttempts}',
              style:
                  TextStyle(color: onErrorColor, fontWeight: FontWeight.w800),
            ),
             TextSpan(
              text: ' more attempt(s).',
              style:
                  TextStyle(color: onErrorColor, fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
      _icon = Image(
        image: AssetImage('assets/images/icn-vlidation-error.png'),
        height: 30.0,
        width: 30.0,
        color: onErrorColor,
      );
    }
  }

  Widget get title {
    return _title;
  }

  Widget get subTitle {
    return _subTitle;
  }

  Widget get icon {
    return _icon;
  }

  Widget _title;
  Widget _subTitle;
  Widget _icon;
}

class BasicAuthValidationErrorCards extends StatelessWidget {
  BasicAuthValidationErrorCards({@required this.errorModel});
  final BasicAuthValidationErrorModel errorModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Card(
        color: Theme.of(context).colorScheme.error,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/icn-info.svg',
                color: Colors.white,
                height: 35,
                width: 35,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    errorModel.subTitle
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
