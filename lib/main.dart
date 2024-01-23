import 'dart:io';

import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/home_page.dart';
import 'package:bblease/Flow/my_shared_preferences.dart';
import 'package:bblease/Flow/registration/payment_webVIew.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/common_funcs.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Flow/welcome.dart';
import 'models/class_user.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
//await mySharedPreferences.initializeSharedPreferences(); // Initialize app state



  await SentryFlutter.init(
        (options) {
      // options.dsn = 'https://1a290abc6f7cde70a98f4c870720d628@o4505141567619072.ingest.sentry.io/4506534991298560';
          options.dsn = kDebugMode ? '' : 'https://69a96f2b12155c0d347296db8a687277@o4506574440759296.ingest.sentry.io/4506574487289856';
          // options.dsn = 'https://69a96f2b12155c0d347296db8a687277@o4506574440759296.ingest.sentry.io/4506574487289856';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      options.debug=false;
    },
    appRunner: () => runApp(MyApp()),
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

  // runApp( MyApp());
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
              localizationsDelegates: [
                //AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('he'),
                //const Locale('en'),

              ],
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
                             return  const HomePage();
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
