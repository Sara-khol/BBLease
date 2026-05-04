import 'dart:async';

import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/UserInformation/editContactInformation.dart';
import 'package:bblease/landspace_widget.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/common_funcs.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../services/api_service.dart';
import '../my_shared_preferences.dart';
import '../registration/tel_to_registration.dart';
import 'editDrivingLicense.dart';
import 'editPayment_webVIew.dart';
import 'editProfile.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  late Orientation realOrientation;

  @override
  Widget build(
    BuildContext context,
  ) {
    realOrientation = View.of(context).physicalSize.width >
            View.of(context).physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    return Scaffold(
        body: LandSpaceWidget(
            mainWidget: buildContent(realOrientation),
            imageProperties:
                ImageProperties('image6.png', 1000.w, 'תמונת מידע אישי')));
  }

  buildContent(Orientation o) {
    String originalDateString = (User().licenseExpDate == null
        ? User().licenseExpDate
        : "2024-12-03"); // התאריך המקורי בפורמט YYYY-MM-DD
    DateTime dateTime =
        DateTime.parse(originalDateString); // המרה לאובייקט DateTime

    Widget editIcon= Transform.scale(
      scale:1.2,
      child: Image.asset('assets/icons/edit_big.png',
        width: 22.sp.clamp(20.0, 26.0),
        height: 22.sp.clamp(20.0, 26.0),),
    );

    String formattedDateString = DateFormat("MM/yy").format(dateTime);
    return SingleChildScrollView(
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(right: 31.w, left: 56.w),
          child: Column(
            //shrinkWrap: true,
            //
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Directionality(textDirection: ui.TextDirection.ltr, child: AppBarBibilease()),
              if (o == Orientation.portrait)
                SizedBox(
                  height: 15.h,
                ),
               CommonFuncs().getBackButton(context),
              SizedBox(
                height: 5.h,
              ),
              Icon(
                Icons.account_circle_outlined,
                color: turquoiseColorApp,
                size: 45.sp,
                weight: 40,
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                  child: Text(
                'פרופיל אישי',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              )),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: pinkColorApp,
                        size: 26.sp,
                      ),
                      Text('  פרטים אישיים',
                          style: TextStyle(
                            color: pinkColorApp,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditPersonalDetails()));
                          },
                          icon: editIcon)
                    ]),
                    Text('${User().firstName} ${User().lastName}',
                        style: TextStyle(
                          color: blackColorApp,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                        )),
                    Text(User().tz,
                        style: TextStyle(
                          color: blackColorApp,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Transform.scale(
                        scale:1.3,
                        child: Image.asset(
                          'assets/icons/Phone.png',
                          width: 26.sp.clamp(24.0, 30.0),
                          height: 26.sp.clamp(24.0, 30.0),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text('  פרטי התקשרות',
                          style: TextStyle(
                            color: pinkColorApp,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditContactInformationPersonal()));
                          },
                          icon: editIcon)
                    ]),
                    Text(User().phoneNumber,
                        style: TextStyle(
                          color: blackColorApp,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                        )),
                    Text(User().email,
                        style: TextStyle(
                          color: blackColorApp,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Transform.scale(
                        scale:1.3,
                        child: Image.asset(
                          'assets/icons/driver_license.png',
                          width: 22.sp.clamp(20.0, 26.0),
                          height: 22.sp.clamp(20.0, 26.0),
                        ),
                      ),
                      Text('  רשיון נהיגה',
                          style: TextStyle(
                            color: pinkColorApp,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          )),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditDrivingLicensePersonal()));
                        },
                        icon: editIcon)
                    ]),
                    Text(
                      User().licenseId,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(formattedDateString,
                        style: TextStyle(
                          color: blackColorApp,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Transform.scale(
                        scale:1.3,
                        child: Image.asset(
                          'assets/icons/f7_creditcard.png',
                          width: 22.sp.clamp(20.0, 26.0),
                          height: 22.sp.clamp(20.0, 26.0),
                        ),
                      ),
                      Text(
                        '  אמצעי תשלום',
                        style: TextStyle(
                          color: pinkColorApp,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await ApiService().getPaymentUrl(User().userId,
                              (res) {
                            //Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPaymentWebView(
                                        url: res,
                                      )),
                            );
                          });
                        },
                        icon: editIcon,
                      )
                    ]),

                    if (User().tranzilaCcno != '')
                      Text('${User().tranzilaCcno} **** **** ****',
                          style: TextStyle(
                            color: blackColorApp,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          )),
                    //!kIsWeb?
                    if (User().tranzilaCardExpDate != '')
                      Text(
                          '${User().tranzilaCardExpDate.substring(0, 2)}/${User().tranzilaCardExpDate.substring(2)}',
                          style: TextStyle(
                            color: blackColorApp,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          )),
                    //:Text('${User().tranzilaCardExpDate.substring(2)}/${User().tranzilaCardExpDate.substring(0,2)}', style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              //Spacer(),
              SizedBox(
                width: 332.w,
                height: 44.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 26.sp.clamp(22.0, 28.0),
                        height: 26.sp.clamp(22.0, 28.0),
                        child: Image.asset(
                          'assets/icons/trash.png',
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        'מחיקת חשבון',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    displayQuestionDelete(
                      context,
                      '?בטוח ברצונך למחוק חשבון זה',
                      'מחיקת חשבון',
                      /*Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),))*/
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future displayQuestionDelete(
      BuildContext context, String message, String header) {
    bool didYes = true;

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (sheetContext, state) {
        // if (!didYes) {
        //   Future.delayed(const Duration(seconds: 4), () {
        //     if (Navigator.canPop(context)) {
        //       Navigator.pop(context);
        //     }
        //   });
        // }
        return SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          minimum: EdgeInsets.only(bottom: 20.h),
          child: Container(
              height: 250.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 250,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(children: [
                SizedBox(height: 35.h),
                Text("מחיקת חשבון",
                    style: TextStyle(
                        color: pinkColorApp,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp)),
                Visibility(
                  visible: didYes,
                  child: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("?בטוח ברצונך למחוק חשבון זה",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1,
                                fontSize: 20.sp,
                              )),
                          SizedBox(height: 36.h),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 42.h,
                                    // width: 160.w,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: turquoiseColorApp,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'ביטול',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ),
                                ),
                                SizedBox(width: 13.h),
                                Expanded(
                                  child: SizedBox(
                                    height: 42.h,
                                    //  width: 160.w,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: turquoiseColorApp,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        onPressed: () {
                                          //showLoading(context);
                                          ApiService().deleteAccount(
                                              User().userId, (res) {
                                            //Navigator.pop(context);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => const PersonalProfile(),),
                                            // );
                                            state(() {
                                              didYes = false;
                                            });
                                            Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((val) {
                                              MySharedPreferences()
                                                  .clearAllSharedPreference();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TelToRegistrationForm()),
                                                  (route) => false);
                                            });
                                          });
                                        },
                                        child: Text(
                                          'אישור',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ),
                                ),
                              ]),
                          SizedBox(height: 22.h),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !didYes,
                  child: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          SizedBox(
                            width: 26.sp.clamp(22.0, 28.0),
                            height: 26.sp.clamp(22.0, 28.0),
                            child: Image.asset(
                              'assets/icons/trash.png',
                              color: pinkColorApp,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "החשבון נמחק בהצלחה!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //height:1,
                              fontSize: 20.sp,
                            ),
                            textDirection: ui.TextDirection.rtl,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        );
      }),
      barrierColor: Colors.black12.withOpacity(0.1),
    );
  }

  Future reloadMainPage(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, state) {
        return Container(
            height: 178.h,
            width: 292.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 250,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(children: [
              SizedBox(height: 38.h),
              Image.asset(
                'assets/images/loading.png',
                color: Colors.white,
                semanticLabel: 'טעינה',
              ),
              SizedBox(height: 14.h),
              Text(
                'רק דקה :) \nטוען מסך ראשי...',
                style: TextStyle(
                  color: pinkColorApp,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
                textDirection: ui.TextDirection.rtl,
              ),
            ]));
      }),
      barrierColor: Colors.black12.withOpacity(0.1),
    ).whenComplete(
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RentalWidget())),
    );
  }
}
