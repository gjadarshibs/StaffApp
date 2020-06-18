import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifly_corporate_app/bloc/two_factor_auth/twofactorauth_bloc.dart';

class TwoFactorAuthErrorCard extends StatefulWidget {
  @override
  _TwoFactorAuthErrorCardState createState() => _TwoFactorAuthErrorCardState();
}

class _TwoFactorAuthErrorCardState extends State<TwoFactorAuthErrorCard> {
  Widget _childForState(TwoFactorAuthState state) {
    if (state is TwoFactorAuthFaliure) {
      if (state.isUnlimitedAttemptsAvailable) {
        return Container(
           padding: EdgeInsets.only(bottom: 8.0),
          child: _errorCard(
            Text(
              'Invalid OTP.',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.onError),
            ),
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.only(bottom: 8.0),
          key: ValueKey(state.remainingAttempts),
          child: _errorCard(
            Text(
              'Invalid OTP, you have ${state.remainingAttempts} more attempt(s).',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.onError),
            ),
          ),
        );
      }
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget _errorCard(Widget text) {
    return Card(
      color: Theme.of(context).colorScheme.error,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/icn-info.svg',
              color: Colors.white,
              height: 32,
              width: 32,
            ),
            SizedBox(width: 4.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[text],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TwoFactorAuthBloc, TwoFactorAuthState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 350),
          child: _childForState(state),
        );
      },
    );
  }
}
