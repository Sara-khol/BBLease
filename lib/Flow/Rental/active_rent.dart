import 'dart:async';

import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/Actions/add_driver.dart';
import 'package:bblease/Flow/Rental/Actions/car_docu.dart';
import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher_string.dart';
import '../../landspace_widget.dart';
import '../../models/class_rent.dart';
import '../../models/class_user.dart';
import 'Actions/report_accident.dart';
import 'car_dialog.dart';

class ActiveRentDetails extends StatefulWidget {
  const ActiveRentDetails({super.key});

  @override
  State<ActiveRentDetails> createState() => _ActiveRentDetailsState();
}

class _ActiveRentDetailsState extends State<ActiveRentDetails> {

  String _time = '00:00:00';
  Rental rent = User().currentRent!;
  //final ScrollController _controller = ScrollController();

   late Duration duration = const Duration(minutes: 1); // Set the initial countdown time
  Timer? timer,reminder;


  bool isLocked=true;

  double p=-1;
  int  percent= -1;
  int km= -1;


  getTime(){
    ApiService().getTimeRemain(rent.orderNum!, (res) {
      _time = res;
      List<String> parts = _time.split(':');
      int days = int.parse(parts[0]);
      int hours = int.parse(parts[1]);
      int minutes = int.parse(parts[2]);
      int seconds = int.parse(parts[3]);

      duration = Duration(days: days,hours: hours, minutes: minutes, seconds: seconds);
      setState(() {});
      startTimer();
    });

  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_)  {
      //const reduceSecondsBy = 1;
      if (duration.inSeconds == 0) {
        timer?.cancel();
      } else {
        setState(() {
          duration -= const Duration(seconds: 1);
          //print('${duration.inDays}:${duration.inHours}:${duration.inMinutes}:${duration.inSeconds}');
        });
      }
    });
  }
  getFuel(){
    ApiService().getFuelLevel(rent.car.carNumber, (res) {
      if(res!=-1){
        p=res['fuel_percentage'];
        km=res['fuel_per_km'];
        percent=p.toInt();
        setState(() { });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    reminder?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getTime();
    getFuel();
    //reminder=Timer(Duration(minutes: 10), () =>addDriveReminder());
  }

   sendOpeningCode(){
     showLoading(context);
    ApiService().getOpeningCode(rent.orderNum!, (res) {
      Navigator.pop(context);
      print(res);
      openingCodeDialog(context, res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(orientation), imageProperties:ImageProperties('image2.png', 1000.w,'הזמנה פעילה עם טיימר'),);
        }
        return buildContent(orientation);
      }),
    );
  }

  buildContent(Orientation o) {
    String formatTimeComponent(int n) => n.toString().padLeft(2, '0');
    final days = duration.inDays.toString(); // No padding needed for days
    final hours = formatTimeComponent(duration.inHours.remainder(24));
    final minutes = formatTimeComponent(duration.inMinutes.remainder(60));
    final seconds = formatTimeComponent(duration.inSeconds.remainder(60));

    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            if(o==Orientation.portrait) const Directionality(textDirection: TextDirection.ltr, child: AppBarBibilease()),
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
                    decoration: const BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        SizedBox(width: 29.w),
                        Image.asset("assets/icons/car_icon_black.png",color: pinkColorApp,),
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
                /*kIsWeb?
                  Text(duration.inDays > 0 ?'$seconds:$minutes:$hours:$days':'$seconds:$minutes:$hours',
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(15, 21, 17, 1),
                         )):*/
                Text(duration.inDays > 0 ?'$days:$hours:$minutes:$seconds':'$hours:$minutes:$seconds',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(15, 21, 17, 1),
                    )),
                SizedBox(height: 24.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(/*kIsWeb?intl.DateFormat('ss:mm:HH').format(rent.endDate):*/intl.DateFormat('HH:mm:ss').format(rent.endDate),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromRGBO(15, 21, 17, 1),
                      ),
                    ),
                    Text(' | ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromRGBO(15, 21, 17, 1),
                        )),
                    Text(/*kIsWeb?intl.DateFormat('yyyy/MM/dd').format(rent.endDate):*/intl.DateFormat('dd/MM/yyyy').format(rent.endDate),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*Container(
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
                                *//*ApiService().openDoors(rent.car.carNumber, (res) {
                                print(res);
                                openingCodeDialog(context, res);
                              });
                              //sendOpeningCode();*//*
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(width: 8.w,),*/
                      SizedBox(
                        height: 46.h,
                        //width: 162.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: pinkColorApp,
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.only(
                                  right: 9.w,
                                  left: 13.w,
                                  top: 8.h,
                                  bottom: 10.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
                            ),
                            onPressed: () {
                              if(DateTime.now().isBefore(rent.endDate)){
                                displayQuestion1(context, header:' שים לב',
                                    message: 'בסיום השכרה נוכחית\nתחיוב בעלות ההשכרה כולה בהתאם לתקנון', onYes: () {
                                      Navigator.pop(context);
                                      showLoading(context);
                                      ApiService().returnCar(rent.orderNum!, (orderJson) {
                                        User().currentRent=null;
                                        Navigator.pop(context);
                                        endRental(false);
                                        print('return car');
                                      });

                                    });
                              }
                              else{
                                showLoading(context);
                                User().currentRent=null;
                                ApiService().returnCar(rent.orderNum!, (orderJson) {
                                  Navigator.pop(context);
                                  endRental(false);
                                  print('return car');
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '  סיום השכרה    ',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
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
                  height: 100.h,
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
                          height: 100.h,
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
                          child: Center(
                            child: InkWell(
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h,),
                                  const ImageIcon(
                                    AssetImage("assets/icons/Broken.png"),
                                    color: Color(0xFF0F1511),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Expanded(
                                    child: Text(
                                      'דיווח\nעל תקלה',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportAccident(),)),
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
                          child: InkWell(
                            child: SizedBox(
                              //  width: 60.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Image.asset("assets/icons/car_icon_black.png"),
                                  // Image.asset("assets/icons/car_icon.png", color:  Color(0xFF0F1511),
                                  //     colorBlendMode: BlendMode.multiply),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'איפה חניתי',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              showLoading(context);
                              ApiService().getParkPosition(rent.car.carNumber, (res) {
                                Navigator.pop(context);
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
                                    SizedBox(height: 15.h,),
                                    Icon(Icons.account_circle_outlined, size: 24.sp,),
                                    SizedBox(height: 10.h,),
                                    Expanded(
                                      child: Text(
                                        'הוספת\nנהג נוסף',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => displayQuestion1(context,message: 'ודא כי יש ברשותך את פרטי הרשיון\nשל הנהג הנוסף',header: 'ברצונך להוסיף נהג חדש?',
                                  onYes: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddDriver(index: 3,orderId: rent.orderNum,),))),
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
                                    SizedBox(height: 15.h,),
                                    Icon(Icons.camera_alt_outlined, size: 24.sp,),
                                    SizedBox(height: 10.h,),
                                    Expanded(
                                      child: Text('תיעוד רכב',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => displayQuestion1(context,header: 'צעד חכם!',message: 'ודא שהתמונות מצולמות באיכות טובה',
                                  onYes: () {
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          CarDocu(
                                              rentNum: rent.orderNum!),));
                                  }
                              ),
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
                                    SizedBox(height: 15.h,),
                                    Image.asset('assets/icons/key.png'),
                                    SizedBox(height: 10.h,),
                                    Expanded(
                                      child: Text('שלח קוד\nלפתיחת דלת',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: ()=>sendOpeningCode(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170.w,
                      //  height: 114.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 12.h,),
                          if (percent!=-1) Text(
                            '$percent%',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                height: 1),
                          ) else SizedBox(height: 21.h,),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/KM.png'),
                              SizedBox(width: 19.w),
                              Text(
                                '|',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xffD9D9D9),
                                    fontWeight: FontWeight.bold,
                                    height: 1),
                              ),
                              SizedBox(width: 19.w),
                              Image.asset('assets/icons/Gas.png'),
                            ],
                          ),
                          SizedBox(height: 19.h),
                          if (km!=-1) Text(
                            '$km ק"מ',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                height: 1),
                          ) else SizedBox(height: 21.h),
                          SizedBox(height: 10.h)
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    Container(
                      width: 108.w,
                      //  height: 114.h,
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
                            showLoading(context);
                            ApiService().openDoors(rent.car.carNumber, (res) {
                              Navigator.pop(context);
                              print(res);
                              setState(() {
                                isLocked=false;
                              });
                              _showFloatingDialog();
                            });
                          }
                          else {
                            showLoading(context);
                            ApiService().lockDoors(rent.car.carNumber, (res) {
                              Navigator.pop(context);
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
                              isLocked?const AssetImage("assets/icons/unlock.png"):const AssetImage("assets/icons/lock.png"),
                              color: isLocked?turquoiseColorApp:pinkColorApp,
                            ),
                            SizedBox(height: 7.h),
                            Image.asset('assets/icons/Frame-30.png'),
                            SizedBox(height: 4.58.h),
                            ImageIcon(
                              isLocked?const AssetImage("assets/icons/lock.png"):const AssetImage("assets/icons/unlock.png"),
                              color: isLocked?pinkColorApp.withOpacity(0.5):turquoiseColorApp.withOpacity(0.5),
                            ),
                            SizedBox(height: 10.h),

                            //SizedBox(height:10.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 44.h,)
              ],
            ),
          ],
        ),
      ),
    );
  }


  Future findPark(address) {

    return showModalBottomSheet(
      isDismissible: false,
      elevation: 2,
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) => Container(
        // height: 250.h,
          decoration: const BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment:  Alignment.topCenter,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*   Container(
                              padding: EdgeInsets.only(right: 20.w,top: 18.h),
                              // height: 28.h,
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),*/
                            SizedBox(height: 30.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('כתובת חנית הרכב  ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: blackColorApp,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 1
                                    )
                                ),
                                ImageIcon(const AssetImage("assets/icons/car_icon_black.png"),color: pinkColorApp,),
                              ],
                            ),
                            SizedBox(
                                height: 40.h),
                            Center(
                              child: Text(address["address"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blackColorApp,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                  )
                              ),
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('פתח ניווט באמצעות      ',
                                    style: TextStyle(
                                      color: blackColorApp,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                    )
                                ),
                                IconButton(
                                    onPressed: () => openWaze(address['latitude'],address['longitude']),
                                    icon: ImageIcon(const AssetImage("assets/icons/waze.png"),color: turquoiseColorApp,)),
                                SizedBox(width: 23.w,),
                                IconButton(
                                    onPressed: () => openGoogleMaps(address['address']),
                                    icon: ImageIcon(const AssetImage("assets/icons/maps.png"),color: turquoiseColorApp,)),
                              ],
                            ),
                            SizedBox(height: 39.h),
                          ]
                      ),
                    ),
                    Align(
                      alignment:  Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.only(right: 20.w,top: 10.h),
                        // height: 28.h,
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    );
  }

  Future addDriverReminder(){
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
                          SizedBox(
                            height: 48.h,
                            width: 160.w,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: turquoiseColorApp,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => AddDriver(index: 3,orderId: rent.orderNum,),)),
                                child: Text('למלא עכשיו',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal))),
                          ),
                          SizedBox(width: 13.h),
                          SizedBox(
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
                                  reminder=Timer(const Duration(minutes: 10), () =>addDriverReminder());
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
    //String query = Uri.encodeComponent(address);
    var url = 'https://waze.com/ul?q=$latitude,$longitude&navigate=yes';
    if (await canLaunchUrlString(url)) {
      print('can launch url to waze');
      await launchUrlString(url);
    } else {
      print('can not launch url to waze');
      throw 'Could not launch $url';
    }
  }

