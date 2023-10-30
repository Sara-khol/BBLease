 import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:intl/intl.dart' as intel;
import 'package:bblease/customWidgets/appBarB.dart';


import '../services/api_service.dart';

class SearchCar extends StatefulWidget {
  const SearchCar({super.key});

  @override
  State<SearchCar> createState() => _SearchCarState();
}

class _SearchCarState extends State<SearchCar> {
  List<Car> cars=[];


@override
  void initState() {
  ApiService().getAllCars((car){
    cars = car.map<Car>((entry) => (Car.fromJson(entry))).toList();
    setState(() {
    });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

  return Scaffold(

    body: Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          SizedBox(height:32.h),
          Directionality(textDirection: TextDirection.ltr,child: AppBarBibilease()),
        SizedBox(height:60.h),
        Text('הי, מצאנו באזורך ${cars.length} רכבים',
          style: TextStyle(
            color: Color(0xFF0F1511),
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),),
        Text('ירמיהו, ירושלים ${intel.DateFormat('dd.MM.yy').format(DateTime.now())} ',
          style: TextStyle(
            color: const Color(0xFF0F1511),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),),
        SizedBox(height: 28.h),
        topButtons(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: cars.length,
          itemBuilder: (context, index) {
            Car car= cars[index];
             return Container(

              margin:  EdgeInsets.only(right: 23.w,left: 23.w,bottom: 12.h,),
               child: Stack(
                 children: [
                   Card(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                     //elevation: 0,
                     shadowColor: Colors.transparent,
                     margin: EdgeInsets.only(left:20.w),
                     color: Color(0xffF7F7F7),
                     child:Padding(
                      padding: EdgeInsets.only(right: 18.w,left: 11.w,bottom: 10.h,top: 10.h),
                      child: IntrinsicHeight(
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(car.postName.length > 12 ? '${car.postName.substring(0, 12)}...' : '${car.postName}',style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700,),),
                                //SizedBox(height: 4.h),
                                Text('או רכב זהה',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,),),
                                //SizedBox(height: 3.h),
                                Text('נמצא במרחק 0.5ק"מ',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,),),
                                SizedBox(height: 29.h),
                                Text('214.90 ₪  |  ליום',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,),),
                                //SizedBox(height: 6.h),
                                Text('640 ₪  |  סה"כ',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,),),
                              ],
                            ),
                            Expanded(child: Align( alignment: Alignment.topLeft,
                                child: Icon(Icons.circle,color: Color(0xFF04AEB9),size: 8.w,)))
                              ],),
                      ),
                    ),

                    ),
                  IntrinsicHeight(
                     child: Align(
                      alignment: Alignment.bottomLeft,
                       child: Container(
                           //margin: EdgeInsets.only(bottom:10.h),
                           child: Image.asset('assets/images/car-only.png'/*,width: 175.w,height: 76.h, */)),
                     )
                   ),
                  ],
               ),

             );
        },
      )],),

    ),
  );

  }

  topButtons()
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 23.h,),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SizedBox(width:48.w,)),
          TextButton(
            onPressed: () => {print('1'),},
              child: Row(children: [
                Text(
                'סנן',
                style: TextStyle(
                  color: Color(0xFF0F1511),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),

              ),
              ImageIcon(AssetImage("assets/images/Filter.png"),color: Color(0xffFB2576),size: 20.w,),
             ], ),),
          //Spacer(),
          //SizedBox(width:33.w,),
          TextButton(  onPressed: () => {print('2'),},
            child: Row(children: [
              Text(
                ' שנה תאריך ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ImageIcon(AssetImage("assets/images/Calendar.png"),color: Color(0xffFB2576),size: 20.w,),
            ],
            ),),
          //Spacer(),
         // SizedBox(width:30.w,),
          TextButton(  onPressed: () => {print('3'),},
            child: Row(children: [
              Text(
                ' הגדל טווח חיפוש ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ImageIcon(AssetImage("assets/images/expansion.png"),color: Color(0xffFB2576),size: 20.w,),
            ],
            ),),
          Expanded(child: SizedBox(width:48.w,)),
      ],),
    );
  }
/*  uploadSucceed(BuildContext context, /*Widget prevPage,Widget nextPage*/){
    print('uploadSucceed');
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context)=>
            Container(
              height: 230.h,
              child: Column(
                children: [
                  SizedBox(height: 45.h,),
                  Text('התצלום עלה בהצלחה', style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w600,color: Color(0xFFFB2576)),),
                  SizedBox(height: 70.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 160.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color(0xFF00DEDE),
                        ),
                        child: TextButton(
                          child: Text('סרוק פעם נוספת',style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),),
                          onPressed: () {
                            //Navigator.push(
                           //     context,
                            //    MaterialPageRoute(builder: (context) => prevPage));
                          },
                        ),
                      ),
                      SizedBox(width: 13.w,),
                      Container(
                        width: 160.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color(0xFF00DEDE),
                        ),
                        child: TextButton(
                          child: Text('אישור',style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),),
                          onPressed: () {
                          //  Navigator.push(
                             //   context,
                             //   MaterialPageRoute(builder: (context) => nextPage));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22.h,),
                ],
              ),
            ),
        barrierColor: Colors.black12.withOpacity(0.1),
        isDismissible: false,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)

    );
  }*/
}