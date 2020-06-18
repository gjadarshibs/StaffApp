import 'dart:convert';
import 'common_error.dart';

/// Class represents a parsed response from an API service
class ApiResponse {
  /// Status code of the api response
  int code;

  /// Response as [String] from the service
  String body;

  /// Default constructor for the class
  ApiResponse(this.code, this.body);

  /// Function checks whether the response is a non-error
  /// NOTE: Here we are not checking any internal errors.
  ///
  /// [bool] represents whether the response is Success or not.
  bool get isSuccess {
    return code == 200;
  }

  @override
  String toString() {
    return 'Response {code : $code, response : " $body "}';
  }

  /// This method will return response json
  dynamic get responseJSON => json.decode(body.toString());

  /// The method will check whether there is any internal errors in the
  /// response and if there any it will create a [CommonServiceError] object for that
  /// error and send it back as return value.
  ///
  /// [parentErrorKey]: Key for identify the error part.
  /// [errorCodeKey]: Key for identify error code.
  /// [errorMessageKey]: key for identify error message part.
  CommonServiceError internalError(
      {String parentErrorKey = 'error',
      String errorCodeKey = 'code',
      String errorMessageKey = 'message'}) {
    return CommonServiceError.errorFromJson(responseJSON,
        parentErrorKey: parentErrorKey,
        errorCodeKey: errorCodeKey,
        errorMessageKey: errorMessageKey);
  }
}
