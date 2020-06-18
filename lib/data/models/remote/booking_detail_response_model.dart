import 'dart:convert';

BookingDetailsResponseModel bookingDetailsResponseModelFromJson(String str) =>
    BookingDetailsResponseModel.fromJson(json.decode(str));

class BookingDetailsResponseModel {
  BookingDetailsResponseModel({
    this.status,
    this.token,
    this.bookingDetails,
  });

  Status status;
  String token;
  BookingDetails bookingDetails;

  factory BookingDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsResponseModel(
        status: Status.fromJson(json['status']),
        token: json['token'],
        bookingDetails: BookingDetails.fromJson(json['bookingDetails']),
      );
}

class BookingDetails {
  BookingDetails({
    this.pnrDetails,
    this.externalFlights,
    this.carBookings,
    this.conferenceRooms,
    this.hotels,
    this.visaDetails,
    this.displayFlightLoad,
    this.dislplayStaffListing,
    this.operationsPermitted,
  });

  PnrDetails pnrDetails;
  CarBookings externalFlights;
  CarBookings carBookings;
  CarBookings conferenceRooms;
  CarBookings hotels;
  CarBookings visaDetails;
  String displayFlightLoad;
  String dislplayStaffListing;
  List<OperationsPermitted> operationsPermitted;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        pnrDetails: PnrDetails.fromJson(json['pnrDetails']),
        externalFlights: CarBookings.fromJson(json['externalFlights']),
        carBookings: CarBookings.fromJson(json['carBookings']),
        conferenceRooms: CarBookings.fromJson(json['conferenceRooms']),
        hotels: CarBookings.fromJson(json['hotels']),
        visaDetails: CarBookings.fromJson(json['visaDetails']),
        displayFlightLoad: json['displayFlightLoad'],
        dislplayStaffListing: json['dislplayStaffListing'],
        operationsPermitted: List<OperationsPermitted>.from(
            json['operationsPermitted']
                .map((x) => OperationsPermitted.fromJson(x))),
      );
}

class CarBookings {
  CarBookings();

  factory CarBookings.fromJson(Map<String, dynamic> json) => CarBookings();
}

class OperationsPermitted {
  OperationsPermitted(
      {this.operationCode,
      this.operationDescription,
      this.operationsPermitted});

  String operationCode;
  String operationDescription;
  BookingDetailsOperation operationsPermitted;

  factory OperationsPermitted.fromJson(Map<String, dynamic> json) =>
      OperationsPermitted(
          operationCode: json['operationCode'],
          operationDescription: json['operationDescription'],
          operationsPermitted: _mapCodeToOprations(json['operationCode']));

  static BookingDetailsOperation _mapCodeToOprations(String input) {
    BookingDetailsOperation operation;
    switch (input) {
      case 'CB':
        operation = BookingDetailsOperation.changebooking;
        break;
      case 'RMPAX':
        operation = BookingDetailsOperation.removepax;
        break;
      case 'RMSEC':
        operation = BookingDetailsOperation.removesector;
        break;
      case 'CAN':
        operation = BookingDetailsOperation.cancelbooking;
        break;
      case 'RESITN':
        operation = BookingDetailsOperation.resenditinerary;
        break;
      case 'UPDCON':
        operation = BookingDetailsOperation.updatecontacts;
        break;
      case 'UPDEXT':
        operation = BookingDetailsOperation.updateextras;
        break;
    }
    return operation;
  }
}

enum BookingDetailsOperation {
  changebooking,
  removepax,
  removesector,
  cancelbooking,
  resenditinerary,
  updatecontacts,
  updateextras
}

class PnrDetails {
  PnrDetails({
    this.pnrNumber,
    this.bookingReference,
    this.bookingStatusCode,
    this.bookingStatusDescription,
    this.paidIndicator,
    this.bookingCreatedDate,
    this.bookingCreatedUser,
    this.entitlementName,
    this.passengerDetails,
    this.iflyFlights,
    this.paymentDetails,
  });

  String pnrNumber;
  String bookingReference;
  String bookingStatusCode;
  String bookingStatusDescription;
  String paidIndicator;
  String bookingCreatedDate;
  String bookingCreatedUser;
  String entitlementName;
  List<PassengerDetail> passengerDetails;
  List<IflyFlight> iflyFlights;
  List<PaymentDetail> paymentDetails;

  factory PnrDetails.fromJson(Map<String, dynamic> json) => PnrDetails(
        pnrNumber: json['pnrNumber'],
        bookingReference: json['bookingReference'],
        bookingStatusCode: json['bookingStatusCode'],
        bookingStatusDescription: json['bookingStatusDescription'],
        paidIndicator: json['paidIndicator'],
        bookingCreatedDate: json['bookingCreatedDate'],
        bookingCreatedUser: json['bookingCreatedUser'],
        entitlementName: json['entitlementName'],
        passengerDetails: List<PassengerDetail>.from(
            json['passengerDetails'].map((x) => PassengerDetail.fromJson(x))),
        iflyFlights: List<IflyFlight>.from(
            json['iflyFlights'].map((x) => IflyFlight.fromJson(x))),
        paymentDetails: List<PaymentDetail>.from(
            json['paymentDetails'].map((x) => PaymentDetail.fromJson(x))),
      );
}

class IflyFlight {
  IflyFlight({
    this.carrier,
    this.flightNumber,
    this.departureDate,
    this.departureTime,
    this.arrivalDate,
    this.arrivalTime,
    this.origin,
    this.destination,
    this.travelCabinClassCode,
    this.travelCabinClassName,
    this.enableRemoveSector,
    this.duration,
    this.numberOfStops,
  });

