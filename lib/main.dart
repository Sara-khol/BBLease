
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/my_shared_preferences.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




import 'package:bblease/Flow/Rental//search_car.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Flow/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await mySharedPreferences.initializeSharedPreferences(); // Initialize app state

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialStateProperty<Color?> _customColor() {
    return MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return colors.turquoiseColorApp;  // Return this color when the date is selected
        }
        return colors.turquoiseColorApp;  // Otherwise, return this color
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'PLONI',
        scaffoldBackgroundColor: Colors.white,
          textTheme:
           TextTheme(bodyMedium: TextStyle(color:colors.blackColorApp)),
        datePickerTheme: DatePickerThemeData(
           backgroundColor: Colors.white,
           elevation: 2,
           headerBackgroundColor: Colors.white,
         todayBackgroundColor: _customColor(),
         rangeSelectionBackgroundColor: Colors.cyan[100],

       )
       // primarySwatch: Color.fromARGB(15, 21, 17, 1),
      ),
      home: const WelcomeForm(),
    );
      });
  }

  Future<bool> showLoginPage() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    // sharedPreferences.setString('user', 'hasuser');

    String? user = sharedPreferences.getString('user');

    return user == null;
  }
}

