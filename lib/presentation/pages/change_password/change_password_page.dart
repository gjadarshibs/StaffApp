import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/presentation/utils/scaffold_body.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({this.isFromTwoFactorAuth = false});
  final bool isFromTwoFactorAuth;
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            if (widget.isFromTwoFactorAuth) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: 32.0,
            height: 32.0,
            child: SvgPicture.asset(
              'assets/images/icn-left-arrow.svg',
              height: 24.0,
              width: 24.0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
      body: ScaffoldBody.authSceneGradient(
          child: ListView(
        padding: EdgeInsetsDirectional.fromSTEB(54.0, 45.0, 54.0, 16.0),
        children: <Widget>[
          Text(
            'Reset Password',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ],
      )),
    );
  }
}
