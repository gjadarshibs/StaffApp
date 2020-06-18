import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/presentation/pages/change_password/change_password_page.dart';
import 'package:ifly_corporate_app/presentation/utils/progress_button.dart';

class RememberLoginButton extends StatefulWidget {
  RememberLoginButton({Key key}) : super(key: key);

  @override
  _RememberLoginButtonState createState() => _RememberLoginButtonState();
}

class _RememberLoginButtonState extends State<RememberLoginButton> {
  final ProgressButtonState _buttonState1 = ProgressButtonState.normal;
  final ProgressButtonState _buttonState2 = ProgressButtonState.normal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ProgressButton(
          state: _buttonState1,
          type: ProgressButtonType.raised,
          backgroundColor: Color(0xFF159697),
          indicatorForgroundColor: Color(0xFF6ec1c4),
          indicatorBackgroundColor: Color(0xFF5ae1e6),
          indicatorHeightFactor: 0.8,
          title: Expanded(
            child: Text(
              'Remember & Continue',
              style: TextStyle(color: Colors.white, fontSize: 16.0,),
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(
          height: 10,
        ),
        ProgressButton(
          state: _buttonState2,
          type: ProgressButtonType.raised,
          backgroundColor: Colors.white,
          indicatorForgroundColor: Color(0xFF6ec1c4),
          indicatorBackgroundColor: Color(0xFF5ae1e6),
          indicatorHeightFactor: 0.8,
          title: Text(
            'No Thanks',
            style: TextStyle(color: Color(0xFF159697), fontSize: 16.0),
          ),
          onPressed: () {
            print('onPressed');
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
          },
        ),
      ],
    );
  }
}
