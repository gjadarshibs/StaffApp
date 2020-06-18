import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/bloc/basic_auth/basicauth_bloc.dart';
import 'package:ifly_corporate_app/presentation/navigators/auth_navigator.dart';
import 'package:ifly_corporate_app/presentation/utils/auth_dialogs.dart';
import 'package:ifly_corporate_app/presentation/utils/botton_sheet/selection_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_password_info_dialog.dart';

class LoginEventHandler {
  LoginEventHandler({@required this.context, BasicauthBloc basicAuthBloc})
      : _basicAuthBloc = basicAuthBloc;
  BuildContext context;
  final BasicauthBloc _basicAuthBloc;
  String _desktopUrl;

  void bottomSheetAction(int index) async {
    switch (index) {
      case 0:
        await showDialog(
            context: context, builder: (context) => LoginPasswordInfoDialog());
        break;
      case 1:
        _basicAuthBloc.add(BasicAuthUserSwitched());
        break;
      case 2:
        try {
          await _launchInBrowser(_desktopUrl);
        } catch (exception) {
          _showLaunchErrorDialog(_desktopUrl);
        }
        break;
      default:
    }
  }

  void _showLaunchErrorDialog(String failedUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Failed To Launch',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text('Sorry, failed to launch desktop website $failedUrl'),
          actions: [
            FlatButton(
              child: Text('OK', style: TextStyle(color: Color(0xFF159697))),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void updateDesktopUrl(BasicAuthState state) {
    if (state is BasicAuthDetailDisplay) {
      _desktopUrl = state.desktopUrl;
    }
  }

  void showBasicAuthDenialAlert(BasicAuthDenied state) {

    switch (state.reason) {
      case BasicAuthDenialReason.accountLocked:
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AuthAlertDialog.dialogs(
              alert: BasicAuthAlertDialogType.accountLocked,
              content: state.reasonDescription,
              actions: <Widget>[
                FlatButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            );
          },
        );

        break;
      case BasicAuthDenialReason.noEmailConfigured:
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AuthAlertDialog.dialogs(
              alert: BasicAuthAlertDialogType.noEmail,
              content: state.reasonDescription,
              actions: <Widget>[
                FlatButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            );
          },
        );

        break;
      case BasicAuthDenialReason.deniedByAdmin:
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AuthAlertDialog.dialogs(
              alert: BasicAuthAlertDialogType.accessDenied,
              content: state.reasonDescription,
              actions: <Widget>[
                FlatButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            );
          },
        );

        break;
      default:
    }
  }

  void showForgotPasswordPage() {
    Navigator.of(context).pushNamed(AuthNavigator.forgotPasswordRoute);
  }

  void showMoreOptionSheet() {
    final Future<int> selectionIndex = showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      barrierColor: Colors.red.withOpacity(0),
      context: context,
      builder: (context) {
        return SelectionBottomSheet(
          title: 'More',
          aspectRatio: 1.2,
          sheetItems: SelectionBottomSheetItem.basicLoginBottonSheetItems(),
          onSelection: (item, index) {
            Navigator.pop(context, index);
          },
        );
      },
    );

    /// Making some delay to finish to bottom sheet close animation.
    /// otherwise some  exception is occuaring in navigator.
    selectionIndex.then((index) {
      Future.delayed(Duration(milliseconds: 400)).then((value) {
        print('selectionIndex = $index');
        bottomSheetAction(index);
      });
    });
  }
}
