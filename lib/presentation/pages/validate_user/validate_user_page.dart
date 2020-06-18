import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/bloc/basic_auth/basicauth_bloc.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/login_event_handler.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/login_logo_header.dart';
import 'package:ifly_corporate_app/presentation/utils/progress_button.dart';
import 'package:ifly_corporate_app/presentation/utils/scaffold_body.dart';

class ValidateUserPage extends StatefulWidget {
  const ValidateUserPage({
    @required this.corporateRepository,
    @required this.userRepository,
    Key key,
  })  : assert(corporateRepository != null),
        assert(userRepository != null),
        super(key: key);
  final CorporateRepository corporateRepository;
  final UserRepository userRepository;
  @override
  _ValidateUserPageState createState() => _ValidateUserPageState();
}

class _ValidateUserPageState extends State<ValidateUserPage> {
  BasicauthBloc _basicAuthBloc;
  LoginEventHandler _eventHandler;

  Widget _form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
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
            hintText: 'Enter your username',
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
        ),
        SizedBox(
          height: 16,
        ),
        ProgressButton(
          state: ProgressButtonState.normal,
          type: ProgressButtonType.raised,
          backgroundColor: Color(0xFF159697),
          indicatorForgroundColor: Color(0xFF6ec1c4),
          indicatorBackgroundColor: Color(0xFF5ae1e6),
          indicatorHeightFactor: 0.8,
          title: Text(
            'Continue',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
          onPressed: () {
            print('onPressed');
          },
        ),
      ],
    );
  }

  Widget _header(BasicAuthState state) {
    return state is BasicAuthDetailDisplay
        ? LoginLogoHeader(
            airlineLogo: state.airlineLogo,
            corporateLogo: state.corporateLogo,
          )
        : const SizedBox();
  }

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _basicAuthBloc = BasicauthBloc(
        userRepository: widget.userRepository,
        authenticationBloc: authBloc,
        corporateRepository: widget.corporateRepository);
    _eventHandler =
        LoginEventHandler(context: context, basicAuthBloc: _basicAuthBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<BasicauthBloc>.value(
        value: _basicAuthBloc..add(BasicauthStartedDisplay()),
        child: ScaffoldBody(
          backgroundImage: 'assets/images/bg-login.jpg',
          child: BlocBuilder<BasicauthBloc, BasicAuthState>(
              builder: (blocContext, state) {
            _eventHandler.updateDesktopUrl(state);
            return ListView(
              children: <Widget>[
                _header(state),
                Container(
                  child: _form(),
                  padding: EdgeInsets.only(left: 34, right: 34),
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.only(left: 34, right: 34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: RawMaterialButton(
                              fillColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                // side: BorderSide(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(13),
                                child: Text(
                                  'Goto Website',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF159697)),
                                ),
                              ),
                              onPressed: () =>
                                  _eventHandler.bottomSheetAction(2)),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: RawMaterialButton(
                              fillColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                // side: BorderSide(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(13),
                                child: Text(
                                  'Switch User',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF159697)),
                                ),
                              ),
                              onPressed: () =>
                                  _eventHandler.bottomSheetAction(1)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
