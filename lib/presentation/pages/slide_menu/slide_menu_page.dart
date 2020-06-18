import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/current_bookings/current_bookings.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/dashboard_page.dart';
import 'package:ifly_corporate_app/presentation/pages/make_booking/make_booking.dart';
import 'package:ifly_corporate_app/presentation/pages/slide_menu/widgets/drawer.dart';

enum Pages { dashboard, currentBookings, makeBooking }

class SlideMenuPage extends StatefulWidget {
  SlideMenuPage(
      {Key key,
      @required this.userRepository,
      @required this.bookingRepository})
      : super(key: key);
  final UserRepository userRepository;
  final BookingRepository bookingRepository;
  @override
  _SlideMenuPageState createState() => _SlideMenuPageState();
}

class _SlideMenuPageState extends State<SlideMenuPage> {
  UserInfoModel _userInfo;
  String _selectedItem;

  Widget _selectedDrawerItemRoute() {
    _selectedItem ??= _userInfo.roles.first.modules.first.moduleCode;
    switch (_selectedItem) {
      case 'DSH':
        return DashboardPage(
          userRepository: widget.userRepository,
          bookingRepository: widget.bookingRepository,
          drawer: SideDrawer(
            userInfo: _userInfo,
            selectedItem: _selectedItem,
            onSelection: (drawerItem) {
              updatePage(drawerItem);
            },
          ),
        );

      case 'LTCURBOOK':
        return CurrentBookingsPage(
          drawer: SideDrawer(
            userInfo: _userInfo,
            selectedItem: _selectedItem,
            onSelection: (drawerItem) {
              updatePage(drawerItem);
            },
          ),
        );
      case 'LTMKBOOK':
        return MakeBookingPage(
          drawer: SideDrawer(
              userInfo: _userInfo,
              selectedItem: _selectedItem,
              onSelection: (drawerItem) {
                updatePage(drawerItem);
              }),
        );
      default:
        return Text('Sorry, something went wrong');
    }
  }

  void updatePage(String drawerItem) {
    switch (drawerItem) {
      case 'LGT':
        BlocProvider.of<AuthenticationBloc>(context).add(UserUnauthenticated());
        break;
      case 'DSH':
        Navigator.of(context).pop();
        if (drawerItem != _selectedItem) {
          setState(() {
            _selectedItem = drawerItem;
          });
        }
        break;
      case 'LTCURBOOK':
        Navigator.of(context).pop();
        if (drawerItem != _selectedItem) {
          setState(() {
            _selectedItem = drawerItem;
          });
        }
        break;
      case 'LTMKBOOK':
        Navigator.of(context).pop();
        if (drawerItem != _selectedItem) {
          setState(() {
            _selectedItem = drawerItem;
          });
        }
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserPreference>(
      future: widget.userRepository.getUserPreference(),
      builder: (BuildContext context, AsyncSnapshot<UserPreference> snapshot) {
        if (snapshot.hasData) {
          _userInfo = snapshot.data.info;
          return AnimatedSwitcher(
            child: _selectedDrawerItemRoute(),
            duration: Duration(milliseconds: 600),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                child: child,
                opacity: animation,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Failed to load dashboard'),
                )
              ],
            ),
          );
        } else {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('loading dashboard...'),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
