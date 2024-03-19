import 'dart:math';

import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/Actions/add_driver.dart';
import 'package:bblease/Flow/Rental/Actions/car_docu.dart';
import 'package:bblease/Flow/Rental/Actions/report_accident.dart';
import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import '../../models/class_rent.dart';
import '../../models/class_user.dart';
import 'car_dialog.dart';

class ActiveRentDetails extends StatefulWidget {
  const ActiveRentDetails({Key? key}) : super(key: key);

  @override
  State<ActiveRentDetails> createState() => _ActiveRentDetailsState();
}

class _ActiveRentDetailsState extends State<ActiveRentDetails> {

  late String _time = '00:00:00';
  Rental rent = User().currentRent!;
  //final ScrollController _controller = ScrollController();

  bool isLocked=true;

  int percent= -1;
  int km= -1;


  getTime(){
    ApiService().getTimeRemain(rent.orderNum!, (res) => setState(()=>_time=res));
  }

  getFuel(){
    ApiService().getFuelLevel(rent.car.carNumber, (res) {
      if(res!=-1){
      percent=res['fuel_percentage'];
      km=res['fuel_per_km'];
      setState(() { });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getTime();
    getFuel();
  }
   sendOpeningCode(){
    ApiService().getOpeningCode(rent.orderNum!, (res) {
      print(res);
      openingCodeDialog(context, res);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const Directionality(
                textDirection: TextDirection.ltr, child: AppBarBibilease()),
            Column(
              children: [
                SizedBox(height: 30.h,),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Text('פרטי הזמנה פעילה',
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(15, 21, 17, 1),
                          height: 1)),
                ),
                SizedBox(height: 40.h,),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Container(
                    height: 42.h,
                    width: 332.w,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        SizedBox(width: 29.w,),
                        ImageIcon(AssetImage("assets/icons/car_icon.png"), size: 24.w, color: pinkColorApp,),
                        Text('  מספר רכב: ', style: TextStyle(fontSize: 18.sp),),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 17),
                          child: Text('  ${rent.car.carNumber} ', style: TextStyle(fontSize: 18.sp),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h,),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Container(
                    height: 42.h,
                    width: 332.w,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        SizedBox(width: 29.w,),
                        Icon(Icons.fmd_good_outlined, color: pinkColorApp, size: 24.sp,),
                        Text('  מיקום: ', style: TextStyle(fontSize: 18.sp,),),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text('   ${rent.car.address}  ', style: TextStyle(fontSize: 18.sp),),),
                      ],
                    ),
                  ),
                ),
                /*  SizedBox(height: 8.h,),*/
                /* SizedBox(
                  width: 332.w,
                  child: Stack(
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
                                      Text('דיווח\n על תקלה', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),
                                        textAlign: TextAlign.center,

                                      )
                                    ],
                                  ),
                                ),
                                onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => ReportAccident(),)),
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
                                      Text('איפה חניתי', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
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
                                      Text('צור קשר', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
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
                                        Text('הוספת נהג חדש', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
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
                                        Text('תיעוד רכב', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                      ],
                                    ),
                                  ),
                                  onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => CarDocu(),)),
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
                                        Text('סיום השכרה', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    showLoading(context);
                                    ApiService().returnCar(rent.orderNum!,
                                            (orderJson)  {
                                          Navigator.pop(context);
                                          displayMessage(context,message:'סיום ההשכרה נקלט בהצלחה',onClose: (){});
                                          print('return car');
                                        });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]
                      )
                    ],
                  ),
                ),*/
                SizedBox(height: 53.h,),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Text(
                    'סיום ההשכרה בעוד',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(15, 21, 17, 1),
                        height: 1),
                  ),
                ),
                SizedBox(height: 22.h,),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Text(_time,
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(15, 21, 17, 1),
                         )),
                ),
                SizedBox(height: 24.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(intl.DateFormat('HH:mm:ss').format(rent.endDate),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(15, 21, 17, 1),
                            )),
                    Text(' | ',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(15, 21, 17, 1),
                            )),
                    Text(intl.DateFormat('dd/MM/yyyy').format(rent.endDate),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(15, 21, 17, 1),
                            height: 1)),
                  ],
                ),
                SizedBox(height: 33.h,),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Row(
                    children: [
                      Container(
                        height: 42.h,
                        width: 162.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: turquoiseColorApp,
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.only(
                                  right: 9.w,
                                  left: 13.w,
                                  top: 8.h,
                                  bottom: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              /*ApiService().openDoors(rent.car.carNumber, (res) {
                              print(res);
                              openingCodeDialog(context, res);
                            });
                            //sendOpeningCode();*/
                            },
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'הארכת השכרה  ',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Image.asset('assets/icons/timePlus.png',
                                    width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.fitHeight),
                              ],
                            )),
                      ),
                      SizedBox(width: 8.w,),
                      SizedBox(
                        height: 42.h,
                        width: 162.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: pinkColorApp,
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.only(
                                  right: 9.w,
                                  left: 13.w,
                                  top: 8.h,
                                  bottom: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              showLoading(context);
                              ApiService().returnCar(rent.orderNum!,
                                  (orderJson) {
                                Navigator.pop(context);
                                displayMessage(context,
                                    message: 'סיום ההשכרה נקלט בהצלחה',
                                    onClose: () {});
                                print('return car');
                              });
                            },
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'סיום השכרה  ',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.stop_circle_outlined,
                                  color: Colors.white,
                                  size: 24.sp,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 33.h,),
                Container(
                  height: 95.h,
                  // width: 393.w,
                  margin: EdgeInsets.zero,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    //controller: _controller,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          height: 95.h,
                          width: 100.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 40,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: InkWell(
                            child: SizedBox(
                              width: 60.w,
                              child: Column(
                                children: [
                                  SizedBox(height: 20.h,),
                                  ImageIcon(
                                    AssetImage("assets/icons/Broken.png"),
                                    size: 24.w,
                                    color: const Color(0xFF0F1511),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    'דיווח\n על תקלה',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => reportAccident(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          height: 95.h,
                          width: 100.w,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 40,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: InkWell(
                            child: SizedBox(
                              //  width: 60.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/car_icon.png"),
                                    size: 24.w,
                                    color: const Color(0xFF0F1511),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    'איפה חניתי',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          height: 95.h,
                          width: 100.w,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 40,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: InkWell(
                              child: SizedBox(
                                //  width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h,),
                                    Icon(Icons.account_circle_outlined, size: 24.sp,),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      'הוספת\nנהג נוסף',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => displayQuestion1(context,message2: 'ודא כי יש ברשותך את פרטי הרשיון\nשל הנהג הנוסף',message1: 'ברצונך להוסיף נהג חדש?',
                                  onYes: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddDriver(),))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          height: 95.h,
                          width: 100.w,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 40,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: InkWell(
                              child: SizedBox(
                                // width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h,),
                                    Icon(Icons.camera_alt_outlined, size: 24.sp,),
                                    SizedBox(height: 10.h,),
                                    Text('תיעוד רכב',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => displayQuestion1(context,message1: 'צעד חכם!',message2: 'ודא שהתמונות מצולמות באיכות טובה',
                                  onYes: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CarDocu(),))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Container(
                          height: 95.h,
                          width: 100.w,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 40,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: InkWell(
                              child: SizedBox(
                                //width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h,),
                                    Image.asset('assets/icons/Frame.png', width: 24.w, height: 24.h, fit: BoxFit.fitHeight),
                                    SizedBox(height: 10.h,),
                                    Text('שלח קוד\nלפתיחת דלת',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              onTap: ()=>sendOpeningCode(),
                            ),
                          ),
                        ),
                      ),
                      /* Padding(
                                 padding:  const EdgeInsets.all(7.5),
                                 child: Container(
                                   height: 96.h,
                                   width: 96.w,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(8),
                                     color: const Color(0xFFFFF),
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
                                             Text('סיום השכרה', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                           ],
                                         ),
                                       ),
                                       onTap: (){
                                         showLoading(context);
                                         ApiService().returnCar(rent.orderNum!,
                                                 (orderJson)  {
                                               Navigator.pop(context);
                                               displayMessage(context,message:'סיום ההשכרה נקלט בהצלחה',onClose: (){});
                                               print('return car');
                                             });
                                       },
                                     ),
                                   ),
                                 ),
                              ),*/
                    ],
                  ),
                ),
                SizedBox(height: 28.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170.w,
                      height: 114.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 12.h,),
                          Visibility(
                            visible: percent!=-1,
                            child: Text(
                              '$percent%',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/KM.png',
                                  width: 30.w,
                                  height: 15.h,
                                  fit: BoxFit.fitHeight),
                              SizedBox(width: 19.w),
                              Text(
                                '|',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1),
                              ),
                              SizedBox(width: 19.w),
                              Image.asset('assets/icons/Gas.png',
                                  width: 30.w,
                                  height: 30.h,
                                  fit: BoxFit.fitHeight),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Visibility(
                            visible: km!=-1,
                            child: Text(
                              '$km ק"מ',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Container(
                      width: 108.w,
                      height: 114.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadows: [
                          BoxShadow(
                            color: Color(0x0C000000),
                            blurRadius: 40,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: GestureDetector(
                        onVerticalDragEnd: (details) {
                          ApiService().openDoors(rent.car.carNumber, (res) {
                                print(res);
                               setState(() {
                                 isLocked=false;
                               });
                              });
                          ApiService().lockDoors(rent.car.carNumber,
                                  (res) {
                                print(res);
                                setState(() {
                                  isLocked=true;
                                });
                              });

                        },
                        child: Column(
                          children: [
                            SizedBox(height: 11.h),
                            ImageIcon(
                              isLocked?AssetImage("assets/icons/unlock.png"):AssetImage("assets/icons/lock.png"),
                              size: 24.w,
                              color: isLocked?turquoiseColorApp:pinkColorApp,
                            ),
                            SizedBox(height: 7.h),
                            Image.asset('assets/icons/Frame-30.png',
                                width: 25.67.w,
                                height: 33.42.h,
                                fit: BoxFit.fitHeight),
                            SizedBox(height: 4.58.h),
                            ImageIcon(
                              isLocked?AssetImage("assets/icons/lock.png"):AssetImage("assets/icons/unlock.png"),
                              size: 24.w,
                              color: isLocked?pinkColorApp:turquoiseColorApp,
                            ),
                            //SizedBox(height:10.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
