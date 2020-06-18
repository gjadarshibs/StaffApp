import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class PassengersContainer extends StatelessWidget {
  final BookingDetailsResponseModel bookingDetail;

  const PassengersContainer({Key key, this.bookingDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getTotalFareFrom({List<PassengerDetail> listOfPassengers}) {
      if (listOfPassengers.isNotEmpty) {
        String currencyCode;
        var passengersTotalFare = 0;
        currencyCode = listOfPassengers[0].fare.currencyCode;
        for (var passenger in listOfPassengers) {
          passengersTotalFare += int.parse(passenger.fare.totalFare);
        }
        return currencyCode + passengersTotalFare.toString();
      } else {
        return '0';
      }
    }

    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Theme.of(context).colorScheme.bookingDetailsContainer,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/user.svg',
                height: 24,
                width: 24,
                color: Theme.of(context).colorScheme.bookingDetailsIconColor,
              ),
              Text(
                '  Passengers',
                style: Theme.of(context).textTheme.bookingDetailsContainerHead,
              ),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: bookingDetail
                  .bookingDetails.pnrDetails.passengerDetails.length,
              itemBuilder: (context, passengerIndex) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          bookingDetail.bookingDetails.pnrDetails
                              .passengerDetails[passengerIndex].passengerName,
                          style: Theme.of(context).textTheme.passengersName,
                        ),
                        Text(
                          bookingDetail
                                  .bookingDetails
                                  .pnrDetails
                                  .passengerDetails[passengerIndex]
                                  .fare
                                  .currencyCode +
                              bookingDetail
                                  .bookingDetails
                                  .pnrDetails
                                  .passengerDetails[passengerIndex]
                                  .fare
                                  .totalFare,
                          style: Theme.of(context).textTheme.passengersFare,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          bookingDetail
                              .bookingDetails.pnrDetails.entitlementName,
                          style:
                              Theme.of(context).textTheme.passengersEntitlement,
                        ),
                        Text(
                          '${bookingDetail.bookingDetails.pnrDetails.passengerDetails[passengerIndex].fare.baseFare} + ${bookingDetail.bookingDetails.pnrDetails.passengerDetails[passengerIndex].fare.taxFare}',
                          style:
                              Theme.of(context).textTheme.passengersEntitlement,
                        )
                      ],
                    )
                  ],
                );
              }),
          SizedBox(height: 10),
          Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total Fare',
                style: Theme.of(context).textTheme.passengersTotalFare,
              ),
              Text(
                getTotalFareFrom(
                    listOfPassengers: bookingDetail
                        .bookingDetails.pnrDetails.passengerDetails),
                style: Theme.of(context).textTheme.passengersTotalFare,
              )
            ],
          )
        ],
      ),
    );
  }
}
