import 'package:flutter/material.dart';

extension TextStyles on TextTheme {
  TextStyle get appBarTitle {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.white);
  }

  TextStyle get slideMenuModules {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black);
  }

  TextStyle get slideMenuHead {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w900,
        fontSize: 12,
        color: Color(0xff7f7f7f));
  }

  TextStyle get slideMenuUserTitle {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.white);
  }

  TextStyle get slideMenuUserSubTitle {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Colors.white);
  }

  TextStyle get bannerImagesTitle {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.white);
  }

  TextStyle get upcomingBookingsHead {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black);
  }
TextStyle get noUpcomingBookings {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: Color(0xff004164));
  }
  TextStyle get bannerImagesSubTitle {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.normal,
        fontSize: 18,
        color: Colors.white);
  }

  TextStyle get upcomingPnr {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: const Color(0xffff9900));
  }

  TextStyle get upcomingAirportCode {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );
  }

  TextStyle get upcomingDate {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: const Color(0xff999999));
  }

  TextStyle get upcomingTripType {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 11,
        color: Colors.white);
  }

  TextStyle get notificationNumber {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 10,
        color: Colors.white);
  }

  TextStyle get sourceDestinationAirportCode {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Color(0xff00e1db));
  }

  TextStyle get sourceDestinationDate {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: Colors.white);
  }

  TextStyle get bookingDetailsContainerHead {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w800,
        fontSize: 14,
        color: Color(0xff1fadaf));
  }

  TextStyle get flightDetailsStatus {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w800,
        fontSize: 14,
        color: Color(0xff009900));
  }

  TextStyle get flightDetailsDefaultRichText {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: Color(0xff797979));
  }

  TextStyle get flightDetailsRichText {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w800,
        fontSize: 13,
        color: Colors.black);
  }

  TextStyle get flightDetailsLine {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: Color(0xff004164));
  }

  TextStyle get flightDetailsAirportCode {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color(0xff555555));
  }

  TextStyle get flightDetailsDate {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: Colors.black);
  }

  TextStyle get flightDetailsDelay {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 13,
        color: Colors.red);
  }

  TextStyle get passengersName {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: Colors.black);
  }

  TextStyle get passengersFare {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black);
  }

  TextStyle get passengersEntitlement {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: Color(0xff555555));
  }

  TextStyle get passengersTotalFare {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: Colors.black);
  }
}
