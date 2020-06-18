import 'package:flutter/material.dart';

class LoginButtonBar extends StatelessWidget {
  LoginButtonBar(
      {this.height = 55.0,
      this.padding = EdgeInsets.zero,
      this.onForgotPassword,
      this.onMoreOption});

  final double height;
  final EdgeInsets padding;
  final Function onForgotPassword;
  final Function onMoreOption;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RawMaterialButton(
                fillColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Color(0xFF159697))),
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xFF159697)),
                  ),
                ),
                onPressed: onForgotPassword),
          ),
          SizedBox(
            width: 10.0,
          ),
          SizedBox(
            width: height,
            child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Color(0xFF159697))),
                fillColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: Container(
                    child: Text(
                      '...',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Color(0xFF159697)),
                    ),
                  ),
                ),
                onPressed: onMoreOption),
          ),
        ],
      ),
    );
  }
}
