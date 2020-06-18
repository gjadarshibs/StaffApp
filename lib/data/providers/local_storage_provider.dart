import 'dart:convert';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// These are common errors may happen when wprking the LocalStorageProvider
enum LocalStorageExceptionType {
  /// The key is not found in SharedPreferences
  noKey,

  /// The key is in the SharedPreferences but no value is present
  noValueForKey,

  /// Try to save or read unknown class.
  notAnEntity,

  /// God knows what happend.
  unknown
}

/// Exception handling of LocalStorageProvider
/// there is higher chance of getting exceptions and null values
/// when working with [SharedPreferences] this class is indeed to handle those scenarios.
class LocalStorageException implements Exception {
  LocalStorageException(this.type, [this._message]);

  /// This Constructor is for utilizing predefined exception message
  /// Expected use this class for allmost all cases.
  LocalStorageException.type(LocalStorageExceptionType type) {
    switch (type) {
      case LocalStorageExceptionType.noKey:
        type = type;
        _message = 'No key found in SharedPreferences, key == null';
        break;
      case LocalStorageExceptionType.noValueForKey:
        type = type;
        _message =
            'No value found for the key in SharedPreferences, value[key] == null';
        break;
      case LocalStorageExceptionType.notAnEntity:
        type = type;
        _message = 'unknown data type passed for operation';
        break;
      default:
        type = LocalStorageExceptionType.unknown;
        _message = 'undefined Exception';
        break;
    }
  }

  /// Type of exception
  LocalStorageExceptionType type;

  /// Short discription of reason for the Exception.
  String _message;
  @override
  String toString() {
    return _message;
  }
}

enum LocalStorageEntity { user, corporate }

/// This class is acting as the provider of SharedPreferences data.
/// All SharedPreferences data is kept as json string which must have
/// a counter part Model class.
class LocalStorageProvider {
  final _corporatePreferenceKey = 'corporate_preference_key';
  final _userPreferenceKey = 'user_preference_key';
  final _remember_login_key = 'remember_login_key';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
 

 Future<bool> isRememberLoginAdded() async {

    final pref = await _prefs;
    final rememberLogin  = pref.get(_remember_login_key);
    if (rememberLogin != null) {
       return true;
    } else {
        return false;
    }
  }

  Future<bool> removeRememberLogin() async {
    return _prefs
        .then((value) => value.remove(_remember_login_key));
  }
  Future<bool> addRememberLogin() async {
    return _prefs
        .then((value) => value.setString(_remember_login_key, 'Yes'));
  }

  /// If there is no AuthPreference error will be thrown.
  Future<CorporatePreference> _readCorporatePreference() async {
    // if no value stored, error will be thrown.
    return _prefs.then((prefs) {
      final String jsonString = prefs.get(_corporatePreferenceKey);
      if (jsonString == null) {
        throw LocalStorageException.type(LocalStorageExceptionType.noKey);
      }
      Map json = jsonDecode(jsonString);
      if (json == null) {
        throw LocalStorageException.type(
            LocalStorageExceptionType.noValueForKey);
      }
      return CorporatePreference.fromJson(json);
    });
  }

  /// To update saved AuthPreferenceData or add new the preference.
  Future<bool> _updateCorporatePreference(CorporatePreference data) async {
    final jsonString = jsonEncode(data.toJson());
    return _prefs
        .then((value) => value.setString(_corporatePreferenceKey, jsonString));
  }

  /// If there is no AuthPreference error will be thrown.
  Future<UserPreference> _readUserPreference() async {
    // if no value stored, error will be thrown.
    return _prefs.then((prefs) {
      final String jsonString = prefs.get(_userPreferenceKey);
      if (jsonString == null) {
        throw LocalStorageException.type(LocalStorageExceptionType.noKey);
      }
      Map json = jsonDecode(jsonString);
      if (json == null) {
        throw LocalStorageException.type(
            LocalStorageExceptionType.noValueForKey);
      }
      return UserPreference.fromJson(json);
    });
  }

  /// To update saved AuthPreferenceData or add new the preference.
  Future<bool> _updateUserPreference(UserPreference data) async {
    final jsonString = jsonEncode(data.toJson());

    return _prefs
        .then((value) => value.setString(_userPreferenceKey, jsonString));
  }

  Future<bool> remove(LocalStorageEntity entity) {
    switch (entity) {
      case LocalStorageEntity.corporate:
        return _prefs.then((prefs) {
          return prefs.remove(_corporatePreferenceKey);
        }).catchError((onError) {
          throw LocalStorageException.type(LocalStorageExceptionType.unknown);
        });
      case LocalStorageEntity.user:
        return _prefs.then((prefs) {
          return prefs.remove(_userPreferenceKey);
        }).catchError((onError) {
          throw LocalStorageException.type(LocalStorageExceptionType.unknown);
        });
      default:
        throw LocalStorageException.type(LocalStorageExceptionType.unknown);
    }
  }

  Future<dynamic> read(LocalStorageEntity entity) {
    switch (entity) {
      case LocalStorageEntity.corporate:
        return _readCorporatePreference();
      case LocalStorageEntity.user:
        return _readUserPreference();
      default:
        throw LocalStorageException.type(LocalStorageExceptionType.notAnEntity);
    }
  }

  Future<bool> update(LocalStorageEntity entity, dynamic data) {
    if (data is CorporatePreference || data is UserPreference) {
      switch (entity) {
        case LocalStorageEntity.user:
          return _updateUserPreference(data);
        case LocalStorageEntity.corporate:
          return _updateCorporatePreference(data);
        default:
          throw LocalStorageException.type(
              LocalStorageExceptionType.notAnEntity);
      }
    } else {
      throw LocalStorageException.type(LocalStorageExceptionType.notAnEntity);
    }
  }
}
