import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/my_shared_preferences.dart';
import 'package:bblease/Flow/registration/payment_webVIew.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/common_funcs.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Flow/welcome.dart';
import 'models/class_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//await mySharedPreferences.initializeSharedPreferences(); // Initialize app state

  FlutterError.onError = (FlutterErrorDetails errorDetails) {
    if (kDebugMode) {
      FlutterError.presentError(errorDetails);
      // myErrorsHandler.onErrorDetails(errorDetails);
    }
  };

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  late final Future<bool> myFuture = isLogin();


  MaterialStateProperty<Color?> _customColor() {
    return MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return colors
              .turquoiseColorApp; // Return this color when the date is selected
        }
        return colors.turquoiseColorApp; // Otherwise, return this color
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  fontFamily: 'PLONI',
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: TextTheme(
                      bodyMedium: TextStyle(color: colors.blackColorApp)),
                  datePickerTheme: DatePickerThemeData(
                    backgroundColor: Colors.white,
                    elevation: 2,
                    headerBackgroundColor: Colors.white,
                    todayBackgroundColor: _customColor(),
                    rangeSelectionBackgroundColor: Colors.cyan[100],
                  )
                  // primarySwatch: Color.fromARGB(15, 21, 17, 1),
                  ),
              home: Scaffold(
                body: FutureBuilder<bool>(
                    future:myFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data is bool && snapshot.data == true) {

                           if(User().tranzilaStatus) {
                             MySharedPreferences().setLastUsage();
                             return const RentalWidget();
                           }
                           else
                             {
                               return const WelcomeForm();
                             }
                        }
                        return const WelcomeForm();
                      }
                      if(snapshot.hasError)
                        {
                          debugPrint('error: ${snapshot.error}');
                         CommonFuncs().showMyToast('בעיה בלתי צפויה, נסה להכנס שנית');
                         return Container();
                        }
                      else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            );
          }),
    );
  }

  Future<bool> isLogin() async {
    debugPrint('isLogin');
    int userId = await MySharedPreferences().getUserId();
    if (userId==-1) {
      return false;
    }
    DateTime lastUsage = await MySharedPreferences().getLastUsage();
    debugPrint('lastUsage $lastUsage');
    DateTime dt = DateTime.now().add(const Duration(days: -3));
    if(lastUsage.isAfter(dt)) //is login
      {
         await ApiService().getUserById(userId, (res) {
           User.fromJson(res['customer']);
           debugPrint('user name  ${User().firstName}');
         });
      }
    else{
      await MySharedPreferences().clearAllSharedPreference();
    }

    return lastUsage.isAfter(dt);
  }
}
