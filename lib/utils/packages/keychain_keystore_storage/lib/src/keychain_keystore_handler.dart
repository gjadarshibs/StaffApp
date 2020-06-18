import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'platform_options.dart';

extension KeychainKeystoreHandler on String {
  static const MethodChannel _channel = MethodChannel('keychainkeystoreplugin');

  /// Encrypts and saves the [key] with the given [value].
  ///
  /// If the key was already in the storage, its associated value is changed.
  /// [value] and [key] shoudn't be null.
  /// [iOptions] optional iOS options
  /// [aOptions] optional Android options
  /// Can throw a [PlatformException].
  Future<bool> writeIntoKechainOrKeystore(
          {@required String key,
          IOSOptions iOptions,
          AndroidOptions aOptions}) async =>
      _channel.invokeMethod('write', <String, dynamic>{
        'key': key,
        'value': this,
        'options': _selectOptions(iOptions, aOptions)
      });

  /// Decrypts and returns the value for the given [key] or null if [key] is not in the storage.
  ///
  /// [key] shoudn't be null.
  /// [iOptions] optional iOS options
  /// [aOptions] optional Android options
  /// Can throw a [PlatformException].
  Future<String> readFromKechainOrKeystore(
      {IOSOptions iOptions, AndroidOptions aOptions}) async {
    final value = await _channel.invokeMethod('read', <String, dynamic>{
      'key': this,
      'options': _selectOptions(iOptions, aOptions)
    });
    return value;
  }

  /// Deletes associated value for the given [key].
  ///
  /// [key] shoudn't be null.
  /// [iOptions] optional iOS options
  /// [aOptions] optional Android options
  /// Can throw a [PlatformException].
  Future<bool> deleteFromKeychainKeystore(
          {IOSOptions iOptions, AndroidOptions aOptions}) =>
      _channel.invokeMethod('delete', <String, dynamic>{
        'key': this,
        'options': _selectOptions(iOptions, aOptions)
      });

  /// Select correct options based on current platform
  Map<String, String> _selectOptions(
      IOSOptions iOptions, AndroidOptions aOptions) {
    return Platform.isIOS ? iOptions?.params : aOptions?.params;
  }
}
