import 'package:flutter/foundation.dart';

import 'accessibility.dart';

abstract class Options {
  Map<String, String> get params => _toMap();

  Map<String, String> _toMap() {
    throw Exception('Missing implementation');
  }
}

class IOSOptions extends Options {
  IOSOptions(
      {String groupId,
      IOSAccessibility accessibility = IOSAccessibility.unlocked})
      : _accessibility = accessibility;

  final IOSAccessibility _accessibility;

  @override
  Map<String, String> _toMap() {
    final m = <String, String>{};

    if (_accessibility != null) {
      m['accessibility'] = describeEnum(_accessibility);
    }
    return m;
  }
}

class AndroidOptions extends Options {
  @override
  Map<String, String> _toMap() {
    return <String, String>{};
  }
}
