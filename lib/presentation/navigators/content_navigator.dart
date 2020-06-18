import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/booking_detail_page.dart';
import 'package:ifly_corporate_app/presentation/pages/slide_menu/slide_menu_page.dart';

class AppContentNavigator extends StatelessWidget {
  AppContentNavigator(
      {@required this.initialRoute,
      @required this.userRepository,
      @required this.corporateRepository,
      @required this.bookingRepository});

  static const mainSlideMenuRoute = '/mainSlideMenu';
  static const bookingDetailPageRoute = '/bookingDetail';

  final CorporateRepository corporateRepository;
  final UserRepository userRepository;
  final BookingRepository bookingRepository;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final String initialRoute;

  WidgetBuilder _pageBuilder(RouteSettings setting) {
    switch (setting.name) {
      case mainSlideMenuRoute:
        return (BuildContext context) => SlideMenuPage(
              bookingRepository: bookingRepository,
              userRepository: userRepository,
            );
      
      case bookingDetailPageRoute:
        return (BuildContext context) => BookingDetailPage(
              bookingRepository: bookingRepository,
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
