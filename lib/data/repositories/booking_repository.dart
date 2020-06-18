import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/data/models/remote/upcoming_trips_response_model.dart';
import 'package:ifly_corporate_app/data/providers/booking_provider.dart';


class BookingRepository {
  BookingRepository({BookingProvider bookingProvider})
      : _bookingProvider = bookingProvider ?? BookingProvider();

  final BookingProvider _bookingProvider;

 Future<UpcomingTripsResponseModel> getUpcomingTrips({@required String username}) async {
   return _bookingProvider.getUpcomingTrips(username: username);
 }

  Future<BookingDetailsResponseModel> getBookingDetailsOfTheTripWith(
      String id) async {
    BookingDetailsResponseModel bookingDetails =
        await _bookingProvider.getGetBookingDetailsOfTripWith();
    return bookingDetails;
  }
}
