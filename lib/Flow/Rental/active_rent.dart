import 'dart:async';
import 'dart:math';

import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/Actions/add_driver.dart';
import 'package:bblease/Flow/Rental/Actions/car_docu.dart';
import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/Flow/home_page.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';
import '../../models/class_rent.dart';
import '../../models/class_user.dart';
import 'car_dialog.dart';

class ActiveRentDetails extends StatefulWidget {
  const ActiveRentDetails({Key? key}) : super(key: key);

  @override
  State<ActiveRentDetails> createState() => _ActiveRentDetailsState();
}

class _ActiveRentDetailsState extends State<ActiveRentDetails> {

  String _time = '00:00:00';
  Rental rent = User().currentRent!;
  //final ScrollController _controller = ScrollController();

  Duration duration = Duration(minutes: 1); // Set the initial countdown time
  Timer? timer,reminder;


  bool isLocked=true;

  double  percent= -1;
  int km= -1;


  getTime(){
    ApiService().getTimeRemain(rent.orderNum!, (res) => setState(()=>_time=res));
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
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

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timer!.cancel();
        // You can also trigger an event when the timer is up.
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getTime();
    getFuel();
    reminder=Timer(Duration(minutes: 10), () =>addDriveReminder());
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
                          fontWeight: FontWeight.bold,
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
                        ImageIcon(AssetImage("assets/icons/car_icon.png"), color: pinkColorApp,),
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
                                      Text('דיווח\n על תקלה', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,height: 1),
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
                                      Text('איפה חניתי', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,),textAlign: TextAlign.center,)
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
                                      Text('צור קשר', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,),textAlign: TextAlign.center,)
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
                                        Text('הוספת נהג חדש', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                                        Text('תיעוד רכב', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                                        Text('סיום השכרה', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                        fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.normal,
                            color: const Color.fromRGBO(15, 21, 17, 1),
                            )),
                    Text(' | ',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromRGBO(15, 21, 17, 1),
                            )),
                    Text(intl.DateFormat('dd/MM/yyyy').format(rent.endDate),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
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
                                    '  הארכת השכרה   ',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
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
                              if(DateTime.now().isBefore(rent.endDate)){
                                displayQuestion1(context, header:' שים לב',
                                  message: 'בסיום השכרה נוכחית\nתחיוב בעלות ההשכרה כולה בהתאם לתקנון', onYes: () =>endRental(),);
                              }
                              showLoading(context);
                              ApiService().returnCar(rent.orderNum!,
                                  (orderJson) {
                                Navigator.pop(context);
                                /*displayMessage(context,
                                    message: 'סיום ההשכרה נקלט בהצלחה',
                                    onClose: () {});*/
                                endRental();
                                print('return car');
                              });
                            },
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '   סיום השכרה   ',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
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
                            shadows: const [
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
                                      fontWeight: FontWeight.normal,
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
                            shadows: const [
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
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              ApiService().getParkPosition(rent.car.carNumber, (res) {
                                print(res);
                                findPark(res);
                              });
                            },
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
                            shadows: const [
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
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => displayQuestion1(context,message: 'ודא כי יש ברשותך את פרטי הרשיון\nשל הנהג הנוסף',header: 'ברצונך להוסיף נהג חדש?',
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
                            shadows: const [
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
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => displayQuestion1(context,header: 'צעד חכם!',message: 'ודא שהתמונות מצולמות באיכות טובה',
                                  onYes: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CarDocu(carNum: rent.car.carNumber,),))),
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
                            shadows: const [
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
                                          fontWeight: FontWeight.normal,
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
                                             Text('סיום השכרה', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                                  fontWeight: FontWeight.bold,
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
                                    fontWeight: FontWeight.bold,
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
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    Container(
                      width: 108.w,
                      height: 114.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        shadows: const [
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
                          if(isLocked) {
                            ApiService().openDoors(rent.car.carNumber, (res) {
                                print(res);
                               setState(() {
                                 isLocked=false;
                               });
                               _showFloatingDialog();
                              });
                          }
                          else {
                            ApiService().lockDoors(rent.car.carNumber,
                                  (res) {
                                print(res);
                                setState(() {
                                  isLocked=true;
                                });
                              });
                          }
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
                              color: isLocked?pinkColorApp.withOpacity(0.5):turquoiseColorApp.withOpacity(0.5),
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

  Future findPark(String address) {

    return showModalBottomSheet(
      isDismissible: false,
      elevation: 2,
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) => Container(
        height: 250.h,
          decoration: const BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
                children: [
                  SizedBox(height: 45.h),
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('כתובת חנית הרכב  ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: blackColorApp,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      ImageIcon(AssetImage("assets/icons/car_icon.png"),color: pinkColorApp,),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Text(address,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                      )
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('פתח ניווט באמצעות      ',
                          style: TextStyle(
                            color: blackColorApp,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          )
                      ),
                      IconButton(
                          onPressed: () => openWaze(0, 0),
                          icon: ImageIcon(AssetImage("assets/icons/waze.png"),color: turquoiseColorApp,)),
                      SizedBox(width: 23.w,),
                      IconButton(
                        onPressed: () => openGoogleMaps(0, 0),
                        icon: ImageIcon(AssetImage("assets/icons/maps.png"),color: turquoiseColorApp,)),
                    ],
                  )
                ]
            ),
          )
      ),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    );
  }

  Future addDriveReminder(){
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: Colors.black12.withOpacity(0.1),
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        builder: (context) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 35.h),
                      Text(
                        'הי,שים לב!',
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 51.h),
                      Text('בחרת בהוספת נהג נוסף,\nועוד לא מלאת את הפרטים',style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,),),
                      SizedBox(height: 26.h),
                      Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 160.w,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: turquoiseColorApp,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => AddDriver(),)),
                                child: Text('למלא עכשיו',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal))),
                          ),
                          SizedBox(width: 13.h),
                          Container(
                            height: 48.h,
                            width: 160.w,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: turquoiseColorApp,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () {
                                  reminder=Timer(const Duration(minutes: 10), () =>addDriveReminder());
                                  Navigator.pop(context);
                                },
                                child: Text('בהמשך',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal))),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ]
                ),
              )
          );
        }
    );
  }

  // Function to open a location in Waze
  Future<void> openWaze(double latitude, double longitude) async {
    var url = 'https://waze.com/ul?ll=$latitude,$longitude&navigate=yes';
    if (await canLaunchUrl(Uri(path: url))) {
      await launchUrl(Uri(path: url));
    } else {
      throw 'Could not launch $url';
    }
  }

