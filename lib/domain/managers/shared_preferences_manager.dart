import 'dart:async';

import 'package:flutter_template/data/shared_preferences/template_shared_preferences.dart';

/// Class for managing data from Shared Preferences
/// 
/// In this class we will manipulate data so that it can be presented to
/// the UI, for example, convert an int to a DateTime or assigning default
/// values to Strings
class SharedPreferencesManager {
  TemplateSharedPreferences _sharedPreferences;

  SharedPreferencesManager(this._sharedPreferences);

  //region Mock
  String getMock() {
    return _sharedPreferences.getMock();
  }

  Future<bool> saveMock(String mock) {
    return _sharedPreferences.saveMock(mock);
  }
  //endregion
}