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
import 'UserInformation/benefits_and_promotions.dart';
import 'UserInformation/contact_us.dart';

Future sideMenu(context) {
  return SideSheet.right(
      body: PointerInterceptor(
        child: MouseRegion(
          cursor: SystemMouseCursors.basic,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 18.h,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios))),
                    //SizedBox(height: 10.h,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'האיזור האישי שלי',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          size: 38.sp,
                          color: blackColorApp,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        User().firstName.isNotEmpty && User().lastName.isNotEmpty
                            ? Text(
                                '${User().firstName} ${User().lastName}',
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.bold),
                              )
                            : Text('שם משתמש',
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 34.h),
                    SizedBox(
                      height: 55.h,
                      child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: blackColorApp,
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
                    ),
                    SizedBox(
                      height: 55.h,
                      child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/car.png"),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                  child: Text(
                                'היסטורית הזמנות',
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
                                builder: (context) => const OrdersHistory(
                                  index: 1,
                                  goBack: true,
                                ),
                              ));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 55.h,
                      child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset('assets/images/mingcute_car-line.png',width: 24.w,),

                              Image.asset("assets/icons/mingcute_car-line.png"),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                  child: Text(
                                'הזמנות עתידיות',
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
                                builder: (context) => const OrdersHistory(
                                  index: 2,
                                  goBack: true,
                                ),
                              ));
                        },
                      ),
                    ),
                    SizedBox(
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
                                    builder: (context) => PaymentWebView(
                                          url: res,
                                          index: 2,
                                        )),
                              );
                            });
                          }),
                    ),
                    SizedBox(
                      height: 55.h,
                      child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.drive_eta_outlined,
                                color: blackColorApp,
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
                    ),
                    SizedBox(
                      height: 55.h,
                      child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline_outlined,
                                color: blackColorApp,
                              ),
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
                                        index: 1,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const PriceList()));
                        },
                      ),
                    ),
                    SizedBox(
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
                                  builder: (context) => const BenefitsAndPromotions()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 55.h,
                      child: TextButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/phone_menu.png"),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                  child: Text(
                                'צור קשר',
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
                              builder: (context) => const ContactUs(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 55.h,
                      child: TextButton(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: blackColorApp,
                                ),
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
                                      builder: (context) => const TelToRegistrationForm()),
                                  (route) => false);
                            });
                          }),
                    ),
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
      context: context,
      width: 250.w);
}

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
}
