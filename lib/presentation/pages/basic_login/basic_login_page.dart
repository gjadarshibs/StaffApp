import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/bloc/basic_auth/basicauth_bloc.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/navigators/auth_navigator.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/basic_login_form.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/login_button_bar.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/login_logo_header.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/widgets/login_validation_error_card.dart';
import 'package:ifly_corporate_app/presentation/utils/scaffold_body.dart';
import 'widgets/login_event_handler.dart';

enum LoginComponent { header, error, form, buttons }

class BasicLoginPage extends StatefulWidget {
  const BasicLoginPage({
    @required this.corporateRepository,
    @required this.userRepository,
    Key key,
  })  : assert(corporateRepository != null),
        assert(userRepository != null),
        super(key: key);
  final CorporateRepository corporateRepository;
  final UserRepository userRepository;
  @override
  _BasicLoginPageState createState() => _BasicLoginPageState();
}

class _BasicLoginPageState extends State<BasicLoginPage> {
  
  BasicauthBloc _basicAuthBloc;
  LoginEventHandler _eventHandler;

  String _airlineLogo;
  String _corporateLogo;
  final absorbPointerKey = GlobalKey();

  final _basicLoginForm = GlobalKey();
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  BasicAuthValidationErrorModel _validationError =
      BasicAuthValidationErrorModel.empty();

  final List<LoginComponent> _components = [
    LoginComponent.header,
    LoginComponent.form,
    LoginComponent.buttons
  ];

  void _updateHeader(BasicAuthState state) {
    if (state is BasicAuthDetailDisplay) {
      setState(() {
        _airlineLogo = state.airlineLogo;
        _corporateLogo = state.corporateLogo;
      });
    }
  }

  void _updateOnEdit() {
    if (_components.contains(LoginComponent.error)) {
      _removeErrorCard();
    }
  }

  void _addErrorCard() {
    _animatedListKey.currentState
        .insertItem(1, duration: const Duration(milliseconds: 300));
    _components.insert(1, LoginComponent.error);
  }

  void _removeErrorCard() {
    _animatedListKey.currentState.removeItem(
      1,
      (context, animation) {
        return SizeTransition(
            axis: Axis.vertical,
            sizeFactor: animation,
            child: BasicAuthValidationErrorCards(
              errorModel: _validationError,
            ));
      },
      duration: const Duration(milliseconds: 250),
    );
    _components.removeAt(1);
  }

  void _respondToState(BasicAuthState state) {
    _updateHeader(state);
    _eventHandler.updateDesktopUrl(state);
    if (state is BasicAuthFailure) {
      _validationError =
          BasicAuthValidationErrorModel.wrongCredentials(state: state);
      _addErrorCard();
    } else {
      _updateOnEdit();
    }
    if (state is BasicAuthDenied) {
      _eventHandler.showBasicAuthDenialAlert(state);
    }
    if (state is BasicAuthSuccess) {
      BlocProvider.of<AuthenticationBloc>(context)
                  .add(UserTwoFactorAuthCompleted());

    }
    if (state is BasicAuthInitiateChangePassword) {
      Navigator.of(context).pushNamed(AuthNavigator.changePasswordRoute);
    }
    if (state is BasicAuthInitiateTwoFactorAuth) {
      Navigator.of(context).pushNamed(AuthNavigator.twoFactorAuthRoute);
      //Future.delayed(Duration(milliseconds: 200)).then((value) => Navigator.of(context).pushNamed(AuthNavigator.twoFactorAuthRoute));
    }
    if (state is BasicAuthInitiateGoogleRecaptcha) {
      Navigator.of(context).pushNamed(AuthNavigator.googleRecaptchaRoute);
      //Future.delayed(Duration(milliseconds: 200)).then((value) => Navigator.of(context).pushNamed(AuthNavigator.googleRecaptchaRoute));
    }
  }

  Widget _header() {
    return LoginLogoHeader(
      airlineLogo: _airlineLogo,
      corporateLogo: _corporateLogo,
    );
  }

  Widget _buildComponent(BuildContext context, int index) {
    final component = _components[index];
    switch (component) {
      case LoginComponent.header:
        return _header();
      case LoginComponent.error:
        return BasicAuthValidationErrorCards(
          errorModel: _validationError,
        );
      case LoginComponent.form:
        return BasicLoginForm(
          key: _basicLoginForm,
          onEdit: () {
            _updateOnEdit();
          },
        );
      case LoginComponent.buttons:
        return Container(
          padding: EdgeInsets.only(top: 16.0),
          child: LoginButtonBar(
            padding: EdgeInsets.only(
              left: 50.0,
              right: 50.0,
            ),
            onForgotPassword: _eventHandler.showForgotPasswordPage,
            onMoreOption: _eventHandler.showMoreOptionSheet,
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: _buildComponent(context, index));
  }

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _basicAuthBloc = BasicauthBloc(
        authenticationBloc: authBloc,
        userRepository: widget.userRepository,
        corporateRepository: widget.corporateRepository);
    _eventHandler =
        LoginEventHandler(context: context, basicAuthBloc: _basicAuthBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BasicauthBloc>.value(
      value: _basicAuthBloc..add(BasicauthStartedDisplay()),
      child: Scaffold(
        body: ScaffoldBody.authSceneNormal(
          child: BlocListener<BasicauthBloc, BasicAuthState>(
              listener: (context, state) {
                _respondToState(state);
              },
              child: AnimatedList(
                key: _animatedListKey,
                padding: EdgeInsets.only(top: 40.0),
                initialItemCount: _components.length,
                itemBuilder: buildItem,
              )),
        ),
      ),
    );
  }
}
