import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/basic_login/basic_login_page.dart';
import 'package:ifly_corporate_app/presentation/pages/change_password/change_password_page.dart';
import 'package:ifly_corporate_app/presentation/pages/corporate_selection/corporate_selection_page.dart';
import 'package:ifly_corporate_app/presentation/pages/okta_login/okta_login_page.dart';
import 'package:ifly_corporate_app/presentation/pages/remember_login/remember_login_page.dart';
import 'package:ifly_corporate_app/presentation/pages/saml_login/saml_login_page.dart';
import 'package:ifly_corporate_app/presentation/pages/two_factor_validation/two_factor_validation_page.dart';
import 'package:ifly_corporate_app/presentation/pages/validate_user/validate_user_page.dart';

class AuthNavigator extends StatelessWidget {
  AuthNavigator({
    @required this.initialRoute,
    @required this.userRepository,
    @required this.corporateRepository,
  });

  AuthNavigator.authType(
      {@required this.userRepository,
      @required this.corporateRepository,
      @required AuthenticationType authenticationType})
      : initialRoute = AuthNavigator.findInitialRoute(authenticationType);

  static const corporateAuthRoute = '/corporateAuth';
  static const basicAuthRoute = '/basicAuth';
  static const oktaAuthRoute = '/oktaAuth';
  static const samlAuthRoute = '/samlAuth';
  static const twoFactorAuthRoute = '/twoFactorAuth';
  static const forgotPasswordRoute = '/forgotPassword';
  static const changePasswordRoute = '/changePassword';
  static const rememberLoginRoute = '/rememberLogin';
  static const userValidationRoute = '/userValidation';
  static const googleRecaptchaRoute = '/googleRecaptchaRoute';
  static const unknownRoute = '/unknownRoute';

  final CorporateRepository corporateRepository;
  final UserRepository userRepository;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final String initialRoute;

  static String findInitialRoute(AuthenticationType authType) {
    switch (authType) {
      case AuthenticationType.corporate:
        return corporateAuthRoute;
      case AuthenticationType.lcl:
        return basicAuthRoute;
      case AuthenticationType.ldap:
        return basicAuthRoute;
      case AuthenticationType.okta:
        return oktaAuthRoute;
      case AuthenticationType.smal:
        return samlAuthRoute;
      case AuthenticationType.multiple:
        return userValidationRoute;
      default:
        return unknownRoute;
    }
  }

  WidgetBuilder _pageBuilder(RouteSettings setting) {
    switch (setting.name) {
      case corporateAuthRoute:
        return (BuildContext context) => CorporateSelectionPage(
              corporateRepository: corporateRepository,
            );
      case basicAuthRoute:
      
        return (BuildContext context) => BasicLoginPage(
              corporateRepository: corporateRepository,
              userRepository: userRepository,
            );
      case oktaAuthRoute:
        return (BuildContext context) => OktaLoginPage(
              corporateRepository: corporateRepository,
              userRepository: userRepository,
            );
      case samlAuthRoute:
        return (BuildContext context) => SamlLoginPage(
              corporateRepository: corporateRepository,
              userRepository: userRepository,
            );
      case userValidationRoute:
        return (BuildContext context) => ValidateUserPage(
              corporateRepository: corporateRepository,
              userRepository: userRepository,
            );
        break;
      case twoFactorAuthRoute:
        return (BuildContext context) => TwoFactorValidationPage(
              corporateRepository: corporateRepository,
              userRepository: userRepository,
            );
      case forgotPasswordRoute:
        return (BuildContext context) => Scaffold(
              appBar: AppBar(
                title: Text('Forgot Password'),
              ),
            );
      case changePasswordRoute:
         if(setting.arguments != null) {
           final bool isFromTwoFactorAuth = setting.arguments;
           return (BuildContext context) => ChangePasswordPage(isFromTwoFactorAuth: isFromTwoFactorAuth,);
         }
        return (BuildContext context) => ChangePasswordPage();
      case rememberLoginRoute:
        return (BuildContext context) => RememberLoginPage();
      case googleRecaptchaRoute:
        return (BuildContext context) => Scaffold(
              appBar: AppBar(
                title: Text('reCAPTCHA'),
              ),
            );
      case unknownRoute:
        return (BuildContext context) => Scaffold(
              appBar: AppBar(
                title: Text('Unknown Error'),
              ),
            );
      default:
        return (BuildContext context) => Scaffold(
              appBar: AppBar(
                title: Text('Unknown Error'),
              ),
            );
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_navigatorKey.currentState.canPop()) {
          _navigatorKey.currentState.maybePop();
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateInitialRoutes: (navigationState, name) {
          return [
            MaterialPageRoute(
                builder: _pageBuilder(RouteSettings(name: initialRoute)))
          ];
        },
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: _pageBuilder(settings));
        },
      ),
    );
  }
}
