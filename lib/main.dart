import 'dart:async';
import 'dart:io';
import 'package:bblease/Flow/Rental/active_rent.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/home_page.dart';
import 'package:bblease/Flow/my_shared_preferences.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/common_funcs.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:accessibility_tools/accessibility_tools.dart';
import 'Flow/welcome.dart';
import 'models/class_rent.dart';
import 'models/class_user.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
//await mySharedPreferences.initializeSharedPreferences(); // Initialize app state

  await SentryFlutter.init(
    (options) {
      options.dsn = kDebugMode
          ? ''
          : 'https://69a96f2b12155c0d347296db8a687277@o4506574440759296.ingest.sentry.io/4506574487289856';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      options.debug = false;
    },
  );

  FlutterError.onError = (FlutterErrorDetails errorDetails) {
    if (kDebugMode) {
      FlutterError.presentError(errorDetails);
      //myErrorsHandler.onErrorDetails(errorDetails);
    }
    Sentry.captureException(
      errorDetails.exception,
      stackTrace: errorDetails.stack,
    );
  };

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(MyApp());
  }, (error, stackTrace) {
    debugPrint('Zone Error Handler: $error');
    debugPrint('$stackTrace');
    // Handle the error as needed, e.g., log it
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  late final Future<bool> myFuture = isLogin();

  MaterialStateProperty<Color?> _customColor() {
    return MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return turquoiseColorApp; // Return this color when the date is selected
        }
        return turquoiseColorApp; // Otherwise, return this color
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(child: OrientationBuilder(builder: (context, orientation) {
      debugPrint('orientation main ${orientation.name} ');
      return ScreenUtilInit(
        designSize: orientation == Orientation.portrait
            ? Size(393, 852)
            : Size(1440, 1024),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            localizationsDelegates: [
              //AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              //GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('he'),
              const Locale('en'),
            ],
            title: 'Flutter Demo',
            theme: ThemeData(
                fontFamily: 'PLONI',
                scaffoldBackgroundColor: Colors.white,
                textTheme:
                    TextTheme(bodyMedium: TextStyle(color: blackColorApp)),
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: Colors.white,
                  cancelButtonStyle:
                      ButtonStyle(foregroundColor: _customColor()),
                  confirmButtonStyle:
                      ButtonStyle(foregroundColor: _customColor()),
                  dayPeriodColor: blackColorApp,
                  dialBackgroundColor: Colors.cyan[100],
                  hourMinuteColor: Colors.cyan[100],
                  hourMinuteTextColor: blackColorApp,
                  dialHandColor: turquoiseColorApp,
                  elevation: 2,
                  dialTextColor: blackColorApp,
                  entryModeIconColor: pinkColorApp,
                ),
                datePickerTheme: DatePickerThemeData(
                  backgroundColor: Colors.white,
                  elevation: 2,
                  headerBackgroundColor: Colors.white,
                  todayBackgroundColor: _customColor(),
                  headerForegroundColor: blackColorApp,
                  cancelButtonStyle:
                      ButtonStyle(foregroundColor: _customColor()),
                  confirmButtonStyle:
                      ButtonStyle(foregroundColor: _customColor()),
                  todayBorder: BorderSide(color: blackColorApp),
                  rangePickerBackgroundColor: turquoiseColorApp,
                  rangeSelectionBackgroundColor: Colors.cyan[100],
                )
                // primarySwatch: Color.fromARGB(15, 21, 17, 1),
                ),
            home: Scaffold(
              body: FutureBuilder<bool>(
                  future: myFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is bool && snapshot.data == true) {
                        if (User().tranzilaStatus) {
                          MySharedPreferences().setLastUsage();
                          if (User().currentRent != null) {
                            return const ActiveRentDetails();
                          }
                          return const RentalWidget();
                        } else {
                          return const WelcomeForm();
                        }
                      }
                      return const WelcomeForm();
                    }
                    if (snapshot.hasError) {
                      debugPrint('error: ${snapshot.error}');
                      CommonFuncs()
                          .showMyToast('בעיה בלתי צפויה, נסה להכנס שנית');
                      return Container();
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: pinkColorApp,
                      ));
                    }
                  }),
            ),
          );
        },
      );
    }));
  }

  Future<bool> isLogin() async {
    debugPrint('isLogin');
    int userId = await MySharedPreferences().getUserId();
    if (userId == -1) {
      return false;
    }
    DateTime lastUsage = await MySharedPreferences().getLastUsage();
    debugPrint('lastUsage $lastUsage');
    DateTime dt = DateTime.now().add(const Duration(days: -3));
    if (lastUsage.isAfter(dt)) //is login
    {
      await ApiService().getUserById(userId, (res) {
        User.fromJson(res['customer']);
        print('before');
        if (res["active_order"] != -1 /*||res["active_order"].isNotEmpty*/) {
          print(res["active_order"]);
          User().currentRent = Rental.fromJson(res["active_order"]);
        }
        debugPrint('user name  ${User().firstName}');
      });
    } else {
      await MySharedPreferences().clearAllSharedPreference();
    }

    return lastUsage.isAfter(dt);
  }
}
