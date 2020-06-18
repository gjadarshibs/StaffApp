part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class BookingDetailsOnDisplay extends BookingEvent {
  final String tappedBookingReferenceNumber;

  BookingDetailsOnDisplay({@required this.tappedBookingReferenceNumber});
  @override
  List<Object> get props => [tappedBookingReferenceNumber];
}
