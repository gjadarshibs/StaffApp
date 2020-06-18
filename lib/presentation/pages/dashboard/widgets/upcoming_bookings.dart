import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/data/models/remote/upcoming_trips_response_model.dart';
import 'package:ifly_corporate_app/presentation/navigators/content_navigator.dart';
import 'package:ifly_corporate_app/presentation/utils/common_widgets.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class UpcomingBookingsView extends StatelessWidget {
  final BuildContext context;
  final List<UpcomingTrip> trips;

  const UpcomingBookingsView({
    @required this.context,
    @required this.trips,
  });

  @override
  Widget build(BuildContext context) {
    // return getTheUpComingTripListWith(trips: this.trips, context: this.context);
    return (trips.isEmpty)
        ? noBookingsContainer()
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return getTheUpComingListTileWith(upcomingTrips: trips[index]);
            },
            itemCount: trips.length,
          );
  }

  /*SliverList getTheUpComingTripListWith(
      {@required List<UpcomingTrip> trips, @required BuildContext context}) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return getTheUpComingListTileWith(upcomingTrips: trips[index]);
    }, childCount: trips.length));
  }*/

Widget noBookingsContainer() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(43, 11, 28, 11),
      margin: EdgeInsets.fromLTRB(22, 0, 22, 6),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.5,
            color: Theme.of(context).colorScheme.upcomingBookingsBorder),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Text(
        'No upcoming bookings',
        style: Theme.of(context).textTheme.noUpcomingBookings,
      ),
    );
  }

  GestureDetector getTheUpComingListTileWith(
      {@required UpcomingTrip upcomingTrips}) {
    return GestureDetector(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Stack(
          children: <Widget>[
            getTripDetailsContainer(upcomingTrips),
            getTripTypeViewWith(upcomingTrips.tripType),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppContentNavigator.bookingDetailPageRoute);
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return BlocProvider<BookingBloc>(
        //     create: (context) => BookingBloc(
        //         bookingDetailsRepository: BookingRepository(
        //             bookingDetailsProvider: BookingProvider()))
        //       ..add(BookingTappedEvent(tappedBookingReferenceNumber: '')),
        //     child: BookingDetailPage(),
        //   );
        // }));
        print('A booking tapped');
      },
    );
  }

  double calculateHeightOfaTile() {
    return MediaQuery.of(context).size.height * 0.1;
  }

 Container getTripDetailsContainer(UpcomingTrip upcomingTrips) {
    return Container(
      padding: EdgeInsets.fromLTRB(43, 11, 28, 11),
      margin: EdgeInsets.fromLTRB(22, 0, 22, 6),
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.upcomingBookingsBorder),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        children: <Widget>[
          getTripDetailsOrgin(upcomingTrips),
          getFlightLogo(),
          getTripDetailsDestination(upcomingTrips),
        ],
      ),
    );
  }

  Column getTripDetailsOrgin(UpcomingTrip upcomingTrips) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${upcomingTrips.carrier} ${upcomingTrips.flightNumber}',
            style: Theme.of(context).textTheme.upcomingPnr),
        Text(
          upcomingTrips.origin.originCode,
          style: Theme.of(context).textTheme.upcomingAirportCode,
        ),
        Text(getFormattedDateTime(upcomingTrips.depatureDate),
            style: Theme.of(context).textTheme.upcomingDate)
      ],
    );
  }

  Column getTripDetailsDestination(UpcomingTrip upcomingTrips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'PNR: ${upcomingTrips.pnr}',
          style: Theme.of(context).textTheme.upcomingPnr,
        ),
        Text(
          upcomingTrips.destination.destinationCode,
          style: Theme.of(context).textTheme.upcomingAirportCode,
        ),
        Text(getFormattedDateTime(upcomingTrips.arrivalDate),
            style: Theme.of(context).textTheme.upcomingDate)
      ],
    );
  }

  Container getTripTypeViewWith(String tripType) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0)),
        color: (tripType == 'LT')
            ? Theme.of(context).colorScheme.upcomingLtTripColor
            : Theme.of(context).colorScheme.upcomingDtTripColor,
      ),
      child: Text(
        tripType,
        style: Theme.of(context).textTheme.upcomingTripType,
      ),
    );
  }

  Padding getFlightLogo() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/plane.svg',
          color: Theme.of(context).colorScheme.upcomingDepartPlane,
          height: 14,
          width: 25,
        ),
      ),
    );
  }
}
