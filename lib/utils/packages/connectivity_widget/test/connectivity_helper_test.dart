import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_widget/connectivity_helper.dart';

void main() {
  StreamController<ConnectionResult> connectionChangeController;
  WidgetsFlutterBinding.ensureInitialized();

  ConnectionResult emittedValue;

  group('startWith', () {

    setUp(() {
      connectionChangeController = ConnectivityHelper().connectionChangeController;
      connectionChangeController.stream.listen((event) {
        emittedValue = event;
      });
    });

    test('Check connections', () async {
      expect(await ConnectivityHelper().checkConnection(result: ConnectivityResult.none), false);
      expect(await ConnectivityHelper().checkConnection(result: ConnectivityResult.wifi), true);
    });

    test('Check streamController update on no internet connection', () async {
      final connectionStatus = await ConnectivityHelper().checkConnection(result: ConnectivityResult.none);
      await Future(() {});
      expect(connectionStatus, false);
      expect(emittedValue.status, ConnectivityType.None);
    });

    test('Check streamController update on Wifi connection', () async {
      final connectionStatus = await ConnectivityHelper().checkConnection(result: ConnectivityResult.wifi);
      await Future(() {});
      expect(connectionStatus, true);
      expect(emittedValue.status, ConnectivityType.WiFi);
    });

    test('Check streamController update on mobile network connection', () async {
      final connectionStatus = await ConnectivityHelper().checkConnection(result: ConnectivityResult.mobile);
      await Future(() {});
      expect(connectionStatus, true);
      expect(emittedValue.status, ConnectivityType.Cellular);
    });

  });
}
