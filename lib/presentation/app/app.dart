import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/navigators/auth_navigator.dart';
import 'package:ifly_corporate_app/presentation/navigators/content_navigator.dart';
import 'package:ifly_corporate_app/presentation/pages/splash/splash_screen.dart';

class App extends StatefulWidget {
  App({
    @required this.userRepository,
    @required this.corporateRepository,
    @required this.bookingRepository,
    Key key,
  })  : assert(corporateRepository != null),
        assert(userRepository != null),
        super(key: key);
  final CorporateRepository corporateRepository;
  final UserRepository userRepository;
  final BookingRepository bookingRepository;
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Widget _respondToAuthenticationState(AuthenticationState state) {
    if (state is AuthenticationAdptiveSplash) {
      return SplashScreen(
        config: state.splashData,
      );
    }
    if (state is AuthenticationCorporateUnidentified) {
      return AuthNavigator.authType(
        authenticationType: state.authType,
        userRepository: widget.userRepository,
        corporateRepository: widget.corporateRepository,
      );
    }
    // Corporate is selected so show login page
    if (state is AuthenticationCorporateIdentified) {
      return AuthNavigator.authType(
        authenticationType: state.authType,
        userRepository: widget.userRepository,
        corporateRepository: widget.corporateRepository,
      );
    }

    if (state is AuthenticationFinishUserLogin) {
      return AuthNavigator(
        initialRoute: AuthNavigator.rememberLoginRoute,
        userRepository: widget.userRepository,
        corporateRepository: widget.corporateRepository,
      );
    }
    // User is authenticated so show home scene.
    if (state is AuthenticationUserIdentified) {
      return AppContentNavigator(
        initialRoute: AppContentNavigator.mainSlideMenuRoute,
        corporateRepository: widget.corporateRepository,
        userRepository: widget.userRepository,
        bookingRepository: widget.bookingRepository,
      );
    }
    // User unauthenticated so show
    if (state is UserUnauthenticated) {
      return Scaffold(
        appBar: AppBar(title: Text('user Logoput')),
      );
    }
    return SplashScreen(
      config: SplashScreenConfig.basic(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF159697),
          colorScheme: ColorScheme(
              primary: Color(0xFF07a5a7),
              primaryVariant: Color(0xFF93dfde),
              secondary: Color(0xFF294968),
              secondaryVariant: Color(0xFF577496),
              surface: Color(0xFFe2f0f1),
              background: Color(0xFFF8F8F8),
              error: Color(0xFFff0000),
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Colors.black,
              onBackground: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light),
          textTheme: TextTheme()),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            child: _respondToAuthenticationState(state),
            duration: Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                child: child,
                opacity: animation,
              );
            },
          );
        },
      ),
    );
  }
}
