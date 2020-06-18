part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  const BookingState();
}

class BookingInitial extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingLoadDetails extends BookingState {
  final BookingDetailsResponseModel bookingDetails;
  BookingLoadDetails({@required this.bookingDetails});
  @override
  List<Object> get props => [bookingDetails];
}
