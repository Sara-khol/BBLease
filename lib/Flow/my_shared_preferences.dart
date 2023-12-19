import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class  MySharedPreferences{

  late SharedPreferences _prefs;
  late DateTime _lastUsage;

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // Retrieve the last usage timestamp, defaulting to the current time if not found.
    _lastUsage = DateTime.fromMillisecondsSinceEpoch(
    _prefs.getInt('lastUsage') ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  void updateLastUsage() {
    // Update the last usage timestamp to the current time.
      _lastUsage = DateTime.now();

    _prefs.setInt('lastUsage', _lastUsage.millisecondsSinceEpoch);
  }

  void updateUserId(String phone) {
    _prefs.setString('userPhone', phone);
  }
}
final mySharedPreferences = MySharedPreferences(); // Create a singleton instance of AppState

