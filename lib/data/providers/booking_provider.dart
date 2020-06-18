import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/app_environment/setup/config/flavor_conf.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/data/models/remote/upcoming_trips_response_model.dart';
import 'package:ifly_corporate_app/data/utils/json_client.dart';

class BookingProvider {
  BookingProvider({JsonClient client}) : _client = client ?? JsonClient();
  static const bookingDetailFile = 'booking_detail_response.json';
  static const upcomingTripsFile = 'upcoming_trips.json';
  static const upcommingTripsScrollFile = 'upcoming_response_scroll.json';
  static const upcommingTripsEmptyile = 'upcoming_trips_empty.json';

  final JsonClient _client;

  Future<UpcomingTripsResponseModel> getUpcomingTrips(
      {@required username}) async {
    List<String> users = [
      FlavorConfig.instance.properties['user_1'],
      FlavorConfig.instance.properties['user_2'],
      FlavorConfig.instance.properties['user_3']
    ];

    final basePath = FlavorConfig.instance.properties['dummy_json_data'];
    String _fileName = upcomingTripsFile;

    if (users.contains(username)) {
      /// select file name here
      if (users[0] == username) {
        _fileName = '$upcomingTripsFile';
      }
      if (users[1] == username) {
        _fileName = '$upcommingTripsScrollFile';
      }
      if (users[2] == username) {
        _fileName = '$upcommingTripsEmptyile';
      }
    } else {
      _fileName = '$upcomingTripsFile';
    }
    final filePath = '$basePath$_fileName';
    final map = await _client.fecth(filePath);
    return UpcomingTripsResponseModel.fromJson(map);
  }

  Future<BookingDetailsResponseModel> getGetBookingDetailsOfTripWith() async {
    final basePath = FlavorConfig.instance.properties['dummy_json_data'];
    final filePath = '$basePath$bookingDetailFile';
    final map = await _client.fecth(filePath);
    return BookingDetailsResponseModel.fromJson(map);
  }
}
