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

  late Duration duration =
      const Duration(minutes: 1); // Set the initial countdown time
  Timer? timer, reminder;

  bool isLocked = true;

  double p = -1;
  int percent = -1;
  int km = -1;
  late Orientation realOrientation;

  getTime() {
    ApiService().getTimeRemain(rent.orderNum!, (res) {
      _time = res;
      List<String> parts = _time.split(':');
      int days = int.parse(parts[0]);
      int hours = int.parse(parts[1]);
      int minutes = int.parse(parts[2]);
      int seconds = int.parse(parts[3]);

      duration = Duration(
          days: days, hours: hours, minutes: minutes, seconds: seconds);
      setState(() {});
      startTimer();
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
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

  getFuel() {
    ApiService().getFuelLevel(rent.car.carNumber, (res) {
      if (res != -1) {
        p = res['fuel_percentage'].toDouble();
        km = res['fuel_per_km'] ?? -1;
        percent = p.toInt();
        setState(() {});
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      showVehicleInspectionDialog(context);
    });
    //reminder=Timer(Duration(minutes: 10), () =>addDriveReminder());
  }

  showVehicleInspectionDialog(BuildContext context, [Function()? onClose]) {
    displayMessageWithTitle(
      change: true,
      context,
      title: 'חשוב לתעד את הרכב',
      message: 'יש לבצע תיעוד איכותי וברור של הרכב בתחילת ההשכרה ובסיומה.\n\n'
          'יש לצלם את כל צדדי הרכב וכל נזק קיים.\n\n'
          'נזק שלא תועד בתחילת ההשכרה עשוי להיות מחויב ללקוח.\n'
          'במקרה שלא קיים תיעוד מתחילת ההשכרה, הלקוח עשוי להיות מחויב בגין נזקים שיימצאו ברכב.',
      textButton: 'הבנתי',
      onClose: () {
        if (onClose != null) {
          onClose();
        }
        // המשך פעולה אם צריך
      },
    );
  }

  sendOpeningCode() {
    showLoading(context);
    ApiService().getOpeningCode(rent.orderNum!, (res) {
      Navigator.pop(context);
      // print(res);
      openingCodeDialog(context, res);
    });
  }

  @override
  Widget build(BuildContext context) {
    realOrientation = View.of(context).physicalSize.width >
            View.of(context).physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    return Scaffold(
        body: LandSpaceWidget(
            mainWidget: buildContent(realOrientation),
            imageProperties:
                ImageProperties('image2.png', 1000.w, 'הזמנה פעילה עם טיימר')));
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
            if (o == Orientation.portrait)
              const Directionality(
                  textDirection: TextDirection.ltr, child: AppBarBibilease()),
            Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Text('פרטי הזמנה פעילה',
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(15, 21, 17, 1),
                          height: 1)),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Container(
                    //  height: 42.h,
                    // width: 332.w,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        SizedBox(width: 29.w),
                        Image.asset("assets/icons/car_icon_black.png",
                            color: pinkColorApp,
                            fit: BoxFit.cover,
                            width: 24.sp.clamp(22.0, 28.0),
                            height: 24.sp.clamp(22.0, 28.0)),
                        Text(
                          ' מספר רכב:',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        // const Spacer(),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 7.w),
                            child: Text(
                              '  ${rent.car.carNumber} ',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Container(
                    //height: 42.h,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 29.w,
                        ),
                        Image.asset("assets/icons/location.png",
                            color: pinkColorApp,
                            //fit: BoxFit.cover,
                            width: 20.sp.clamp(18.0, 22.0),
                            height: 20.sp.clamp(18.0, 22.0)),
                        Text(' מיקום:',
                            style: TextStyle(
                              fontSize: 18.sp,
                            )),
                        // const Spacer(),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 7.w),
                            child: Text(
                              ' ${rent.car.address}  ',
                              style: TextStyle(fontSize: 18.sp),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 53.h,
                ),
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
                SizedBox(
                  height: 22.h,
                ),
                /*kIsWeb?
                  Text(duration.inDays > 0 ?'$seconds:$minutes:$hours:$days':'$seconds:$minutes:$hours',
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(15, 21, 17, 1),
                         )):*/
                Text(
                    duration.inDays > 0
                        ? '$days:$hours:$minutes:$seconds'
                        : '$hours:$minutes:$seconds',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(15, 21, 17, 1),
                    )),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      /*kIsWeb?intl.DateFormat('ss:mm:HH').format(rent.endDate):*/
                      intl.DateFormat('HH:mm:ss').format(rent.endDate),
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
                    Text(
                        /*kIsWeb?intl.DateFormat('yyyy/MM/dd').format(rent.endDate):*/
                        intl.DateFormat('dd/MM/yyyy').format(rent.endDate),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromRGBO(15, 21, 17, 1),
                            height: 1)),
                  ],
                ),
                SizedBox(
                  height: 33.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              displayQuestion1(
                                context,
                                header: 'חשוב לתעד את הרכב',
                                message:
                                'לפני סיום ההשכרה יש לבצע תיעוד איכותי וברור של הרכב.\u200F\n\n'
                                    'מומלץ לצלם את כל צדדי הרכב וכל נזק קיים.\u200F\n\n'
                                    'ללא תיעוד מסיום ההשכרה, ייתכן שלא ניתן יהיה לאמת את מצב הרכב בעת ההחזרה.\u200F',
                                yesText: 'סיים בכל זאת',
                                noText: 'לתיעוד הרכב',
                                onYes: () {
                                  Navigator.pop(context);
                                  if (DateTime.now().isBefore(rent.endDate)) {
                                    displayQuestion1(
                                      context,
                                      header: 'שים לב',
                                      message:
                                      'בסיום השכרה נוכחית\n'
                                          'תחויב בעלות ההשכרה כולה בהתאם לתקנון.\u200F',
                                      onYes: () {
                                        Navigator.pop(context);
                                        returnCarNow();
                                      },
                                    );
                                  } else {
                                    returnCarNow();
                                  }
                                },
                                onNo: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                       CarDocu(rentNum: rent.orderNum!,)));
                                },
                              );
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
                SizedBox(
                  height: 33.h,
                ),
                Container(
                  height: 100.h.clamp(100.0, 200.0),
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
                          height: 100.h.clamp(100.0, 200.0),
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
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Icon(Icons.report_problem,
                                      size: 28.sp.clamp(24.0, 34.0)),
                                  // const ImageIcon(
                                  //   AssetImage("assets/icons/Broken.png"),
                                  //   color: Color(0xFF0F1511),
                                  // ),
                                  SizedBox(height: 6.h.clamp(4.0, 8.0)),
                                  Expanded(
                                    child: Text(
                                      'דיווח\nעל תקלה',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,

                                        // height: 1.15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ReportAccident(),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          height: 100.h.clamp(100.0, 200.0),
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
                                  Icon(Icons.car_repair,
                                      size: 28.sp.clamp(24.0, 34.0)),
                                  // Image.asset("assets/icons/car_icon_big.png", color: Color(0xFF0F1511),),
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
                              ApiService().getParkPosition(rent.car.carNumber,
                                  (res) {
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
                          height: 100.h.clamp(100.0, 200.0),
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
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Icon(Icons.account_circle_outlined,
                                        size: 28.sp.clamp(24.0, 34.0)),
                                    SizedBox(
                                      height: 10.h,
                                    ),
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
                              onTap: () => displayQuestion1(context,
                                  message:
                                      'ודא כי יש ברשותך את פרטי הרשיון\nשל הנהג הנוסף',
                                  header: 'ברצונך להוסיף נהג חדש?',
                                  onYes: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddDriver(
                                          index: 3,
                                          orderId: rent.orderNum,
                                        ),
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          height: 100.h.clamp(100.0, 200.0),
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
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Icon(Icons.camera_alt_outlined,
                                        size: 28.sp.clamp(24.0, 34.0)),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'תיעוד רכב',
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
                              onTap: () => displayQuestion1(context,
                                  header: 'צעד חכם!',
                                  message: 'ודא שהתמונות מצולמות באיכות טובה',
                                  onYes: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CarDocu(rentNum: rent.orderNum!),
                                    ));
                              }),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Container(
                          height: 100.h.clamp(100.0, 200.0),
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
                                //width: 60.w,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    // Image.asset('assets/icons/key.png'),
                                    Icon(Icons.car_rental,
                                        size: 28.sp.clamp(24.0, 34.0)),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'שלח קוד\nלפתיחת דלת',
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
                              onTap: () => sendOpeningCode(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
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
                          SizedBox(
                            height: 12.h,
                          ),
                          if (percent != -1)
                            Text(
                              '$percent%',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            )
                          else
                            SizedBox(
                              height: 21.h,
                            ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/KM.png',
                                  width: 24.sp.clamp(22.0, 28.0),
                                  height: 24.sp.clamp(22.0, 28.0),
                                  fit: BoxFit.contain),
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
                              Image.asset('assets/icons/Gas.png',
                                  width: 24.sp.clamp(22.0, 28.0),
                                  height: 24.sp.clamp(22.0, 28.0),
                                  fit: BoxFit.cover),
                            ],
                          ),
                          SizedBox(height: 19.h),
                          if (km != -1)
                            Text(
                              '$km ק"מ',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            )
                          else
                            SizedBox(height: 21.h),
                          SizedBox(height: 10.h)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Container(
                      width: 108.w,
                      //  height: 114.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
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
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (isLocked) {
                            showLoading(context);
                            ApiService().openDoors(rent.car.carNumber, (res) {
                              Navigator.pop(context);
                              debugPrint('$res');
                              setState(() {
                                isLocked = false;
                              });
                              _showFloatingDialog(true);
                            });
                          } else {
                            showLoading(context);
                            ApiService().lockDoors(rent.car.carNumber, (res) {
                              Navigator.pop(context);
                              debugPrint('$res');
                              setState(() {
                                isLocked = true;
                              });
                              _showFloatingDialog(false);
                            });
                          }
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 11.h),

                            Image.asset(
                              isLocked
                                  ? "assets/icons/unlock.png"
                                  : "assets/icons/lock.png",
                              color:
                                  isLocked ? turquoiseColorApp : pinkColorApp,
                              width: 24.sp.clamp(22.0, 28.0),
                              height: 24.sp.clamp(22.0, 28.0),
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.h),

                            //SizedBox(height:10.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 44.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void returnCarNow() {
    showLoading(context);

    ApiService().returnCar(rent.orderNum!, (orderJson) {
      User().currentRent = null;
      Navigator.pop(context);
      endRental(false);
    });
  }

  Future findPark(address) {
    return showModalBottomSheet(
      isDismissible: false,
      elevation: 2,
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) => Container(
          // height: 250.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
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
                                        height: 1)),
                                SizedBox(
                                  width: 28.sp.clamp(24.0, 36.0),
                                  height: 28.sp.clamp(24.0, 36.0),
                                  child: Image.asset(
                                    "assets/icons/car_icon_black.png",
                                    color: pinkColorApp,
                                    width: 28.sp.clamp(24.0, 36.0),
                                    height: 28.sp.clamp(24.0, 36.0),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),
                            Center(
                              child: Text(address["address"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blackColorApp,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                  )),
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
                                    )),
                                IconButton(
                                    onPressed: () => openWaze(
                                        address['latitude'],
                                        address['longitude']),
                                    icon: Image.asset(
                                      "assets/icons/waze.png",
                                      color: turquoiseColorApp,
                                      width: 28.sp.clamp(24.0, 36.0),
                                      height: 28.sp.clamp(24.0, 36.0),
                                    )),
                                SizedBox(
                                  width: 23.w,
                                ),
                                IconButton(
                                  onPressed: () =>
                                      openGoogleMaps(address['address']),
                                  icon: Image.asset(
                                    "assets/icons/maps.png",
                                    color: turquoiseColorApp,
                                    width: 28.sp.clamp(24.0, 36.0),
                                    height: 28.sp.clamp(24.0, 36.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 39.h),
                          ]),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.only(right: 20.w, top: 10.h),
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
          )),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    );
  }

  Future addDriverReminder() {
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
          return SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            minimum: EdgeInsets.only(bottom: 20.h),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30.w,
                    right: 30.w,
                  ),
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
                        Text(
                          'בחרת בהוספת נהג נוסף,\nועוד לא מלאת את הפרטים',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 48.h,
                                  //width: 160.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: turquoiseColorApp,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddDriver(
                                              index: 3,
                                              orderId: rent.orderNum,
                                            ),
                                          )),
                                      child: Text('למלא עכשיו',
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal))),
                                ),
                              ),
                              SizedBox(width: 13.h),
                              Expanded(
                                child: SizedBox(
                                  height: 48.h,
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
                                        reminder = Timer(
                                            const Duration(minutes: 10),
                                            () => addDriverReminder());
                                        Navigator.pop(context);
                                      },
                                      child: Text('בהמשך',
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ]),
                )),
          );
        });
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
  Future<void> openGoogleMaps(
      String address /*double latitude, double longitude*/) async {
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
      // isDismissible: false,
      elevation: 2,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      context: context,
      enableDrag: false,
      builder: (BuildContext context) => Container(
          //width: MediaQuery.devicePixelRatioOf(context),
          //height: 180.h,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            minimum: EdgeInsets.only(bottom: 20.h),
            child:
                Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
              Container(height: 35.h),
              // Spacer(),
              Center(
                child: Text(
                    ended
                        ? 'השכרה מספר ${rent.orderNum} הסתיימה'
                        : 'סיום השכרה',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pinkColorApp,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Container(height: 8.h),
              Visibility(
                  visible: !ended,
                  child: Center(
                      child: Text(
                    'נא לוודא שהרכב מתודלק, כבוי ובתוך התחנה\n'
                    'וכי הוצאת את כל חפציך האישיים מהרכב.',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: turquoiseColorApp,
                      fontSize: 20.sp,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ))),
              Visibility(visible: !ended, child: Container(height: 25.h)),
              Visibility(
                  visible: !ended,
                  child: Center(
                    child: Text(
                      'בלחיצת אישור ינעלו דלתות הרכב\nוקוד הפתיחה ישתנה',
                      style: TextStyle(
                          color: pinkColorApp,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Visibility(
                visible: ended,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 11.h),
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
                  child: Text('מודים שבחרת ב B CLICK',
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
              Container(height: 15.h),
              Center(
                child: SizedBox(
                  height: 42.h,
                  //width: 332.w,
                  width: double.infinity,
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
                                User().currentRent = null,
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RentalWidget()))
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
              //Container(height: 50.h)
            ]),
          )),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    );
  }

  void _showFloatingDialog(bool isOpenLock) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ), //this right here
          child: SizedBox(
            width: 256.w,
            // height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 18.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: const Align(
                      alignment: Alignment.topRight, child: CloseButton()),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Image.asset("assets/icons/car_open_doors.png",
                    color: pinkColorApp,
                    fit: BoxFit.contain,
                    width: 24.sp.clamp(20.0, 30.0),
                    height: 24.sp.clamp(20.0, 30.0)),
                SizedBox(height: 30.h),
                Text(
                  isOpenLock ? 'הדלתות פתוחות' : 'הדלתות ננעלו',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                if (isOpenLock)
                  Text(
                    'נסיעה בטוחה!',
                    style: TextStyle(fontSize: 20.sp),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
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
