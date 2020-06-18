import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifly_corporate_app/data/models/remote/booking_detail_response_model.dart';
import 'package:ifly_corporate_app/data/repositories/booking_repository.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';

part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({@required this.bookingRepository});
  final BookingRepository bookingRepository;

  @override
  BookingState get initialState => BookingInitial();

  @override
  Stream<BookingState> mapEventToState(
      BookingEvent event) async* {
    if (event is BookingDetailsOnDisplay) {
      final bookingDetails = await bookingRepository
          .getBookingDetailsOfTheTripWith(event.tappedBookingReferenceNumber);
      yield BookingLoadDetails(bookingDetails: bookingDetails);
    }
  }
}
