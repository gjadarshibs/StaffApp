import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/bloc/booking/booking_bloc.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/car_booking_container.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/flight_details_container.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/hotel_booking_container.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/passengers_container.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';
import 'package:ifly_corporate_app/presentation/pages/dashboard/widgets/source_destination_container.dart';

class BookingDetailPage extends StatefulWidget {
  BookingDetailPage({
    Key key,
    @required this.bookingRepository,
  }) : super(key: key);

  final BookingRepository bookingRepository;

  @override
  _BookingDetailPageState createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingBloc>(
      create: (context) =>
          BookingBloc(bookingRepository: widget.bookingRepository)
            ..add(BookingDetailsOnDisplay(tappedBookingReferenceNumber: '')),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment(-1.0, -1.0),
            colors: [
              Theme.of(context).colorScheme.bookingDetailGradientBottom,
              Theme.of(context).colorScheme.bookingDetailGradientMiddle,
              Theme.of(context).colorScheme.bookingDetailGradientTop,
            ],
          ),
        ),
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingInitial) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is BookingLoadDetails) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0.0,
                    title: Text(
                      'Booking Details',
                      style: Theme.of(context).textTheme.appBarTitle,
                    ),
                    leading: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/arrow-left.svg',
                        color: Theme.of(context).colorScheme.appBarIconColor,
                        height: 16,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: <Widget>[
                      PopupMenuButton<BookingDetailsOperation>(
                        icon: SvgPicture.asset(
                          'assets/images/more-vertical.svg',
                          color: Theme.of(context).colorScheme.appBarIconColor,
                          height: 18,
                        ),
                        itemBuilder: (BuildContext context) {
                          var menuItems =
                              <PopupMenuEntry<BookingDetailsOperation>>[];
                          for (var operation in state.bookingDetails
                              .bookingDetails.operationsPermitted) {
                            menuItems
                                .add(PopupMenuItem<BookingDetailsOperation>(
                              value: operation.operationsPermitted,
                              child: Text(operation.operationDescription),
                            ));
                          }
                          return menuItems;
                        },

                        //onSelected:
                        //handle on tap of items
                      )
                    ]),
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SourceDestinationContainer(
                              bookingDetail: state.bookingDetails),
                          FlightDetailsContainer(
                              bookingDetail: state.bookingDetails),
                          PassengersContainer(
                              bookingDetail: state.bookingDetails),
                          HotelBookingContainer(
                              bookingDetail: state.bookingDetails),
                          CarBookingContainer(
                              bookingDetail: state.bookingDetails)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}

/*class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
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
}*/
