import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/presentation/utils/common_widgets.dart';

import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class SourceDestinationContainer extends StatelessWidget {
  final BookingDetailsResponseModel bookingDetail;
  const SourceDestinationContainer({Key key, this.bookingDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var totalFlights =
        bookingDetail.bookingDetails.pnrDetails.iflyFlights.length;
    Widget getDot() {
      return Container(
        height: 7,
        width: 7,
        decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: Theme.of(context).colorScheme.sourceDestinationFlight),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                bookingDetail
                    .bookingDetails.pnrDetails.iflyFlights[0].origin.originCode,
                style: Theme.of(context).textTheme.sourceDestinationAirportCode,
              ),
              SizedBox(width: 30),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: getDot(),
                    ),
                    Positioned.fill(
                      child: Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .sourceDestinationFlight,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/plane.svg',
                      color:
                          Theme.of(context).colorScheme.sourceDestinationFlight,
                      height: 13,
                      width: 13,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: getDot(),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 30),
              Text(
                  bookingDetail
                      .bookingDetails
                      .pnrDetails
                      .iflyFlights[totalFlights - 1]
                      .destination
                      .destinationCode,
                  style:
                      Theme.of(context).textTheme.sourceDestinationAirportCode)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  '${getFormattedDate(bookingDetail.bookingDetails.pnrDetails.iflyFlights[0].departureDate)}, ${bookingDetail.bookingDetails.pnrDetails.iflyFlights[0].departureTime}',
                  style: Theme.of(context).textTheme.sourceDestinationDate),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                    getNoOfStop(bookingDetail
                        .bookingDetails.pnrDetails.iflyFlights.length),
                    style: Theme.of(context).textTheme.sourceDestinationDate),
              ),
              Text(
                  '${getFormattedDate(bookingDetail.bookingDetails.pnrDetails.iflyFlights[totalFlights - 1].arrivalDate)}, ${bookingDetail.bookingDetails.pnrDetails.iflyFlights[totalFlights - 1].arrivalTime}',
                  style: Theme.of(context).textTheme.sourceDestinationDate),
            ],
          ),
        ],
      ),
    );
  }
}

String getNoOfStop(int totalFlightss) {
  var noOfStops = totalFlightss - 1;
  if (totalFlightss == 1) {
    return 'non-stop';
  } else {
    return '${noOfStops} stop';
  }
}
