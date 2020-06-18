// To parse this JSON data, do
//
//     final upComingTripsResponseModel = upComingTripsResponseModelFromJson(jsonString);

import 'dart:convert';

UpcomingTripsResponseModel upcomingTripsResponseModelFromJson(String str) => UpcomingTripsResponseModel.fromJson(json.decode(str));

String upcomingTripsResponseModelToJson(UpcomingTripsResponseModel data) => json.encode(data.toJson());

class UpcomingTripsResponseModel {
    UpcomingTripsResponseModel({
        this.status,
        this.token,
        this.upcomingTrips,
    });

    Status status;
    String token;
    List<UpcomingTrip> upcomingTrips;

    factory UpcomingTripsResponseModel.fromJson(Map<String, dynamic> json) => UpcomingTripsResponseModel(
        status: Status.fromJson(json['status']),
        token: json['token'],
        upcomingTrips: List<UpcomingTrip>.from(json['upcomingTrips'].map((x) => UpcomingTrip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'status': status.toJson(),
        'token': token,
        'upcomingTrips': List<dynamic>.from(upcomingTrips.map((x) => x.toJson())),
    };
}

class Status {
    Status({
        this.statusCode,
        this.statusDescription,
    });

    String statusCode;
    String statusDescription;

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusCode: json['statusCode'],
        statusDescription: json['statusDescription'],
    );

    Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'statusDescription': statusDescription,
    };
}

class UpcomingTrip {
    UpcomingTrip({
        this.tripType,
        this.bookingReference,
        this.pnr,
        this.carrier,
        this.flightNumber,
        this.depatureDate,
        this.arrivalDate,
        this.origin,
        this.destination,
        this.travelCabinClassCode,
        this.travelCabinClassName,
        this.displayFlightLoad,
        this.dislplayStaffListing,
        this.flightLoadInformation,
    });

    String tripType;
    String bookingReference;
    String pnr;
    String carrier;
    String flightNumber;
    String depatureDate;
    String arrivalDate;
    Origin origin;
    Destination destination;
    String travelCabinClassCode;
    String travelCabinClassName;
    String displayFlightLoad;
    String dislplayStaffListing;
    FlightLoadInformation flightLoadInformation;

    factory UpcomingTrip.fromJson(Map<String, dynamic> json) => UpcomingTrip(
        tripType: json['tripType'],
        bookingReference: json['bookingReference'],
        pnr: json['pnr'],
        carrier: json['carrier'],
        flightNumber: json['flightNumber'],
        depatureDate: json['depatureDate'],
        arrivalDate: json['arrivalDate'],
        origin: Origin.fromJson(json['origin']),
        destination: Destination.fromJson(json['destination']),
        travelCabinClassCode: json['travelCabinClassCode'],
        travelCabinClassName: json['travelCabinClassName'],
        displayFlightLoad: json['displayFlightLoad'],
        dislplayStaffListing: json['dislplayStaffListing'],
        flightLoadInformation: json['flightLoadInformation'] == null ? null : FlightLoadInformation.fromJson(json['flightLoadInformation']),

    );

    Map<String, dynamic> toJson() => {
        'tripType': tripType,
        'bookingReference': bookingReference,
        'pnr': pnr,
        'carrier': carrier,
        'flightNumber': flightNumber,
        'depatureDate': depatureDate,
        'arrivalDate': arrivalDate,
        'origin': origin.toJson(),
        'destination': destination.toJson(),
        'travelCabinClassCode': travelCabinClassCode,
        'travelCabinClassName': travelCabinClassName,
        'displayFlightLoad': displayFlightLoad,
        'dislplayStaffListing': dislplayStaffListing,
        'flightLoadInformation': flightLoadInformation == null ? null : flightLoadInformation.toJson(),
    };
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

    Map<String, dynamic> toJson() => {
        'destinationCode': destinationCode,
        'destinationDescription': destinationDescription,
    };
}

class FlightLoadInformation {
    FlightLoadInformation({
        this.totalCapacity,
        this.bookedSeat,
        this.standbyCount,
        this.seatsAvailbleForBooking,
        this.upgradeCount,
        this.smiley,
    });

    String totalCapacity;
    String bookedSeat;
    String standbyCount;
    String seatsAvailbleForBooking;
    String upgradeCount;
    String smiley;

    factory FlightLoadInformation.fromJson(Map<String, dynamic> json) => FlightLoadInformation(
        totalCapacity: json['totalCapacity'],
        bookedSeat: json['bookedSeat'],
        standbyCount: json['standbyCount'],
        seatsAvailbleForBooking: json['seatsAvailbleForBooking'],
        upgradeCount: json['upgradeCount'],
        smiley: json['smiley'],
    );

    Map<String, dynamic> toJson() => {
        'totalCapacity': totalCapacity,
        'bookedSeat': bookedSeat,
        'standbyCount': standbyCount,
        'seatsAvailbleForBooking': seatsAvailbleForBooking,
        'upgradeCount': upgradeCount,
        'smiley': smiley,
    };
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

    Map<String, dynamic> toJson() => {
        'originCode': originCode,
        'originDescription': originDescription,
    };
}
