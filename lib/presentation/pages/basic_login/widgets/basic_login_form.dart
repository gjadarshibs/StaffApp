import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/bloc/basic_auth/basicauth_bloc.dart';
import 'package:ifly_corporate_app/presentation/utils/progress_button.dart';

class BasicLoginForm extends StatefulWidget {
  BasicLoginForm({this.onEdit, Key key}) : super(key: key);

  final Function() onEdit;

  @override
  _BasicLoginFormState createState() => _BasicLoginFormState();
}

class _BasicLoginFormState extends State<BasicLoginForm> {
  final TextEditingController _usernameFieldController =
      TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _passwordinvisible = true;
  bool _isUsernameError = true;
  bool _isPasswordError = true;

  final _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: Colors.white));

  final _errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: Colors.white));

  Widget _suffixIcon(bool state) {
    final iconAsset = _passwordinvisible
        ? 'assets/images/icn-eye-slash.svg'
        : 'assets/images/icn-eye.svg';
    return IconButton(
      icon: SvgPicture.asset(
        iconAsset,
        height: 20,
        width: 20,
      ),
      onPressed: () {
        setState(() {
          _passwordinvisible = !_passwordinvisible;
        });
      },
    );
  }

  String passwordValidate(String value) {
    _isPasswordError = value.isEmpty;
    return value.isEmpty ? 'Password is mandatory.' : null;
  }

  String userNameValidate(String value) {
    _isUsernameError = value.isEmpty;
    return value.isEmpty ? 'Username is mandatory.' : null;
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _usernameFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BasicauthBloc, BasicAuthState>(
      listener: (context, state) {
        if (!(state is BasicAuthInProgress)) {
          Future.delayed(Duration(milliseconds: 200)).then((value) {
            _passwordFieldController.text = '';
          });
        }
  
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is BasicAuthInProgress,
          child: Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    enabled: !(state is BasicAuthInProgress),
                    enableInteractiveSelection: !(state is BasicAuthInProgress),
                    controller: _usernameFieldController,
                    validator: (val) => userNameValidate(val),
                    onChanged: (val) {
                      widget.onEdit();
                      if (_isUsernameError) {
                        _formkey.currentState.validate();
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedErrorBorder: _errorBorder,
                      errorBorder: _errorBorder,
                      enabledBorder: _border,
                      focusedBorder: _border,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    enabled: !(state is BasicAuthInProgress),
                    enableInteractiveSelection: !(state is BasicAuthInProgress),
                    controller: _passwordFieldController,
                    validator: (val) => passwordValidate(val),
                    onChanged: (val) {
                      widget.onEdit();
                      if (_isPasswordError) {
                        _formkey.currentState.validate();
                      }
                    },
                    obscureText: _passwordinvisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedErrorBorder: _errorBorder,
                      errorBorder: _errorBorder,
                      enabledBorder: _border,
                      focusedBorder: _border,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: _suffixIcon(_passwordinvisible),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProgressButtonFactory.authButton(
                      title: 'LOGIN',
                      state: state is BasicAuthInProgress
                          ? ProgressButtonState.onProgress
                          : ProgressButtonState.normal,
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                        
                          BlocProvider.of<BasicauthBloc>(context).add(
                              BasicAuthSubmitted(
                                  username: _usernameFieldController.text,
                                  password: _passwordFieldController.text));
                        }
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
