import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ifly_corporate_app/data/models/remote/upcoming_trips_response_model.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:ifly_corporate_app/data/repositories/user_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(
      {@required BookingRepository bookingRepository,
      @required UserRepository userRepository})
      : assert(bookingRepository != null),
        assert(userRepository != null),
        _bookingRepository = bookingRepository,
        _userRepository = userRepository;

  final BookingRepository _bookingRepository;
  final UserRepository _userRepository;

  @override
  DashboardState get initialState => DashboardInitial();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is DashboardLoaded) {
      final userPre = await _userRepository.getUserPreference();
      final shortcuts = userPre.info.roles.first.shortcuts ?? [];
      final upCommingTripModel = await _bookingRepository.getUpcomingTrips(username: userPre.info.username);
      final upCommingTrips = upCommingTripModel.upcomingTrips ?? [];
      yield DashboardLoadSuccess(
          shortcuts: shortcuts, upcomingTrips: upCommingTrips);
    }
  }
}