// Function to open a location in Google Maps
  Future<void> openGoogleMaps(String address/*double latitude, double longitude*/) async {
    String query = Uri.encodeComponent(address);
    var url = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunchUrlString(url)) {
      print('can launch url to maps');
      await launchUrlString(url);
    } else {
      print('can not launch url to maps');
      throw 'Could not launch $url';
    }
  }

  Future endRental(bool ended) {
    //bool ended =false;
    return showModalBottomSheet(
      isDismissible: false,
      elevation: 2,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      context: context,
      enableDrag: false,
      builder: (BuildContext context) => Container(
        //width: MediaQuery.devicePixelRatioOf(context),
        //height: 180.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Wrap( crossAxisAlignment: WrapCrossAlignment.center,
              children: [
            Container(height: 45.h),
            // Spacer(),
            Center(
              child: Text(ended ? 'השכרה מספר ${rent.orderNum} הסתיימה' : 'סיום השכרה',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: pinkColorApp,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Container(height: 24.h),
            Visibility(visible: !ended, child: Container()),
            Visibility(
                visible: !ended,
                child: Center(
                  child: Text(
                    'בלחיצת אישור ינעלו דלתות הרכב\nוקוד הפתיחה ישתנה',
                    style: TextStyle(color: pinkColorApp,fontSize: 16.sp,fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,

                  ),
                )),
            Visibility(
              visible: ended,
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 11.h),
                  child: Text('בדקות הקרובות תופיע קבלה באזור האישי או במייל',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ),
            ),
            Visibility(
              visible: ended,
              child: Center(
                child: Text('מודים שבחרת בביביליס',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: blackColorApp,
                      fontSize: 16.sp,
                   //   fontWeight: FontWeight.w200,
                    )),
              ),
            ),
            Visibility(
                  visible: ended,
                  child: Center(
                    child: Text('מחכים לראותך שוב :)',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: blackColorApp,
                          fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
           Container(height: 11.h),
            Center(
              child: SizedBox(
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
                          ? {
                      User().currentRent=null,
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RentalWidget()))
                      }
                          : {Navigator.pop(context), endRental(true)};
                    },
                    child: Text(
                      ended ? 'צא למסך הראשי' : 'מאשר',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal),
                    )),
              ),
            ),
                Container(height: 22.h)
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
          backgroundColor:  Colors.white,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),), //this right here
          child: SizedBox(
            width: 256.w,
           // height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox(height: 18.h,),
                const Align(alignment: Alignment.topRight, child: CloseButton()),
                SizedBox(height: 9.h,),
                ImageIcon(const AssetImage("assets/icons/car_open_doors.png"),color: pinkColorApp,),
                SizedBox(height: 30.h),
                Text(
                  'הדלתות פתוחות',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'נסיעה בטוחה!',
                  style: TextStyle( fontSize: 20.sp),
                  textAlign: TextAlign.center,textDirection: TextDirection.rtl,
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
