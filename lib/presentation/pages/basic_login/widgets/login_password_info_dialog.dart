import 'package:flutter/material.dart';

class LoginPasswordInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      title: Text('Password Information'),
      content: SingleChildScrollView(
        child: Text(
          "Please note your password for Staff Travel is unique and is not synchronised with other Etihad Group passwords. After 5 unsuccessful password attempts, your account will be locked. If you are unsure of your password, please click on the 'Forgot your password' link above to reset your password. I f you are still having issues accessing Staff Travel, contact the Etihad IT Service Centre on +xx xxxxx or extxxxx. This service is available 24 hours a day/ 7 days a week. The Etihad IT Service Centre is able only to assist with system access issues (including password resets) and not with Etihad Staff Travel bookings",
          style:
              TextStyle(height: 1.4, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 12.0, bottom: 8.0),
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Color(0xFF159697))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CLOSE',
                style: TextStyle(color: Color(0xFF159697)),
              )),
        )
      ],
    );
  }
}