// Function to open a location in Google Maps
  Future<void> openGoogleMaps(double latitude, double longitude) async {
    var url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri(path: url))) {
      await launchUrl(Uri(path: url));
    } else {
      throw 'Could not launch $url';
    }
  }


  Future endRental() {

    bool ended =false;
    return showModalBottomSheet(
      isDismissible: false,
      elevation: 2,
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) => Container(
          //height: 180.h,
          decoration: const BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
              children: [
            SizedBox(height: 45.h),
            // const Spacer(),
            Text(ended? 'השכרה מספר ${rent.orderNum} הסתיימה':'סיום השכרה',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: pinkColorApp,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                )
            ),
                SizedBox(height: 24.h),
                Visibility(
                  visible: !ended,
                    child: Container()),
                Visibility(
                    visible: !ended,
                    child: Text('בלחיצת אישור ינעלו דלתות הרכב\nוקוד הפתיחה ישתנה',style: TextStyle(color: pinkColorApp),)),
                Visibility(
                  visible: ended,
                  child: Text('השכרה מספר בדקות הקרובות תופיע קבלה באזור האישי או במייל',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                Visibility(
                  visible: ended,
                  child: Text('מודים שבחרת בביביליס\nמחכים לראותך שוב :)',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w200,
                      )),
                ),
            SizedBox(height: 11.h),
            SizedBox(
              height: 42.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {

                    ended
                        ? Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()))
                        : setState(() {ended=true;});
                    },
                  child: Text(
                    ended?'צא למסך הראשי':'מאשר',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal),
                  )),
            ),
            SizedBox(height: 22.h)
          ])),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    );
  }

  void _showFloatingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shadowColor: Colors.grey.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ), //this right here
          child: Container(
            height: 185.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                    child: CloseButton()),

                ImageIcon(AssetImage("assets/icons/car_open_doors.png"),color: pinkColorApp,),
                SizedBox(height: 30.h),

                Text(
                  'הדלתות פתוחות',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'נסיעה בטוחה!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),

              ],
            ),
          ),
        );
      },
    );
  }
}
