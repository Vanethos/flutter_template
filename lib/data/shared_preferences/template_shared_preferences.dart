import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// Class for handling writing and reading directly from SharedPreferences
///
/// [_sharedPreferences] is given by the [Future] [SharedPreferences.getInstance()]
class TemplateSharedPreferences {
  SharedPreferences _sharedPreferences;

  TemplateSharedPreferences(this._sharedPreferences);

  //region Mock
  String getMock() {
    return _sharedPreferences.getString(_mockKey);
  }

  Future<bool> saveMock(String mock) {
    return _sharedPreferences.setString(_mockKey, mock);
  }
  //endregion
}

const _mockKey = "mock_key";