
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../customWidgets/appBarB.dart';
import '../models/car.dart';
import '../services/api_service.dart';

class CarDetails extends StatefulWidget{
  final int carId;

  CarDetails(this.carId);

  @override
  State<StatefulWidget> createState() =>_CarDetailsState();

}

class _CarDetailsState extends State<CarDetails>{
  late Car carDetails;
  @override
  void initState() {
   // ApiService().getCarById(widget.carId,(car){
    //   carDetails =Car.fromJson(car);
    //   setState(() {
    //   });
    // });
    super.initState();
  }

 Future<Car?> getCar() async
  {
 await ApiService().getCarById(widget.carId,(car){
      carDetails =Car.fromJson(car);
     return carDetails;
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: /*FutureBuilder(
            future: getCar(),
            builder: (context,s) {
              if(s.hasData) {

                return*/ Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 32.h),
                    Directionality(textDirection: TextDirection.ltr,
                        child: AppBarBibilease()),
                    SizedBox(height: 50.h),
                    Text(
                       'יונדאי i20',//carDetails.postName,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF0F1511),
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        height: null,
                      ),
                    ),
                    Text(
                      'רכב זה זמין רק בחיבור לאפליקציה',
                      style: TextStyle(
                        color: Color(0xFF0F1511),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: null,
                      ),
                    ),
                    SizedBox(height: 39.h),
                    Image.asset('assets/images/car-only.png', width: 290.w,
                      height: 126.h,
                      fit: BoxFit.cover,),
                    SizedBox(height: 67.h),
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding:  EdgeInsets.only(right:10.w),
                          child: RawScrollbar(
                            //thumbColor: Color(0xFF00DEDE),
                            thumbVisibility: true,
                            thumbColor: Color(0xFF00DEDE),

                            //trackVisibility: true,
                            thickness: 3,
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListView(
                                  padding: EdgeInsets.only(left:17.w,right: 11.w,),
                                  shrinkWrap: true,
                                  children:[
                                  Stack(children: [
                                    Container(
                                      width: 355.w,
                                      height: 213.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 30.w, left: 30.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 41.h),
                                            Text(
                                              'יונדאי i20',//carDetails.postName
                                              style: TextStyle(
                                                color: Color(0xFF0F1511),
                                                fontSize: 32.sp,
                                                fontWeight: FontWeight.w700,
                                                height: 1.15,
                                              ),
                                            ),
                                            Text(
                                              'או רכב זהה',
                                              style: TextStyle(
                                                color: Color(0xFF0F1511),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                height: 1.15,
                                              ),
                                            ),
                                            Text(
                                              'ללא הגבלת ק”מ',
                                              style: TextStyle(
                                                color: Color(0xFF0F1511),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                height: 1.15,
                                              ),
                                            ),
                                            SizedBox(height: 25.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(children: [
                                                  ImageIcon(
                                                    AssetImage("assets/images/Seat.png",),
                                                    color: Color(0xffFB2576),),
                                                  SizedBox(height: 10.h),
                                                  Text(
                                                    '5 מושבים',
                                                    style: TextStyle(
                                                      color: Color(0xFF0F1511),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      //height: 0.08,
                                                    ),
                                                  )
                                                ],),
                                                Column(children: [
                                                  ImageIcon(
                                                    AssetImage("assets/images/Door.png",),
                                                    color: Color(0xffFB2576),),
                                                  SizedBox(height: 10.h),
                                                  Text(
                                                    '4 דלתות',
                                                    style: TextStyle(
                                                      color: Color(0xFF0F1511),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      //height: 0.08,
                                                    ),
                                                  )
                                                ],),
                                                Column(children: [
                                                  ImageIcon(
                                                    AssetImage("assets/images/Smile.png",),
                                                    color: Color(0xffFB2576),),
                                                  SizedBox(height: 10.h),
                                                  Text(
                                                    'כסא בטיחות',
                                                    style: TextStyle(
                                                      color: Color(0xFF0F1511),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      //height: 0.08,
                                                    ),
                                                  )
                                                ],),
                                                Column(children: [
                                                  ImageIcon(
                                                    AssetImage("assets/images/WazeIcon.png",),
                                                    color: Color(0xffFB2576),),
                                                  SizedBox(height: 10.h),
                                                  Text(
                                                    'Waze',
                                                    style: TextStyle(
                                                      color: Color(0xFF0F1511),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      //height: 0.08,
                                                    ),
                                                  )
                                                ],),
                                              ],),

                                          ],),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 120.w,
                                        height: 34.h,
                                        padding:  EdgeInsets.symmetric(horizontal: 20.w,
                                            vertical: 6.h),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          shadows: [
                                            BoxShadow(
                                              color: Color(0x33A7A7A7),
                                              blurRadius: 40,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'פרטי הרכב',
                                              style: TextStyle(
                                                color: Color(0xFF0F1511),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Stack(children: [
                                    Container(
                                      width: 355.w,
                                      height: 238.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 30.w, left: 30.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 41.h),
                                            Row(children: [
                                              ImageIcon(AssetImage("assets/images/Location.png"),color:Color(0xFF0F1511),size: 20.w),
                                              SizedBox(width: 9.w,),
                                              Text(
                                                'ירמיהו, ירושלים',
                                                style: TextStyle(
                                                  color: Color(0xFF0F1511),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                 // height: 1.15,
                                                ),
                                              ),
                                              Spacer(),
                                              //replace to ICONBUTTON
                                              ImageIcon(AssetImage("assets/images/edit.png"),color:Color(
                                                  0xFF00DEDE),),
                                            ],),
                                            SizedBox(height: 20.h),
                                            Row(children: [
                                              ImageIcon(AssetImage("assets/images/Calendar.png"),color:Color(0xFF0F1511),size: 20.w,),
                                              SizedBox(width: 9.w,),
                                              Text(
                                                '25.06.2023-28.06.2023',
                                                style: TextStyle(
                                                  color: Color(0xFF0F1511),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  // height: 1.15,
                                                ),
                                              ),
                                              Spacer(),
                                              //replace to ICONBUTTON
                                              ImageIcon(AssetImage("assets/images/edit.png"),color:Color(
                                                  0xFF00DEDE),),
                                              IconButton(
                                                iconSize: 20.w,
                                                icon:  ImageIcon(AssetImage("assets/images/edit.png"),color:Color(
                                                    0xFF00DEDE),),
                                                onPressed: ()=> {  Navigator.pop(context),},
                                              ),
                                            ],),

                                            SizedBox(height: 18.h,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              Text(
                                                'כולל',
                                                style: TextStyle(
                                                  color: Color(0xFF0F1511),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.15,
                                                ),
                                              ),
                                              Row(children: [
                                                ImageIcon(AssetImage("assets/images/Vector6.png"),color:Color(0xFF00DEDE),),
                                                SizedBox(width: 9.w,),
                                                Text(
                                                  'ביטוח',
                                                  style: TextStyle(
                                                    color: Color(0xFF0F1511),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    // height: 1.15,
                                                  ),
                                                ),
                                              ],),
                                              Row(children: [
                                                ImageIcon(AssetImage("assets/images/Vector6.png"),color:Color(0xFF00DEDE),),
                                                SizedBox(width: 9.w,),
                                                Text(
                                                  'ללא הגבלת קילומטרים',
                                                  style: TextStyle(
                                                    color: Color(0xFF0F1511),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    // height: 1.15,
                                                  ),
                                                ),
                                              ],),
                                              Row(children: [
                                                ImageIcon(AssetImage("assets/images/Vector6.png"),color:Color(0xFF00DEDE),),
                                                SizedBox(width: 9.w,),
                                                Text(
                                                  'השתתפות עצמית בנזקים',
                                                  style: TextStyle(
                                                    color: Color(0xFF0F1511),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    // height: 1.15,
                                                  ),
                                                ),
                                              ],),
                                            ],),
                                          ],),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 133.w,
                                        height: 34.h,
                                        padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          shadows: [
                                            BoxShadow(
                                              color: Color(0x33A7A7A7),
                                              blurRadius: 40,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'פרטי השכרה',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF0F1511),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                    ),
                                  ],
                                  ),
                                  ], ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],

                ),/*;
                /*child: Container(
width: 47,
height: 383,
decoration: BoxDecoration(
gradient: LinearGradient(
begin: Alignment(-1.00, -0.00),
end: Alignment(1, 0),
colors: [Colors.white, Colors.white.withOpacity(0)],
),
),
),*/
              }
              return const Center(child: CircularProgressIndicator());
            }
          ),*/
        ),
      );
  }

}