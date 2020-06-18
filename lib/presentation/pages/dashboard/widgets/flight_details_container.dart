import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/presentation/utils/common_widgets.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class FlightDetailsContainer extends StatelessWidget {
  final BookingDetailsResponseModel bookingDetail;
  const FlightDetailsContainer({Key key, this.bookingDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getDotContainer() {
      return Container(
        height: 3,
        width: 3,
        decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: Theme.of(context).colorScheme.flightDetailsDotDivider),
      );
    }

    String getNoOfDays(String departureDateString, String arrivaldateString) {
      var departureDate = getDate(departureDateString);
      var arrivalDate = getDate(arrivaldateString);
      var noOfDays = arrivalDate.difference(departureDate).inDays;
      if (noOfDays > 0) {
        return ' +$noOfDays';
      } else {
        return '';
      }
    }

    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
      padding: EdgeInsets.fromLTRB(25, 16, 32, 27),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Theme.of(context).colorScheme.bookingDetailsContainer,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/plane-depart.svg',
                height: 18,
                width: 24,
                color: Theme.of(context).colorScheme.bookingDetailsIconColor,
              ),
              Text(
                '  Flight Details',
                style: Theme.of(context).textTheme.bookingDetailsContainerHead,
              ),
              Expanded(child: SizedBox()),
              Text(
                bookingDetail.bookingDetails.pnrDetails.bookingStatusDescription
                    .toUpperCase(),
                style: Theme.of(context).textTheme.flightDetailsStatus,
              ),
            ],
          ),
          SizedBox(height: 21),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.flightDetailsDefaultRichText,
                    children: <TextSpan>[
                      TextSpan(text: 'PNR'),
                      TextSpan(
                          text:
                              ' #${bookingDetail.bookingDetails.pnrDetails.pnrNumber}',
                          style: Theme.of(context).textTheme.flightDetailsRichText)
                    ]),
              ),
              Expanded(child: SizedBox()),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.flightDetailsDefaultRichText,
                    children: <TextSpan>[
                      TextSpan(text: 'iFlyRef'),
                      TextSpan(
                          text:
                              ' #${bookingDetail.bookingDetails.pnrDetails.bookingReference}',
                          style: Theme.of(context).textTheme.flightDetailsRichText)
                    ]),
              ),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount:
                bookingDetail.bookingDetails.pnrDetails.iflyFlights.length,
            itemBuilder: (context, flightIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/images/Etihad_Airways.svg',
                        height: 16,
                        width: 38,
                      ),
                      Text(
                        bookingDetail.bookingDetails.pnrDetails
                                .iflyFlights[flightIndex].carrier +
                            bookingDetail.bookingDetails.pnrDetails
                                .iflyFlights[flightIndex].flightNumber,
                        style: Theme.of(context).textTheme.flightDetailsLine,
                      ),
                      getDotContainer(),
                      Text(
                        bookingDetail.bookingDetails.pnrDetails
                            .iflyFlights[flightIndex].travelCabinClassName,
                        style: Theme.of(context).textTheme.flightDetailsLine,
                      ),
                      getDotContainer(),
                      Text(
                        bookingDetail.bookingDetails.pnrDetails
                            .iflyFlights[flightIndex].duration,
                        style: Theme.of(context).textTheme.flightDetailsLine,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            bookingDetail.bookingDetails.pnrDetails
                                .iflyFlights[flightIndex].origin.originCode,
                            style: Theme.of(context)
                                .textTheme
                                .flightDetailsAirportCode,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${getFormattedDateWithoutYear(bookingDetail.bookingDetails.pnrDetails.iflyFlights[flightIndex].departureDate)}, ${bookingDetail.bookingDetails.pnrDetails.iflyFlights[flightIndex].departureTime}',
                            style:
                                Theme.of(context).textTheme.flightDetailsDate,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            bookingDetail
                                .bookingDetails
                                .pnrDetails
                                .iflyFlights[flightIndex]
                                .destination
                                .destinationCode,
                            style: Theme.of(context)
                                .textTheme
                                .flightDetailsAirportCode,
                          ),
                          Container(
                            width: 65,
                            height: 25,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Text(
                                    bookingDetail.bookingDetails.pnrDetails
                                        .iflyFlights[flightIndex].arrivalTime,
                                    style: Theme.of(context)
                                        .textTheme
                                        .flightDetailsDate,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Text(
                                    getNoOfDays(
                                        bookingDetail
                                            .bookingDetails
                                            .pnrDetails
                                            .iflyFlights[flightIndex]
                                            .departureDate,
                                        bookingDetail
                                            .bookingDetails
                                            .pnrDetails
                                            .iflyFlights[flightIndex]
                                            .arrivalDate),
                                    style: Theme.of(context)
                                        .textTheme
                                        .flightDetailsDelay,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
