import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/bloc/two_factor_auth/twofactorauth_bloc.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/navigators/auth_navigator.dart';
import 'package:ifly_corporate_app/presentation/pages/two_factor_validation/widgets/resend_otp_button.dart';
import 'package:ifly_corporate_app/presentation/pages/two_factor_validation/widgets/two_factor_auth_form.dart';
import 'package:ifly_corporate_app/presentation/pages/two_factor_validation/widgets/twofactorauth_error_card.dart';
import 'package:ifly_corporate_app/presentation/utils/auth_dialogs.dart';
import 'package:ifly_corporate_app/presentation/utils/scaffold_body.dart';

class TwoFactorValidationPage extends StatefulWidget {
  const TwoFactorValidationPage({
    @required corporateRepository,
    @required userRepository,
    Key key,
  })  : assert(corporateRepository != null),
        assert(userRepository != null),
        _corporateRepository = corporateRepository,
        _userRepository = userRepository,
        super(key: key);
        
  final CorporateRepository _corporateRepository;
  final UserRepository _userRepository;

  @override
  _TwoFactorValidationPageState createState() =>
      _TwoFactorValidationPageState();
}

class _TwoFactorValidationPageState extends State<TwoFactorValidationPage> {
  String otptextholder;
  bool otpsending = false;
  TwoFactorAuthBloc _twoFactorAuthBloc;
  @override
  void initState() {
    otptextholder = 'Resend OTP';
    super.initState();

    _twoFactorAuthBloc = TwoFactorAuthBloc(
        userRepository: widget._userRepository,
        corporateRepository: widget._corporateRepository);
  }

  void _navigateBackToLogin() {
         Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _twoFactorAuthBloc..add(TwoFactorAuthStartedDisplay()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
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
          child: BlocConsumer<TwoFactorAuthBloc, TwoFactorAuthState>(
              listener: (context, state) {
            /// Show Remember Login Screen
            if (state is TwoFactorAuthSuccess) {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(UserTwoFactorAuthCompleted());
            }

            if (state is TwoFactorAuthInitiateChangePassword) {
              Navigator.of(context).pushNamed(AuthNavigator.changePasswordRoute, arguments: true);
            }

            if (state is TwoFactorAuthDenied) {
              print('TwoFactorAuthFaliure');
              switch (state.reason) {
                case TwoFactorAuthDenialReason.accountLocked:
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
                  ).whenComplete((){
                    _navigateBackToLogin();
                  });
                  break;
                case TwoFactorAuthDenialReason.codeExpired:
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AuthAlertDialog.dialogs(
                        alert: BasicAuthAlertDialogType.codeExpired,
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
          }, builder: (context, state) {
            return ListView(
              padding: EdgeInsetsDirectional.fromSTEB(54.0, 45.0, 54.0, 16.0),
              children: <Widget>[
                Text(
                  'Enter OTP to Login',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                const SizedBox(height: 14.0),
                Text(
                  'An email has been sent to your registered Email ID with 4 digit OTP',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 23.0),
                TwoFactorAuthErrorCard(),
                Text(
                  'Enter OTP',
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                const SizedBox(height: 8.0),
                TwoFactorAuthForm(),
                ResendOtpButton(
                  onTap: () {
                    _twoFactorAuthBloc.add(TwoFactorAuthResendOtp());
                    //_twoFactorAuthBloc..add(TwoFactorAuthResendOtp());
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

///
