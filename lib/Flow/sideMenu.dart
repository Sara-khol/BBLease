import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/UserInformation/price_list.dart';
import 'package:bblease/Flow/UserInformation/profile.dart';
import 'package:bblease/Flow/my_shared_preferences.dart';
import 'package:bblease/Flow/registration/payment_webView.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:bblease/Flow/UserInformation/ordersHistory.dart';
import 'package:bblease/Flow/UserInformation/terms_and_conditions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bblease/services/support.dart' as support;
import '../models/class_user.dart';
import '../services/api_service.dart';
import '../utils/common_funcs.dart';
import 'UserInformation/benefits_and_promotions.dart';
import 'UserInformation/contact_us.dart';
import 'UserInformation/editPayment_webVIew.dart';

Color iconColor = const Color(0xFF1A1D36);

Future sideMenu(context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final menuWidth = (screenWidth * 0.28).clamp(320.0, 420.0);
  return SideSheet.right(
    context: context,
    width: menuWidth,
    body: PointerInterceptor(
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: Padding(
          //  padding: const EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 18.h,
                  ),
                  CommonFuncs().getBackButton(context),
                  //SizedBox(height: 10.h,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'האיזור האישי שלי',
                        style: TextStyle(
                            fontSize: 24.sp.clamp(20.0, 28.0),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Icon(
                        Icons.account_circle_outlined,
                        size: 48.sp.clamp(40.0, 56.0),
                        color: iconColor,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        User().firstName.isNotEmpty &&
                                User().lastName.isNotEmpty
                            ? '${User().firstName} ${User().lastName}'
                            : 'שם משתמש',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp.clamp(18.0, 24.0),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 34.h),
                  /* SizedBox(
                      height: 55.h,
                      child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: iconColor,
                                size: 26.sp,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                  child: Text(
                                'פרופיל אישי',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    color: blackColorApp,
                                    height: 1.5),
                              ))
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PersonalProfile(),
                              ));
                        },
                        // onPressed: openScreen(context,const PersonalProfile())
                      ),
                    ),*/
                  menuItem(
                    text: 'פרופיל אישי', assetPath: 'assets/icons/user.png',
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalProfile(),
                          ));
                    },
                    // onPressed: openScreen(context,const PersonalProfile())
                  ),
                  menuItem(
                      text: 'היסטורית הזמנות',
                      assetPath: 'assets/icons/car.png',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrdersHistory(
                                index:1,
                                goBack: true,
                              ),
                            ));
                      }),
                  menuItem(
                      text: 'הזמנות עתידיות',
                      assetPath: 'assets/icons/mingcute_car-line.png',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrdersHistory(
                                index: 2,
                                goBack: true,
                              ),
                            ));
                      }),

                  menuItem(
                      text: 'עידכון כ. אשראי',
                      assetPath: 'assets/icons/Creditcard.png',
                      onTap: () {
                        ApiService().getPaymentUrl(User().userId, (res) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPaymentWebView(
                                      url: res,
                                      fromProfile: false,
                                    )),
                          );
                        });
                      }),
                  /*SizedBox(
                    height: 55.h,
                    child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/Creditcard.png"),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                child: Text('עידכון כ. אשראי',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                        color: blackColorApp)),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          ApiService().getPaymentUrl(User().userId, (res) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPaymentWebView(
                                        url: res,
                                        fromProfile: false,
                                      )),
                            );
                          });
                        }),
                  ),*/
                  menuItem(
                      text: 'ביצוע הזמנה',
                      assetPath: 'assets/icons/car.png',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RentalWidget(),
                            ));
                      }),
                  /* SizedBox(
                    height: 55.h,
                    child: TextButton(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.drive_eta_outlined,
                              color: iconColor,
                              size: 26.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                                child: Text(
                              'ביצוע הזמנה',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: blackColorApp,
                                  height: 1.5),
                            ))
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RentalWidget(),
                            ));
                      },
                    ),
                  ),*/
                  menuItem(
                      text: 'תקנון',
                      assetPath: 'assets/icons/error.png',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Terms(
                                      index: 3,
                                    )));
                      }),
                  /* SizedBox(
                    height: 55.h,
                    child: TextButton(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_outlined,
                                color: iconColor, size: 26.sp),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                                child: Text(
                              'תקנון',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: blackColorApp,
                                  height: 1.5),
                            ))
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Terms(
                                      index: 3,
                                    )));
                      },
                    ),
                  ),*/
                  menuItem(
                      text: 'מחירון',
                      assetPath: 'assets/icons/wallet.png',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PriceList()));
                      }),
                  /*  SizedBox(
                    height: 55.h,
                    child: TextButton(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/wallet.png"),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                                child: Text(
                              'מחירון',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: blackColorApp,
                                  height: 1.5),
                            ))
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PriceList()));
                      },
                    ),
                  ),*/
                  menuItem(
                      text: 'הטבות ומבצעים',
                      assetPath: 'assets/icons/solar_sale-linear.png',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BenefitsAndPromotions()));
                      }),
                  /* SizedBox(
                    height: 55.h,
                    child: TextButton(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/solar_sale-linear.png"),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                                child: Text(
                              'הטבות ומבצעים',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: blackColorApp,
                                  height: 1.5),
                            ))
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BenefitsAndPromotions()));
                      },
                    ),
                  ),*/
                  menuItem(
                      text: 'צור קשר',
                      assetPath: 'assets/icons/phone_menu.png',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactUs(),
                          ),
                        );
                      }),
                  // SizedBox(
                  //   height: 55.h,
                  //   child: TextButton(
                  //     child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/icons/phone_menu.png"),
                  //           SizedBox(
                  //             width: 10.w,
                  //           ),
                  //           Flexible(
                  //               child: Text(
                  //             'צור קשר',
                  //             style: TextStyle(
                  //                 fontSize: 18.sp,
                  //                 fontWeight: FontWeight.normal,
                  //                 color: blackColorApp,
                  //                 height: 1.5),
                  //           ))
                  //         ],
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const ContactUs(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  menuItem(text: 'התנתק', assetPath: 'assets/icons/logout.png',
                  onTap:  () {
                    displayQuestion1(context,
                        header: 'להתנתק?',
                        message: 'האם ברצונך להתנתק מהאפליקציה?',
                        yesText: 'לצאת',
                        noText: 'הישאר', onYes: () {
                          MySharedPreferences().clearAllSharedPreference();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const TelToRegistrationForm()),
                                  (route) => false);
                        });
                  }),
                 /* SizedBox(
                    height: 55.h,
                    child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.logout, color: iconColor, size: 26.sp),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                  child: Text(
                                'התנתק',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    color: blackColorApp,
                                    height: 1.5),
                              ))
                            ],
                          ),
                        ),
                        onPressed: () {
                          displayQuestion1(context,
                              header: 'להתנתק?',
                              message: 'האם ברצונך להתנתק מהאפליקציה?',
                              yesText: 'לצאת',
                              noText: 'הישאר', onYes: () {
                            MySharedPreferences().clearAllSharedPreference();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TelToRegistrationForm()),
                                (route) => false);
                          });
                        }),
                  ),*/
                  //Spacer(),
                  getBottomButtons(context),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget menuItem({
  required String text,
  required String assetPath,
  VoidCallback? onTap,
}) {
  return SizedBox(
    height: 68.h.clamp(60.0, 78.0),
    child: TextButton(
      style: TextButton.styleFrom(
        foregroundColor: blackColorApp,
        padding: EdgeInsets.symmetric(horizontal: 10.w.clamp(10.0, 16.0)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 36.w.clamp(30.0, 40.0),
            height: 36.w.clamp(30.0, 40.0),
            child: Center(
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 14.w.clamp(10.0, 18.0)),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp.clamp(20.0, 26.0),
                fontWeight: FontWeight.normal,
                color: blackColorApp,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getBottomButtons(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Visibility(
        visible: !kIsWeb,
        child: GestureDetector(
          onTap: () {
            support.call;
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 14.w.clamp(12.0, 20.0),
              vertical: 14.h.clamp(12.0, 18.0),
            ),
            decoration: BoxDecoration(
              color: pinkColorApp,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'חיוג במקרה חירום',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.sp.clamp(17.0, 22.0),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                SizedBox(width: 10.w.clamp(8.0, 14.0)),
                Icon(
                  Icons.phone_outlined,
                  color: Colors.white,
                  size: 22.sp.clamp(18.0, 24.0),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
/*
getBottomButtons(context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Visibility(
        visible: !kIsWeb,
        child: GestureDetector(
          onTap: () {
            support.call;
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: pinkColorApp, borderRadius: BorderRadius.circular(100)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'חיוג במקרה חירום ',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.phone_outlined,
                  color: Colors.white,
                  size: 18.sp,
                )
              ],
            )),
          ),
        ),
      ),
    ],
  );
}*/
