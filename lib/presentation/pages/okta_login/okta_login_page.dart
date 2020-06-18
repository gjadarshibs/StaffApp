import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/bloc/basic_auth/basicauth_bloc.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/login_event_handler.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/login_logo_header.dart';
import 'package:ifly_corporate_app/presentation/utils/scaffold_body.dart';

class OktaLoginPage extends StatefulWidget {
  const OktaLoginPage({
    @required this.corporateRepository,
    @required this.userRepository,
    Key key,
  })  : assert(corporateRepository != null),
        assert(userRepository != null),
        super(key: key);
  final CorporateRepository corporateRepository;
  final UserRepository userRepository;
  @override
  _OktaLoginPageState createState() => _OktaLoginPageState();
}

class _OktaLoginPageState extends State<OktaLoginPage> {
  BasicauthBloc _basicAuthBloc;
  LoginEventHandler _eventHandler;
  
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
        authenticationBloc: authBloc,
        corporateRepository: widget.corporateRepository,
        userRepository: widget.userRepository);
     _eventHandler = LoginEventHandler(context: context, basicAuthBloc: _basicAuthBloc);
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
                  height: 150.0,
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      //side: BorderSide(color: Colors.grey),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'OKTA Authentication',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Color(0xFF159697)),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'OKTA auth is not supported by the current version of your app. So please use desktop option. Thanks!',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.only(left: 34.0, right: 34.0),
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
                      onPressed: () => _eventHandler.bottomSheetAction(2)),
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.only(left: 34.0, right: 34.0),
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
                      onPressed: () => _eventHandler.bottomSheetAction(1)),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
