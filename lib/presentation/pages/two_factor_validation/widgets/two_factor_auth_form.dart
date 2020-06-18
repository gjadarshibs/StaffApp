import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/bloc/two_factor_auth/twofactorauth_bloc.dart';
import 'package:ifly_corporate_app/presentation/utils/progress_button.dart';

class TwoFactorAuthForm extends StatefulWidget {
  TwoFactorAuthForm({Key key}) : super(key: key);

  @override
  _TwoFactorAuthFormState createState() => _TwoFactorAuthFormState();
}

class _TwoFactorAuthFormState extends State<TwoFactorAuthForm> {
  final _formkey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();
  ProgressButtonState _buttonState = ProgressButtonState.normal;
  final _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: Color(0xFFdddddd)));

  final _errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: Colors.red));
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TwoFactorAuthBloc, TwoFactorAuthState>(
      bloc: BlocProvider.of<TwoFactorAuthBloc>(context),
      listener: (context, state) {
        if (state is TwoFactorAuthInProgress) {
          if (_buttonState == ProgressButtonState.normal) {
            setState(() {
              _buttonState = ProgressButtonState.onProgress;
            });
          }
        } else {
          if (_buttonState == ProgressButtonState.onProgress) {
            setState(() {
              _buttonState = ProgressButtonState.normal;
            });
          }
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is TwoFactorAuthInProgress,
          child: Container(
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      enabled: !(state is TwoFactorAuthInProgress),
                      enableInteractiveSelection:
                          !(state is TwoFactorAuthInProgress),
                      controller: _textFieldController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 20.0,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedErrorBorder: _errorBorder,
                        errorBorder: _errorBorder,
                        enabledBorder: _border,
                        disabledBorder: _border,
                        focusedBorder: _border,
                        hintText: '----',
                        hintStyle: TextStyle(fontSize: 24, letterSpacing: 10.0),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      validator: (val) => OTPFieldValidation.validate(val),
                      onChanged: (val) {
                        BlocProvider.of<TwoFactorAuthBloc>(context).add(
                          TwoFactorAuthStartEditing(otp: val),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProgressButtonFactory.authButton(
                        title: 'LOGIN',
                        state: _buttonState,
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            print('validate ${_textFieldController.text}');
                            BlocProvider.of<TwoFactorAuthBloc>(context).add(
                              TwoFactorAuthValidateOtp(
                                  otp: _textFieldController.text),
                            );
                          }
                        })
                  ],
                )),
          ),
        );
      },
    );
  }
}

class OTPFieldValidation {
  static String validate(String value) {
    return value.length < 4 ? 'Enter the full OTP Digits' : null;
  }
}
