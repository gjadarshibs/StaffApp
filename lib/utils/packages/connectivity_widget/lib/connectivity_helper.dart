import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity/connectivity.dart';

/// Connectivity type Enum
enum ConnectivityType {
  WiFi,
  Cellular,
  None
}

/// Custom class for handle connectivity type and internet availability.
class ConnectionResult {
  const ConnectionResult(this.status, this.hasConnection);

  /// This will provide connectivity type enum
  final ConnectivityType status;

  /// This will provide internet availability status.
  final bool hasConnection;
}

/// This a helper class to handle connectivity package and
class ConnectivityHelper {

  /// Constructs a singleton instance of [ConnectivityHelper].
  ///
  /// [ConnectivityHelper] is designed to work as a singleton.
  /// When a second instance is created, the first instance will not be able to listen to the
  /// EventChannel because it is overridden. Forcing the class to be a singleton class can prevent
  /// misuse of creating a second instance from a programmer.
  factory ConnectivityHelper() {
    return _singleton ?? ConnectivityHelper._();
  }

  ConnectivityHelper._();

  static ConnectivityHelper _singleton;

  /// This is how we'll allow subscribing to connection changes
  StreamController<ConnectionResult> connectionChangeController =
      StreamController.broadcast();

  /// flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  /// Hook into flutter_connectivity's Stream to listen for changes
  /// And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  /// This will provide connection change streams.
  Stream get connectionChange => connectionChangeController.stream;

  /// Check if device is connected to the internet
  ///
  /// returns [Future<bool>] with value [true] of connected to the
  /// internet
  Future<bool> get isConnected async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return  await checkConnection(result: connectivityResult, updateStream: false);
  }

  /// Check the device connectivity type
  ///
  /// returns [Future<ConnectivityType>] with value [ConnectivityType.WiFi] or
  /// [ConnectivityType.Cellular] or [ConnectivityType.None]
  Future<ConnectivityType> get connectivityType async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return  _getStatusFromResult(connectivityResult);
  }

  /// A clean up method to close our StreamController
  ///
  /// Because this is meant to exist through the entire application life cycle this isn't really an issue
  void dispose() {
    connectionChangeController.close();
  }

  ///flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection(result: result);
  }

  ///The test to actually see if there is a connection
  Future<bool> checkConnection({ConnectivityResult result, bool updateStream = true}) async {
    var hasConnection = false;

    if (result == ConnectivityResult.none) {
      hasConnection = false;
    } else {
      hasConnection = await _isInternetAvailable;
    }

    ///The connection status changed send out an update to all listeners
    if (updateStream) {
      final connectivityStatus = (result == null)
          ? ConnectivityType.None
          : _getStatusFromResult(result);
      connectionChangeController
          .add(ConnectionResult(connectivityStatus, hasConnection));
    }

    return hasConnection;
  }

  /// Check if device is connected to the internet
  ///
  /// This method tries to access google.com to verify for
  /// internet connection
  ///
  /// returns [Future<bool>] with value [true] of connected to the
  /// internet
  Future<bool> get _isInternetAvailable async {
    var hasConnection = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }
    return hasConnection;
  }

  /// Convert from the ConnectivityResult enum to our own enum
  ///
  /// This method will accept [ConnectivityResult] and
  /// return [ConnectivityType] enum.
  ConnectivityType _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityType.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityType.WiFi;
      default:
        return ConnectivityType.None;
    }
  }
}
