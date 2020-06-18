import 'package:flutter/material.dart';

enum AuthAlertDialogType { normal, error }
enum BasicAuthAlertDialogType { noEmail, accountLocked, accessDenied, codeExpired }

class AuthAlertDialog extends StatelessWidget {

  AuthAlertDialog({
    @required title,
    @required content,
    @required List<Widget> actions,
    type = AuthAlertDialogType.normal,
    headingIcon,
  })  : _title = title,
        _content = content,
        _type = type,
        _actions = actions,
        _headingIcon = headingIcon;
        

  factory AuthAlertDialog.dialogs({
    @required BasicAuthAlertDialogType alert,
    @required String content,
    @required  List<Widget> actions,
  }) {
    switch (alert) {
      case BasicAuthAlertDialogType.noEmail:
        return AuthAlertDialog(
          content: content,
          title: 'No Email',
          type: AuthAlertDialogType.error,
          headingIcon: 'assets/images/icn-no-email.png',
          actions: actions,
        );
      case BasicAuthAlertDialogType.accountLocked:
        return AuthAlertDialog(
          content: content,
          title: 'Account Locked',
          type: AuthAlertDialogType.error,
          headingIcon: 'assets/images/icn-lock.png',
          actions: actions,
        );
      case BasicAuthAlertDialogType.accessDenied:
        return AuthAlertDialog(
          content: content,
          title: 'Access Denied',
          type: AuthAlertDialogType.error,
          headingIcon: 'assets/images/icn-no-access.png',
          actions: actions,
        );
        case BasicAuthAlertDialogType.codeExpired:
        return AuthAlertDialog(
          content: content,
          title: 'OTP Expired',
          type: AuthAlertDialogType.error,
          headingIcon: 'assets/images/icn-expired.png',
          actions: actions,
        );

      default:
        return AuthAlertDialog(
          content: content,
          title: '',
          actions: actions,
        );
    }
  }

  final AuthAlertDialogType _type;
  final String _content;
  final String _title;
  final String _headingIcon;
  final List<Widget> _actions;

  Color _headingColor(BuildContext context) {
    return _type == AuthAlertDialogType.error
        ? Theme.of(context).colorScheme.error
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          _headingIcon == null
              ? const SizedBox()
              : Image(
                  image: AssetImage(_headingIcon),
                  height: 22.0,
                  width: 22.0,
                  color: _headingColor(context),
                ),
          SizedBox(width: (_headingIcon == null) ? 0.0 : 8.0),
          Text(
            _title,
            style: TextStyle(color: _headingColor(context)),
          ),
        ],
      ),
      content: Text(_content),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      actionsPadding: EdgeInsets.only(right: 8.0),
      actions: _actions,
    );
  }
}
