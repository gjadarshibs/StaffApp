import 'package:flutter/foundation.dart';

/// The class represents an error happens in dream cruise app
/// All exceptions being thrown in the app will be having a CommonError
/// object associated with it.
class CommonError {
  /// [int] holds the error code
  final int code;

  /// [String] holds the error description
  final String description;

  /// The default constructor for the class which helps in creating a new
  /// CommonError instance
  ///
  /// code : [int] value represents the error code
  /// description : [String] value represents the error description
  CommonError(this.code, this.description);

  /// Internal error object that can be used inside the application
  /// for any errors which is not added in the error table
  static CommonError internalError = CommonError(
    ErrorCodes.internalError,
    ErrorMessages.internalError,
  );

  /// No internet error that can be used in case the application is not
  /// connected to internet when trying to connect to call an api
  static CommonError noInternet = CommonError(
    ErrorCodes.noInternet,
    ErrorMessages.noInternet,
  );

  /// Server communication error that can be used when an error which is
  /// unidentified is coming from the server
  static CommonError serverError = CommonError(
    ErrorCodes.serverError,
    ErrorMessages.serverError,
  );

  /// Unauthorized access error when the current session is not valid
  static CommonError unAuthorizedAccess = CommonError(
    ErrorCodes.unAuthorizedAccess,
    ErrorMessages.unAuthorizedAccess,
  );

  /// Service fail error when api failed to fetch data due to timeout
  static CommonError apiTimeOutError = CommonError(
    ErrorCodes.apiTimeOutError,
    ErrorMessages.apiTimeOutError,
  );

  /// toString() method override that can be used to print the error object
  /// into your debug console for better debugging.
  @override
  String toString() {
    return 'CommonError{code : $code, description : " $description "}';
  }
}

/// CommonServiceError extends from CommonError class extends the error class with
/// additional api request and response based data for better debugging
class CommonServiceError extends CommonError {
  /// Status code for the api request
  final int statusCode;

  /// Api url for the request
  final String url;

  /// Api response for the request
  final String response;

  /// Default constructor for the class
  CommonServiceError(int code, String description, this.statusCode, this.url,
      {this.response})
      : super(code, description);

  /// Static method to parse the service side errors into an error object.
  ///
  /// [json] : Api response as map
  /// [parentErrorKey]: Key for identify the error part.
  /// [errorCodeKey]: Key for identify error code.
  /// [errorMessageKey]: key for identify error message part.
  static CommonServiceError errorFromJson(var json,
      {String parentErrorKey = 'error',
      String errorCodeKey = 'code',
      String errorMessageKey = 'message'}) {
    if (json == null) return null;

    try {
      // Checking for error object
      var errorObject = json[parentErrorKey];
      if (errorObject != null) {
        String errorCodeString = errorObject[errorCodeKey];
        if (errorCodeString != null) {
          String errorDescription = errorObject[errorMessageKey];
          final errorCode = int.parse(errorCodeString);
          final error = CommonServiceError(
              errorCode ?? -1, errorDescription, errorCode ?? -1, null);
          debugPrint(error.toString());
          return error;
        }
      }
    } catch (e) {
      debugPrint(
          'Unable to create CommonServiceError instance ::: ${e.toString()}');
    }
    return null;
  }
}

/// The class gives information about the error codes used inside the app
class ErrorCodes {
  static const int internalError = 10001;
  static const int noInternet = 10002;
  static const int serverError = 10003;
  static const int unAuthorizedAccess = 10004;
  static const int apiTimeOutError = 10005;
}

//TODO: ErrorMessages should be localised.
/// The class gives information about the error messages used inside the app
class ErrorMessages {
  static const String internalError =
      'Some unexpected error occurred. Please try again!';
  static const String noInternet =
      'Unable to connect to server. Please try again later!';
  static const String serverError =
      'Server communication failed. Please try again!';
  static const String unAuthorizedAccess =
      'Your current session is expired. Please login again!';
  static const String apiTimeOutError =
      'Request timeout. Please try again later!';
}
