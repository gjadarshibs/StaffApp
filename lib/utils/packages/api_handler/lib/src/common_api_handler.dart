import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common_error.dart';
import 'dart:async';
import 'api_response.dart';

enum RequestType { get, post, put, delete }

typedef OnTimeout = FutureOr<dynamic> Function();

class ApiHandler {

  const ApiHandler(this.baseUrl);

  final String baseUrl;

  /// Sends an HTTP request with the given type, headers and body to the given URL,
  ///
  /// [path] is a string, this will give the path for particular request. Here
  /// path we can consider as a complete URL or a specific location name.
  ///
  /// [type] is an Enum. This represent the http request type.
  ///
  /// [headers] is a map. This used for the header of the request.
  ///
  /// [queryParameter] is a map. This is used for setting get request query parameter.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding]. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  /// [encoding] defaults to [utf8].

  Future<ApiResponse> requestWith(
      {String path = '',
        RequestType type = RequestType.get,
        Map<String, String> headers,
        Map<String, dynamic> queryParameter,
        body,
        Encoding encoding,
        Duration timeLimit = const Duration(seconds: 60),
        OnTimeout onTimeout}) async {
    ApiResponse apiResponse;

    /// If path contain http as prefix then set endpointURL as path else combine base URL and path.
    var endpointURL = path.startsWith('http') ? path : (baseUrl + path);

    /// If you're making multiple requests to the same server, you can keep open a persistent connection by
    /// using a Client rather than making one-off requests. If you do this, make sure to close the client when you're done:
    /// Ref: https://pub.dev/packages/http
    final client = http.Client();

    try {
      var response;
      switch (type) {
        case RequestType.get:
          if (queryParameter != null) {
            final jsonString = Uri(queryParameters: queryParameter);
            final queryParameterString = '?${jsonString.query}';
            endpointURL = endpointURL + queryParameterString;
          }
          response = await client
              .get(endpointURL, headers: headers)
              .timeout(timeLimit, onTimeout: onTimeout);
          break;
        case RequestType.post:
          response = client
              .post(endpointURL,
              headers: headers, body: body, encoding: encoding)
              .timeout(timeLimit, onTimeout: onTimeout);
          break;
        case RequestType.put:
          response = client
              .put(endpointURL,
              headers: headers, body: body, encoding: encoding)
              .timeout(timeLimit, onTimeout: onTimeout);
          break;
        case RequestType.delete:
          response = await client
              .delete(endpointURL, headers: headers)
              .timeout(timeLimit, onTimeout: onTimeout);
          break;
      }

      /// Handling the api response
      apiResponse = _returnResponse(response);
    } on TimeoutException catch (e) {
      debugPrint('Timeout exception caught for ' +
          endpointURL +
          ':::\n' +
          e.toString());
      throw CommonError.apiTimeOutError;
    } on SocketException {
      throw CommonError.noInternet;
    } finally {
      client.close();
    }
    return apiResponse;
  }

  /// Using Http response this method will create a custom ApiResponse model
  ///
  /// [response] is http.Response.
  /// return ApiResponse object.

  ApiResponse _returnResponse(http.Response response) {
    if (response == null) throw CommonError.serverError;

    final responseBody = response.body;
    final statusCode = response.statusCode;

    final pathURL = response.request.url;
    debugPrint(
        'Status code for ' '($pathURL}' '::: ' + statusCode.toString());
    debugPrint('Response for ' '($pathURL)' ':::\n' + responseBody);
    debugPrint('---------------------------------------------------------');
    debugPrint('\n');

    /// Checking for session not valid case first
    if (statusCode != null && statusCode == 401) {
      throw CommonError.unAuthorizedAccess;
    }

    /// Starting other response validations
    if (responseBody == null || responseBody.isEmpty) {
      throw CommonError.serverError;
    } else {
      return ApiResponse(statusCode, responseBody);
    }
  }
}
