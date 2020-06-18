import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class CarBookingContainer extends StatelessWidget {
  final BookingDetailsResponseModel bookingDetail;
  const CarBookingContainer({Key key, this.bookingDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'assets/images/taxi.svg',
                height: 24,
                width: 24,
                color: Theme.of(context).colorScheme.bookingDetailsIconColor,
              ),
              Text(
                '  Car Booking',
                style: Theme.of(context).textTheme.bookingDetailsContainerHead,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
