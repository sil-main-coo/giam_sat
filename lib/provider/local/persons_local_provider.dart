import 'dart:convert';

import 'package:attendance_app/configs/shared_preferences_keys.dart';
import 'package:attendance_app/model/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonLocalProvider {
  Future<Persons> getPersonsFromLocal() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final response = sharedPrefs.getString(SharedPrefsKeys.persons);
    print('>>> persons local : $response');
    if (response != null) {
      return Persons.fromJson(jsonDecode(response));
    }
    return null;
  }

  Future<bool> savePersonsToLocal(Persons persons) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setString(
        SharedPrefsKeys.persons, jsonEncode(persons.toJson()));
  }

  Future<void> removePersonsFromLocal() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.remove(SharedPrefsKeys.persons);
  }
}
