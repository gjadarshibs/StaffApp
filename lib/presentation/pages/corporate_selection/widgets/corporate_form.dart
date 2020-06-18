import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/bloc/corporate_auth/corporate_bloc.dart';
import 'package:ifly_corporate_app/presentation/utils/progress_button.dart';

class CorporateForm extends StatefulWidget {
  final Function errorfunction;

  CorporateForm({
    Key key,
    this.errorfunction,
  }) : super(key: key);

  @override
  _CorporateFormState createState() => _CorporateFormState();
}

class _CorporateFormState extends State<CorporateForm> {
  final TextEditingController _corporateFieldController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FocusNode _focus = FocusNode();
  bool errordisplay;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    errordisplay = false;
    widget.errorfunction(errordisplay);
  }

  String validate(String value) {
    if (value.isEmpty) {
      _onFocusChange();
      return 'Corporate Authentication code is mandatory';
    } else {
      return null;
    }
  }
  @override
  void dispose() {
   _corporateFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
      child: BlocConsumer<CorporateAuthBloc, CorporateAuthState>(
        listener: (contex, state) {
          if (state is CorporatAuthFailed) {
            setState(() {
              errordisplay = true;
              widget.errorfunction(errordisplay);
            });
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is CorporateAuthLoading,
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    focusNode: _focus,
                    controller: _corporateFieldController,
                     enabled: !(state is CorporateAuthLoading),
                    enableInteractiveSelection: !(state is CorporateAuthLoading),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Corporate Unique Code',
                      suffixIcon: Tooltip(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        preferBelow: false,
                        padding: EdgeInsets.all(10),
                        message:
                            'Enter a Unique Code provided by your company to authenticate the app',
                        child: IconButton(
                            iconSize: 40.0,
                            icon: Container(
                                child: SvgPicture.asset(
                              'assets/images/icn-info.svg',
                              color: Colors.grey,
                            )),
                            onPressed: () {}),
                      ),
                    ),
                    onChanged: (val) {
                      //
                      BlocProvider.of<CorporateAuthBloc>(context)
                          .add(CorporateAuthStartEditing(corporatCode: val));
                      _formkey.currentState.validate();
                    },
                    validator: (val) => validate(val),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ProgressButtonFactory.authButton(
                      title: 'AUTHENTICATE',
                      state: (state is CorporateAuthLoading)
                          ? ProgressButtonState.onProgress
                          : ProgressButtonState.normal,
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          if (!(state is CorporateAuthLoading)) {
                            BlocProvider.of<CorporateAuthBloc>(context).add(
                                CorporateAuthCodeSubmitted(
                                    corporatCode:
                                        _corporateFieldController.text));
                          }
                        }
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CorporateTextFieldValidation {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Corporate Authentication code is mandatory';
    } else {
      return null;
    }
  }
}
