import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/UserInformation/editContactInformation.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/landspace_widget.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../services/api_service.dart';
import 'editDrivingLicense.dart';
import 'editPayment_webVIew.dart';
import 'editProfile.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({Key? key}) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  Widget build(BuildContext context,) {
    return OrientationBuilder(
      builder: (context,o) {
        return Scaffold(
           body: o==Orientation.landscape?
               LandSpaceWidget(mainWidget: buildContent(), imageProperties: ImageProperties('l_register1.png', 618.w))
               :buildContent()
        );
      }
    );
  }

  buildContent()
  {
    String originalDateString =(User().licenseExpDate==null? User().licenseExpDate: "2024-12-03"); // התאריך המקורי בפורמט YYYY-MM-DD
    DateTime dateTime = DateTime.parse(originalDateString); // המרה לאובייקט DateTime

    String formattedDateString = DateFormat("MM/yy").format(dateTime);
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 31.w,left: 56.w ),
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Directionality(textDirection: ui.TextDirection.ltr, child: AppBarBibilease()),
          SizedBox(height: 24.h,),
          Padding(
            padding:  EdgeInsets.only(right: 23.w),
            child: Align(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
          ),

          SizedBox(height: 5.h,),
          Icon(
            Icons.account_circle_outlined,
            color: turquoiseColorApp,
            size: 55.sp,
            weight: 50,
          ),
          SizedBox(height: 8.h,),
          Center(child: Text('פרופיל אישי', style: TextStyle(color: Color(0xFF0F1511), fontSize: 24.sp, fontWeight: FontWeight.bold,),)),
          SizedBox(height: 40.h,),
          SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children:[
                      Icon(Icons.account_circle_outlined,color: pinkColorApp,size: 26.sp,),
                      Text('  פרטים אישיים',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                      Spacer(),
                      IconButton(onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditPersonalDetails()));},
                        icon:  Image.asset('assets/icons/edit_big.png') )
                    ]
                ),
                Text('${User().firstName} ${User().lastName}',style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                Text(User().tz,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
              ],
            ),
          ),
          SizedBox(height: 38.h,),
          SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children:[
                      Image.asset('assets/icons/Phone.png'),
                      Text('  פרטי התקשרות',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                      Spacer(),
                      IconButton(onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditContactInformationPersonal()));
                      },icon:  Image.asset('assets/icons/edit_big.png'))
                    ]
                ),
                Text(User().phoneNumber,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                Text(User().email,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
              ],
            ),
          ),
          SizedBox(height: 38.h,),
          SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children:[
                      Image.asset('assets/icons/driver_license.png'),
                      Text('  רשיון נהיגה',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                      Spacer(),
                      IconButton(onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditDrivingLicensePersonal()));
                      },icon:  Image.asset('assets/icons/edit_big.png'), )
                    ]
                ),
                Text(User().licenseId,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,),),
                Text(formattedDateString,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
              ],
            ),
          ),
          SizedBox(height: 38.h,),
          SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children:[
                      Image.asset('assets/icons/f7_creditcard.png'),
                      Text('  אמצעי תשלום',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,),),
                      Spacer(),
                      IconButton(onPressed: () async{
                        await ApiService().getPaymentUrl(User().userId, (res) {
                             //Navigator.pop(context);
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => EditPaymentWebView(
                                       url: res,
                                     )),
                                     );
                           });
                      },icon:  Image.asset('assets/icons/edit_big.png'), )
                    ]
                ),

                Text('${User().tranzilaCcno} **** **** ****',style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                //!kIsWeb?
                    Text('${User().tranzilaCardExpDate.substring(0,2)}/${User().tranzilaCardExpDate.substring(2)}', style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
                    //:Text('${User().tranzilaCardExpDate.substring(2)}/${User().tranzilaCardExpDate.substring(0,2)}', style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
              ],
            ),
          ),
          //SizedBox(height: 74.h,),
          Spacer(),
          SizedBox(
            width: 332.w,
            height: 44.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:turquoiseColorApp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/trash.png',color: Colors.white,),
                  SizedBox(width: 30.w,),
                  Text('מחיקת חשבון',style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    color: Colors.white,), ),

                ],
              ),
              onPressed: () {
                displayQuestionDelete(context,message: '?בטוח ברצונך למחוק חשבון זה',header: 'מחיקת חשבון',
                  onYes: () => {

                  },/*Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),))*/);
              },),
          ),
          SizedBox(height: 20.h,),
          /*  Container(
               width: 332.w,
               height: 42.h,
               child: FloatingActionButton.extended(
                   label: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       Text('מחיקת חשבון',style: TextStyle(
                           fontSize: 18.sp,
                           fontWeight: FontWeight.normal,
                           color: Colors.white,),
                         /*textAlign: TextAlign.start*/),

                       Image.asset('assets/icons/trash.png',color: Colors.white,)

                     ],
                   ),

                   elevation: 2,
                   backgroundColor: turquoiseColorApp,
                   onPressed: (){},
                   icon:  null,
               ),
             ),
       */
          //SizedBox(height: 40.h,),
        ],
      ),
    );
  }

  Future displayQuestionDelete(BuildContext context,{required String header,required String message, required Function() onYes}) {
    bool didYes = true;


    return showModalBottomSheet(
      context: context,

      builder: (BuildContext context) => StatefulBuilder(
        builder: (context,state) {
         if(!didYes) {
           Future.delayed(Duration(seconds: 2), () {
             if (Navigator.canPop(context)) {
               Navigator.pop(context);
             }
           });

         }
          return Container(
              height: 250.h,

              decoration: const BoxDecoration(color:Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow:  [
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

                Text("מחיקת חשבון",style: TextStyle(color: pinkColorApp,fontWeight: FontWeight.bold,fontSize: 28.sp)),
                // const Spacer(),
                Visibility(
                  visible: didYes,
                  child: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("בטוח ברצונך למחוק חשבון זה?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height:1,
                                fontSize: 20.sp,
                              )),
                          SizedBox(height: 36.h),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 42.h,
                                  width: 160.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: turquoiseColorApp,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
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
                                SizedBox(width: 13.h),
                                SizedBox(
                                  height: 42.h,
                                  width: 160.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: turquoiseColorApp,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                      onPressed: () {
                                        //showLoading(context);
                                        ApiService().deleteAccount(User().userId , (res) {
                                        //Navigator.pop(context);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => const PersonalProfile(),),
                                        // );
                                          print(didYes);
                                          state(() {
                                            didYes = false;
                                          });
                                          print(didYes);
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
                          SizedBox(height: 17.h,),
                          Image.asset('assets/icons/trash.png',color: pinkColorApp,),
                          SizedBox(height: 16.h,),
                          Text("החשבון נמחק בהצלחה!",
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

              ]));
        }
      ),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ).whenComplete(() =>  Future.delayed(Duration(seconds: 2), () {
      reloadMainPage(context);
    })
    );

  }
  Future reloadMainPage(BuildContext context,) {
    bool didYes = true;


    return showDialog(
      context: context,

      builder: (BuildContext context) => StatefulBuilder(
          builder: (context,state) {
            return Container(
                height: 178.h,
                width: 292.w,
                decoration: const BoxDecoration(color:Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  boxShadow:  [
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
                  Image.asset('assets/images/loading.png',width:24.w,color: Colors.white,),
                  SizedBox(height: 14.h),
                  Text('רק דקה :) \nטוען מסך ראשי...',style: TextStyle(color: pinkColorApp,fontWeight: FontWeight.bold,fontSize: 20.sp,),textDirection: ui.TextDirection.rtl,),
                  // const Spacer(),


                ]));
          }
      ),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ).whenComplete(() => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const RentalWidget())),
    );
  }

}