  String carrier;
  String flightNumber;
  String departureDate;
  String departureTime;
  String arrivalDate;
  String arrivalTime;
  Origin origin;
  Destination destination;
  String travelCabinClassCode;
  String travelCabinClassName;
  String enableRemoveSector;
  String duration;
  String numberOfStops;

  factory IflyFlight.fromJson(Map<String, dynamic> json) => IflyFlight(
        carrier: json['carrier'],
        flightNumber: json['flightNumber'],
        departureDate: json['departureDate'],
        departureTime: json['departureTime'],
        arrivalDate: json['arrivalDate'],
        arrivalTime: json['arrivalTime'],
        origin: Origin.fromJson(json['origin']),
        destination: Destination.fromJson(json['destination']),
        travelCabinClassCode: json['travelCabinClassCode'],
        travelCabinClassName: json['travelCabinClassName'],
        enableRemoveSector: json['enableRemoveSector'],
        duration: json['duration'],
        numberOfStops: json['numberOfStops'],
      );
}

class Destination {
  Destination({
    this.destinationCode,
    this.destinationDescription,
  });

  String destinationCode;
  String destinationDescription;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        destinationCode: json['destinationCode'],
        destinationDescription: json['destinationDescription'],
      );
}

class Origin {
  Origin({
    this.originCode,
    this.originDescription,
  });

  String originCode;
  String originDescription;

  factory Origin.fromJson(Map<String, dynamic> json) => Origin(
        originCode: json['originCode'],
        originDescription: json['originDescription'],
      );
}

class PassengerDetail {
  PassengerDetail({
    this.passengerName,
    this.title,
    this.firstName,
    this.surname,
    this.passengerCode,
    this.passengerCodeDescription,
    this.passengerUniqueNumber,
    this.passengerCategoryCode,
    this.passengerCategoryDescription,
    this.fare,
    this.ticketNumbers,
    this.enableRemovePax,
  });

  String passengerName;
  String title;
  String firstName;
  String surname;
  String passengerCode;
  String passengerCodeDescription;
  String passengerUniqueNumber;
  String passengerCategoryCode;
  String passengerCategoryDescription;
  Fare fare;
  List<TicketNumber> ticketNumbers;
  String enableRemovePax;

  factory PassengerDetail.fromJson(Map<String, dynamic> json) =>
      PassengerDetail(
        passengerName: json['passengerName'],
        title: json['title'],
        firstName: json['firstName'],
        surname: json['surname'],
        passengerCode: json['passengerCode'],
        passengerCodeDescription: json['passengerCodeDescription'],
        passengerUniqueNumber: json['passengerUniqueNumber'],
        passengerCategoryCode: json['passengerCategoryCode'],
        passengerCategoryDescription: json['passengerCategoryDescription'],
        fare: Fare.fromJson(json['fare']),
        ticketNumbers: List<TicketNumber>.from(
            json['ticketNumbers'].map((x) => TicketNumber.fromJson(x))),
        enableRemovePax: json['enableRemovePax'],
      );
}

class Fare {
  Fare({
    this.baseFare,
    this.taxFare,
    this.totalFare,
    this.currencyCode,
    this.taxDetails,
  });

  String baseFare;
  String taxFare;
  String totalFare;
  String currencyCode;
  List<TaxDetail> taxDetails;

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        baseFare: json['baseFare'],
        taxFare: json['taxFare'],
        totalFare: json['totalFare'],
        currencyCode: json['currencyCode'],
        taxDetails: List<TaxDetail>.from(
            json['taxDetails'].map((x) => TaxDetail.fromJson(x))),
      );
}

class TaxDetail {
  TaxDetail({
    this.taxName,
    this.taxCode,
    this.taxValue,
  });

  String taxName;
  String taxCode;
  String taxValue;

  factory TaxDetail.fromJson(Map<String, dynamic> json) => TaxDetail(
        taxName: json['taxName'],
        taxCode: json['taxCode'],
        taxValue: json['taxValue'],
      );
}

class TicketNumber {
  TicketNumber({
    this.ticketNumber,
  });

  String ticketNumber;

  factory TicketNumber.fromJson(Map<String, dynamic> json) => TicketNumber(
        ticketNumber: json['ticketNumber'],
      );
}

class PaymentDetail {
  PaymentDetail({
    this.baseFare,
    this.tax,
    this.totalAmoutPaid,
    this.refundAmount,
    this.formOfPayment,
    this.formOfPaymentDescription,
  });

  String baseFare;
  String tax;
  String totalAmoutPaid;
  String refundAmount;
  String formOfPayment;
  String formOfPaymentDescription;

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
        baseFare: json['baseFare'],
        tax: json['tax'],
        totalAmoutPaid: json['totalAmoutPaid'],
        refundAmount: json['refundAmount'],
        formOfPayment: json['formOfPayment'],
        formOfPaymentDescription: json['formOfPaymentDescription'],
      );
}

class Status {
  Status({
    this.statusCode,
    this.statusDescription,
    this.errorCodes,
  });

  String statusCode;
  String statusDescription;
  ErrorCodes errorCodes;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusCode: json['statusCode'],
        statusDescription: json['statusDescription'],
        errorCodes: ErrorCodes.fromJson(json['errorCodes']),
      );
}

class ErrorCodes {
  ErrorCodes({
    this.errorCode,
    this.errorDescription,
  });

  String errorCode;
  String errorDescription;

  factory ErrorCodes.fromJson(Map<String, dynamic> json) => ErrorCodes(
        errorCode: json['errorCode'],
        errorDescription: json['errorDescription'],
      );
}
