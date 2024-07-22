import 'package:bblease/Flow/Rental/active_rent.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/UserInformation/orderDetails.dart';
import 'package:bblease/Flow/home_page.dart';
import 'package:bblease/landspace_widget.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_html/html.dart' as html;
import '../../models/class_rent.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../Rental/Actions/cancel_order_dialogs.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  List<Rental> ordersHistory = [];
  List<Rental> futureOrders = [];
  late Rental currentRent;
  late int selected=widget.index;//history=1, future=2

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  DateTime? s;
  DateTime? e;
  bool initData = false;

  getOrders() async {
    try {
      print('getOrders');
      await ApiService().getUserOrders(User().userId, (data) {
        var historyJson = data['history'];
        var futureJson = data['futurity'];
        print(historyJson);
        print(futureJson);
        if(historyJson!=null)ordersHistory = historyJson.map<Rental>((entry) => (Rental.fromJson(entry))).toList();
        if(futureJson!=null)futureOrders = futureJson.map<Rental>((entry) => (Rental.fromJson(entry))).toList();
        print(ordersHistory.length);

        for (var item in ordersHistory) {
          print(item.status);
          if (item.status == "active-rentals") {
            User().currentRent = item;
          }
        }
        ordersHistory = ordersHistory.where((item) => item.status != "active-rentals").toList();

        initData = true;

        setState(() {});
      });
    } catch (e, s) {
      debugPrint('error ${e} $s');
    }
  }
  /*getActiveRent() async {
    await ApiService().getActiveRent(User().userId, (rent) {
      print(rent);
        currentRent = rent.map<Rental>((entry) => (Rental.fromJson(entry))).toList();
        initData = true;
        print('rent: ${currentRent?.orderNum}');

        setState(() {        });

    });

  }*/

  void downloadFileWeb(String url) {
    String fileName = 'bibilease.pdf';
    if (kIsWeb) {
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
    }
  }

  filterByDate() {
    TextEditingController start = TextEditingController();
    TextEditingController end = TextEditingController();
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 450.h),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'סנן הזמנות לפי תאריך  ',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                ImageIcon(
                                  const AssetImage("assets/icons/CalendarBig.png"),
                                  color: pinkColorApp,
                                ),
                              ],
                            ),
                            SizedBox(height: 26.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('ממתי ?',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                            TextFormField(
                              readOnly: true,
                              cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.normal,
                                  color: const Color.fromRGBO(15, 17, 21, 1),
                                  fontFamily: 'PLONI',
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,),
                                  borderSide: const BorderSide(color: Color.fromRGBO(15, 17, 21, 1),),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0,),
                                  borderSide: const BorderSide(color: Color.fromRGBO(15, 17, 21, 1),),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
                                suffixIcon: ImageIcon(
                                  const AssetImage("assets/icons/CalendarBig.png"),
                                  color: pinkColorApp,
                                ),
                              ),
                              //style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                              controller: start,
                              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w300),
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    locale: const Locale("he", "HE"),
                                    textDirection: TextDirection.rtl,
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  start.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                  print('start: ${start.text}');
                                  s = date;
                                }
                              },
                            ),
                            SizedBox(height: 20.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('עד -',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                            TextFormField(
                              readOnly: true,
                              cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w300,
                                    color: const Color.fromRGBO(15, 17, 21, 1),
                                    fontFamily: 'PLONI',
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0,),
                                    borderSide: const BorderSide(color: Color.fromRGBO(15, 17, 21, 1),),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0,),
                                    borderSide: const BorderSide(color: Color.fromRGBO(15, 17, 21, 1),),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
                                  suffixIcon: ImageIcon(
                                    AssetImage("assets/icons/Calendar.png"),
                                    color: pinkColorApp,
                                  )),
                              style: TextStyle(fontSize: 22.sp),
                              controller: end,
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    locale: const Locale("he", "HE"),
                                    textDirection: TextDirection.rtl,
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  end.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                  e = date;
                                }
                              },
                            ),
                            SizedBox(height: 30.h,),
                            SizedBox(
                              height: 48.h,
                              width: 332.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: turquoiseColorApp,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {});

                                  },
                                  child: const Text(
                                    'הצג',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      color: Colors.white
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
        barrierColor: Colors.black12.withOpacity(0.1),
        //isDismissible: false,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:OrientationBuilder(builder: (c,o){
        return o==Orientation.landscape?
            LandSpaceWidget(mainWidget: buildContent(), imageProperties: ImageProperties('l_register1.png', 618.w)) :buildContent();
      },) ,
    );
  }

  buildContent()
  {
    // Widget downloadIcon = Icon(Icons.file_download, color: pinkColorApp);
    Widget downloadIcon =  Image.asset("assets/icons/Download.png");

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // Directionality(textDirection: TextDirection.ltr, child: AppBarBibilease()),
          SizedBox(height: 24.h,),
          Padding(
            padding:  EdgeInsets.only(right: 23.w),
            child: Align(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
          ),
          SizedBox(height: 42.h),
          Text(
            'ההזמנות שלי',
            style: TextStyle(
              color: Color(0xFF0F1511),
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 18.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 34.h,
                  width: 152.w,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: selected == 1 ? blackColorApp : Colors.transparent,
                  ),
                  child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          //minimumSize: Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            selected = 1;
                          });
                        },
                        child: Text(
                          'היסטורית הזמנות',
                          style: TextStyle(
                              fontSize: 18.sp,

                              fontWeight: selected == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: selected == 1 ? Colors.white : blackColorApp),
                        )),
                  ),
                ),
                Spacer(),
                Container(
                  height: 34.h,
                  width: 152.w,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: selected == 2 ? blackColorApp : Colors.transparent,
                  ),
                  child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          //minimumSize: Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            selected = 2;
                          });
                        },
                        child: Center(
                          child: Text(
                            'הזמנות עתידיות',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: selected == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color:
                                selected == 2 ? Colors.white : blackColorApp),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h,),
          TextButton(
              onPressed: () {
                filterByDate();
                setState(() {                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('סנן לפי תאריך ', style: TextStyle(fontSize: 14.sp, color: blackColorApp),),
                  ImageIcon(AssetImage("assets/icons/Filter.png"), color: pinkColorApp,),
                  SizedBox(width: 40.w,)
                ],
              )),
          SizedBox(height: 30.h,),
          SizedBox(
            height: 48.h,
            width: 332.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: initData && User().currentRent != null ? turquoiseColorApp : turquoiseColorApp.withOpacity(0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                  padding: EdgeInsets.symmetric(horizontal: 10.w,),
                  elevation: 0.0,
                ),
                onPressed: initData && User().currentRent != null ? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActiveRentDetails(),
                      ));
                } : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageIcon(AssetImage("assets/icons/car.png"), color: Colors.white,),
                    SizedBox(width:52.w),
                    Text('פתח הזמנה פעילה',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 20.h,),
          initData
            ? ordersHistory.isNotEmpty
            ? MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: selected == 1
              ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ordersHistory.length,
                  //padding: EdgeInsets.only(bottom: 8.h),
                  itemBuilder: (context, index) {
                    Rental rent = ordersHistory[index];
                    if ((s == null || e == null) ||
                        (rent.startDate.isBefore(e!) ||
                            rent.startDate.compareTo(e!) == 0 ||
                            rent.endDate.isAfter(s!))) {
                      return Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetails(
                                          rent: rent,
                                        ),
                                  ));
                            },
                            child: Container(
                              width: 332.w,
                              height: 50.h,
                              margin: EdgeInsets.only(left: 20.w,right: 20.w),
                              decoration: BoxDecoration(color: Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                child: Row(
                                  children: [
                                    Text(
                                      intl.DateFormat('dd.MM.yyyy')
                                          .format(rent.startDate),
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          print(rent.url);
                                          if (kIsWeb) {
                                            downloadFileWeb(rent.url!);
                                            // Optionally, update UI immediately since web doesn't track download progress
                                            setState(() {
                                              downloadIcon = const Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.white,
                                              );
                                            });
                                          }
                                          else{
                                          FileDownloader.downloadFile(
                                            url: rent.url!,
                                            onDownloadCompleted: (path) =>
                                                setState(() {
                                                  print('download complete');
                                                  downloadIcon = Icon(
                                                    Icons.check_circle_outline,
                                                    color: pinkColorApp,
                                                  );
                                                }),
                                          );}
                                        },
                                        icon: downloadIcon),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h,)
                        ],
                      );
                    }
                  },
                ),
              )
              : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: futureOrders.length,
                  itemBuilder: (context, index) {
                    Rental rent = futureOrders[index];
                    if ((s == null || e == null) ||
                        (rent.startDate.isBefore(e!) ||
                            rent.startDate.compareTo(e!) == 0 ||
                            rent.endDate.isAfter(s!) == 0)) {
                      return GestureDetector(
                        onTap: () {
                           Navigator.push(context,
                               MaterialPageRoute(
                                 builder: (context) => OrderDetails(
                                   rent: rent,
                                 ),
                               ));
                        },
                        child: Container(
                          width: 332.w,
                          height: 50.h,
                          margin: EdgeInsets.only(bottom: 22.h, left: 30.w, right: 30.w),
                          decoration: BoxDecoration(color: Color(0xFFD9FFFD), borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            child: Row(
                              children: [
                                Icon(Icons.access_time),
                                Text('תחל בתאריך: ',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                Text(intl.DateFormat('dd.MM.yyyy').format(rent.startDate),
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight:
                                      FontWeight.w300),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () => cancelOrderDialog(context, rent),
                                  icon: ImageIcon(
                                    const AssetImage("assets/icons/trash.png"),
                                    color: blackColorApp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ))
              : Text(
            'אין הזמנות קיימות',
            style: TextStyle(fontSize: 18.sp),
          )
              : Center(child: CircularProgressIndicator(color: pinkColorApp,),
          ),
          if (ordersHistory.isEmpty)   const Spacer(),
          Container(
            height: 48.h,
            width: 332.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: turquoiseColorApp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 0.0,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentalWidget(),
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'חזרה לתפריט ראשי   ',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 45.h,
          ),
        ],
      ),
    );
  }
}
