import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/bloc/dashboard/dashboard_bloc.dart';
import 'package:ifly_corporate_app/data/models/remote/upcoming_trips_response_model.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/banner_image.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/shortcuts_menu.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/upcoming_bookings.dart';
import 'package:ifly_corporate_app/presentation/pages/slide_menu/slide_menu_page.dart';
import 'package:ifly_corporate_app/presentation/utils/colored_safe_area.dart';
import 'package:ifly_corporate_app/presentation/utils/common_widgets.dart';
import 'package:ifly_corporate_app/presentation/utils/gradient_container.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'dart:math' as math;

class DashboardPage extends StatefulWidget {
  DashboardPage(
      {Key key,
      @required this.userRepository,
      @required this.bookingRepository,
      this.drawer})
      : super(key: key);
  final UserRepository userRepository;
  final BookingRepository bookingRepository;
  final Widget drawer;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Pages pageSelection = Pages.dashboard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
          bookingRepository: widget.bookingRepository,
          userRepository: widget.userRepository)
        ..add(DashboardLoaded()),
      child: Scaffold(
        drawer: widget.drawer,
        body: GradientSafeArea(
          topGradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.dashboardGradientBottom,
              Theme.of(context).colorScheme.dashboardGradientMiddle,
              Theme.of(context).colorScheme.dashboardGradienTop,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment(-1.0, -1.0),
          ),
          bottomGradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoadSuccess) {
                return getCustomScroll(
                  context,
                  state.shortcuts,
                  state.upcomingTrips,
                );
              } else {
                return Container(
                    child: Stack(
                  children: <Widget>[
                    GradientContainer(
                      height: double.infinity,
                      width: double.infinity,
                      colors: [
                        Theme.of(context).colorScheme.dashboardGradientBottom,
                        Theme.of(context).colorScheme.dashboardGradientMiddle,
                        Theme.of(context).colorScheme.dashboardGradienTop,
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 120.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ));
              }
            },
          ),
        ),
      ),
    );
  }

  /// Get Custom scroll view
  Widget getCustomScroll(BuildContext context, List<ShortcutModel> shortcut,
          List<UpcomingTrip> upcomingTrips) =>
      Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            getAppBarWithShortcuts(context, shortcut),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BannerImage(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
                    child: Text('Upcoming Bookings',
                        style:
                            Theme.of(context).textTheme.upcomingBookingsHead),
                  ),
                  UpcomingBookingsView(
                    context: context,
                    trips: upcomingTrips,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  SliverPersistentHeader getAppBarWithShortcuts(
      BuildContext context, List<ShortcutModel> shortcut) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 130,
        maxHeight: 164,
        child: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              GradientContainer(
                height: 164,
                width: double.infinity,
                colors: [
                  Theme.of(context).colorScheme.dashboardGradientBottom,
                  Theme.of(context).colorScheme.dashboardGradientMiddle,
                  Theme.of(context).colorScheme.dashboardGradienTop,
                ],
              ),
              SizedBox(
                height: 100,
                child: ShortcutsMenu(
                  context: context,
                  shortcuts: shortcut,
                  itemSize: 60.0,
                  maxHeight: 90.0,
                  spaceBetweenItems: 4.0,
                ),
              ),

              ///appBar as topmost row of the stack
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  height: 64,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/burgermenu.svg',
                          color: Theme.of(context).colorScheme.appBarIconColor,
                          height: 20,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Dashboard',
                            style: Theme.of(context).textTheme.appBarTitle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Stack(
                          children: <Widget>[
                            IconButton(
                              icon: SvgPicture.asset(
                                'assets/images/bell.svg',
                                color: Theme.of(context)
                                    .colorScheme
                                    .appBarIconColor,
                                height: 25,
                              ),
                              onPressed: () {},
                            ),
                            Positioned(
                                right: 8,
                                top: 4,
                                child: getNotificationBadge(context))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
