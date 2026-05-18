import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:bblease/Flow/Rental/active_rent.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/my_shared_preferences.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/services/app_update_service.dart';
import 'package:bblease/utils/common_funcs.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Flow/Dialogs/buttom_dialogs.dart';
import 'Flow/registration/wait_for_approve_screen.dart';
import 'models/class_rent.dart';
import 'models/class_user.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
//final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
//await mySharedPreferences.initializeSharedPreferences(); /flutt/ Initialize app state

  await SentryFlutter.init(
          (options) {
            options.dsn = kDebugMode
                ? ''
                : 'https://69a96f2b12155c0d347296db8a687277@o4506574440759296.ingest.us.sentry.io/4506574487289856';
            options.tracesSampleRate = 1.0;
           // options.debug = false;

            options.sendDefaultPii = true;
            options.enablePrintBreadcrumbs = true;
          },
        appRunner:
            () {
          // טיפול בשגיאות Flutter Framework
          FlutterError.onError = (FlutterErrorDetails errorDetails) {
            if (kDebugMode) {
              /*debugPrint('Flutter Framework Error: ${errorDetails.exception}');
              debugPrint('${errorDetails.stack}');*/
              FlutterError.presentError(errorDetails);

            }

            // שליחת השגיאה ל-Sentry
            Sentry.captureException(
              errorDetails.exception,
              stackTrace: errorDetails.stack,
            );
          };

          // טיפול בשגיאות Async שלא נתפסו
          PlatformDispatcher.instance.onError = (error, stack) {
            if (kDebugMode) {
              debugPrint('Uncaught async error: $error');
              debugPrint('$stack');
            }
            Sentry.captureException(error, stackTrace: stack);
            return true;
          };

          runApp(MyApp());
        });
}


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  Size _lastLogicalSize = Size.zero;
  late final Future<bool> myFuture = isLogin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  //   // Cold-start check. Runs once after the first frame is on screen so the
  //   // dialog never lands during the initial loading spinner.
  //   WidgetsBinding.instance.addPostFrameCallback((_) => _runUpdateCheck());
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     _runUpdateCheck();
  //   }
  // }
  //
  // void _runUpdateCheck() {
  //   final ctx = appNavigatorKey.currentContext;
  //   if (ctx == null) return;
  //   // Fire-and-forget — the service handles its own errors silently.
  //   AppUpdateService.instance.checkForUpdate(ctx);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalSize = view.physicalSize / view.devicePixelRatio;



    if (_lastLogicalSize != logicalSize) {
      _lastLogicalSize = logicalSize;
      debugPrint('didChangeMetrics -> $logicalSize');
      if (mounted) {
        setState(() {});
      }
    }
  }


  WidgetStateProperty<Color?> _customColor() {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return turquoiseColorApp; // Return this color when the date is selected
        }
        return turquoiseColorApp; // Otherwise, return this color
      },
    );
  }

  Size _getDesignSize(BuildContext context) {
    final view = View.of(context);
    final size = view.physicalSize / view.devicePixelRatio;

    final width = size.width;
    final height = size.height;
    final isLandscape = width > height;

    debugPrint('---- SCREEN INFO ----');
    debugPrint('logical width: $width');
    debugPrint('logical height: $height');
    debugPrint('isLandscape: $isLandscape');

    if (width >= 900) {
      debugPrint('designSize selected: 1440x1024 (large screen)');
      return const Size(1440, 1024);
    }

    if (isLandscape) {
      debugPrint('designSize selected: 852x393 (phone landscape)');
      return const Size(852, 393);
    }

    debugPrint('designSize selected: 393x852 (phone portrait)');
    return const Size(393, 852);
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(child: Builder(builder: (context) {
      final designSize = _getDesignSize(context);

     // debugPrint('orientation main ${orientation.name} ');
      return ScreenUtilInit(
        useInheritedMediaQuery: true,
        //useInheritedMediaQuery: true,
        designSize:designSize,
        // designSize: orientation == Orientation.portrait
        //     ? const Size(393, 852)
        //     : const Size(1440, 1024),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
      //debugPrint('orientation main ${(ScreenUtil()).pixelRatio} ');
          return MaterialApp(
//            navigatorKey: appNavigatorKey,
            navigatorObservers: [routeObserver],
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              //AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              //GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('he'),
              Locale('en'),
            ],
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
            title: 'B click',
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
                          if(User().customerStatus=='active_customer') {
                            MySharedPreferences().setLastUsage();
                            if (User().currentRent != null) {
                              return const ActiveRentDetails();
                            }
                            return const RentalWidget();
                          }
                          else{
                            return const WAitForApproveScreen();
                          }
                        } else {
                          return const TelToRegistrationForm();
                        }
                      }
                      return const TelToRegistrationForm();
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
    debugPrint('ddd ${ScreenUtil().pixelRatio}');
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
