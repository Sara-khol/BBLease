import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';



class  MySharedPreferences{

  late SharedPreferences _prefs;

  MySharedPreferences._privateConstructor(); // Private constructor for singleton

  static final MySharedPreferences _instance = MySharedPreferences._privateConstructor();

  factory MySharedPreferences() {
    return _instance;
  }

  // Future<void> initializeSharedPreferences() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   // Retrieve the last usage timestamp, defaulting to the current time if not found.
  //   _lastUsage = DateTime.fromMillisecondsSinceEpoch(
  //   _prefs.getInt('lastUsage') ?? DateTime.now().millisecondsSinceEpoch,
  //   );
  // }

   setLastUsage() async{
    _prefs = await SharedPreferences.getInstance();
    // Update the last usage timestamp to the current time.
    _prefs.setInt('lastUsage', DateTime.now().millisecondsSinceEpoch);
  }

Future<DateTime>  getLastUsage() async
  {
    _prefs = await SharedPreferences.getInstance();
    return  DateTime.fromMillisecondsSinceEpoch(_prefs.getInt('lastUsage')??DateTime.now().millisecondsSinceEpoch);

  }

   setUserId(int userId)  async
  {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('userId', userId);
  }

 Future<int> getUserId()  async
  {
    _prefs = await SharedPreferences.getInstance();
    return  _prefs.getInt('userId')??-1;
  }



  clearAllSharedPreference() async
  {
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }
}
// final mySharedPreferences = MySharedPreferences(); // Create a singleton instance of AppState

