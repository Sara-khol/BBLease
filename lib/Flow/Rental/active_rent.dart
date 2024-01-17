import 'package:bblease/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../models/class_rent.dart';
import '../../models/class_user.dart';


class ActiveRentDetails extends StatefulWidget {
  const ActiveRentDetails({Key? key}) : super(key: key);


  @override
  State<ActiveRentDetails> createState() => _ActiveRentDetailsState();
}

class _ActiveRentDetailsState extends State<ActiveRentDetails> {

  DateTime time = DateTime.now();
  late String _time;
  /*late int carNumber;
  late String park;*/
  late int percent;

  Rental rent=User().currentRent;

  @override
  void initState() {
    super.initState();
    _time = intl.DateFormat('kk:mm:ss').format(time);
    /*carNumber=rent.car.carNumber??10100101;
    park=rent.car.city;*/
    percent=75;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl ,
        child: Padding(
          padding: EdgeInsets.only(left: 30.w,right: 30.w),
          child: Column(
            children: [
              SizedBox(height: 120.h,),
              Text('פרטי הזמנה פעילה',style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600,color:const Color.fromRGBO(15, 21, 17, 1),)),
              SizedBox(height: 40.h,),
              Container(
                height: 42.h,
                width: 332.w,
                decoration: const BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Row(
                  children: [
                    SizedBox(width: 29.w,),
                    Icon(Icons.access_time,color: const Color(0xFFFB2576),size: 24.sp,),
                    Text('  זמן שנותר ',style: TextStyle(fontSize: 22.sp),),
                    const Spacer(),
                    Text('  $_time ',style: TextStyle(fontSize: 22.sp),),
                  ],
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                height: 42.h,
                width: 332.w,
                decoration: const BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Row(
                  children: [
                    SizedBox(width: 29.w,),
                    Icon(Icons.drive_eta_outlined,color: const Color(0xFFFB2576),size: 24.sp,),
                    Text('  מספר רכב: ',style: TextStyle(fontSize: 22.sp),),
                    const Spacer(),
                    Text('  ${rent.car.carNumber} ',style: TextStyle(fontSize: 22.sp),),
                  ],
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                height: 42.h,
                width: 332.w,
                decoration: const BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Row(
                  children: [
                    SizedBox(width: 29.w,),
                    Icon(Icons.fmd_good_outlined,color: const Color(0xFFFB2576),size: 24.sp,),
                    Text('  מיקום: ',style: TextStyle(fontSize: 22.sp),),
                    const Spacer(),
                    Text('   ${rent.car.city}  ',style: TextStyle(fontSize: 22.sp),),
                  ],
                ),
              ),
              SizedBox(height: 8.h,),
              SizedBox(
                width: 342.w,
                child: Stack(
                  children: [
                    Container(
                      height: 42.h,
                      width: 150.w,
                      decoration: const BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Row(
                        children: [
                          SizedBox(width: 29.w,),
                          Icon(Icons.local_gas_station_outlined,color: const Color(0xFFFB2576),size: 24.sp,),
                          SizedBox(width: 15.w,),
                        ],
                      ),
                    ),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.end,
                      isRTL: false,
                      animateFromLastPercent: true,
                      progressColor: const Color(0xFF00DEDE),
                      backgroundColor:  const Color(0xFFF7F7F7),
                      lineHeight: 42.h,
                      barRadius: const Radius.circular(8),
                      percent: percent/100,
                      width: 265.w,
                      center: Padding(
                        padding: EdgeInsets.only(right: 180.w),
                        child: Text('$percent%',style: TextStyle(fontSize: 22.sp)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 73.h,),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding:  const EdgeInsets.all(7.5),
                        child: Container(
                          height: 96.h,
                          width: 96.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFF7F7F7)
                          ),
                          child: InkWell(
                            child: SizedBox(
                              width: 60.w,
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h,),
                                  Icon(Icons.report_problem_outlined,size: 24.sp,),
                                  SizedBox(height: 7.h,),
                                  Text('דיווח\n על תקלה', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
                                ],
                              ),
                            ),
                            onTap: () { },
                          ),
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.all(7.5),
                        child: Container(
                          height: 96.h,
                          width: 96.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7)
                          ),
                          child: InkWell(
                            child: SizedBox(
                              width: 60.w,
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h,),
                                  Icon(Icons.drive_eta_outlined,size: 24.sp,),
                                  SizedBox(height: 8.h,),
                                  Text('איפה חניתי', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
                                ],
                              ),
                            ),
                            onTap: (){},
                          ),
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.all(7.5),
                        child: Container(
                          height: 96.h,
                          width: 96.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7)
                          ),
                          child: InkWell(
                            child: SizedBox(
                              width: 60.w,
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h,),
                                  Icon(Icons.phone_outlined,size: 24.sp,),
                                  SizedBox(height: 8.h,),
                                  Text('צור קשר', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
                                ],
                              ),
                            ),
                            onTap: (){},
                          ),
                        ),
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding:  const EdgeInsets.all(7.5),
                        child: Container(
                          height: 96.h,
                          width: 96.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7)
                          ),
                          child: Center(
                            child: InkWell(
                              child: SizedBox(
                                width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(height: 15.h,),
                                    Icon(Icons.person_outline,size: 24.sp,),
                                    SizedBox(height: 7.h,),
                                    Text('הוספת נהג חדש', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.all(7.5),
                        child: Container(
                          height: 96.h,
                          width: 96.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7)
                          ),
                          child: Center(
                            child: InkWell(
                              child: SizedBox(
                                width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(height: 15.h,),
                                    Icon(Icons.camera_alt_outlined,size: 24.sp,),
                                    SizedBox(height: 8.h,),
                                    Text('תיעוד רכב', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.all(7.5),
                        child: Container(
                          height: 96.h,
                          width: 96.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7)
                          ),
                          child: Center(
                            child: InkWell(
                              child: SizedBox(
                                width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(height: 15.h,),
                                    Icon(Icons.access_time,size: 24.sp,),
                                    SizedBox(height: 8.h,),
                                    Text('סיום השכרה', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                              onTap: (){
                                /*ApiService().returnCar(rent., (orderJson) =>
                                {

                                });*/
                              },
                            ),
                          ),
                        ),
                      ),
                    ]
                  )
                ],

              ),
              SizedBox(height: 35.h,),
              SizedBox(
                height: 48.h,
                width: 332.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 222, 222, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: (){
                    },
                    child: Text('פתיחת דלתות',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
              ),
              SizedBox(height: 12.h,),
              SizedBox(
                height: 48.h,
                width: 332.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFB2576),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: (){
                    },
                    child: Text('נעילת דלתות',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
