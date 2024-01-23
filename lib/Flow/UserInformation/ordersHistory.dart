import 'package:bblease/Flow/Rental/active_rent.dart';
import 'package:bblease/Flow/UserInformation/orderDetails.dart';
import 'package:bblease/Flow/home_page.dart';
import 'package:bblease/Flow/welcome.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../customWidgets/appBarB.dart';
import '../../models/class_rent.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/class_user.dart';
import '../../services/api_service.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({Key? key}) : super(key: key);

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  List<Rental> orders = [];
  late Rental currentRent;

  @override
  void initState() {
    getOrders();
    //getActiveRent();
    super.initState();
  }

   DateTime? s;
   DateTime? e;
  bool initData = false;

  getOrders() async {
<<<<<<< HEAD
    print('getOrders');
    await ApiService().getUserOrders(User().userId, (rent) {
      print('onSuccess');
      orders = rent.map<Rental>((entry) => (Rental.fromJson(entry))).toList();

      print('orders: ${orders.length}');

      for(var item in orders) {
        print(item.status);
        if(item.status=="active-rentals") {
          User().currentRent=item;
        }
      }
      initData = true;

      setState(() {
        /*if (orders.isNotEmpty) {
          // s = orders.first.startDate;
          // e = orders.last.endDate;
        }*/
=======
   try {
      await ApiService().getUserOrders(User().userId, (rent) {
        print('onSuccess');
        orders = rent.map<Rental>((entry) => (Rental.fromJson(entry))).toList();
        initData = true;
        print('orders: ${orders.length}');

        setState(() {
          if (orders.isNotEmpty) {
            // s = orders.first.startDate;
            // e = orders.last.endDate;
          }
        });
>>>>>>> 198779f503a9c07e7911ee93a0df3a35d4c83cc8
      });
   }
    catch( e,s)
    {
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

  filterByDate() {
    TextEditingController start = TextEditingController();
    TextEditingController end = TextEditingController();
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 600.h),
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
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: const Color(0xFFFB2576),
                                  size: 24.sp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('ממתי ?',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
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
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(15, 17, 21, 1),
                                    fontFamily: 'PLONI',
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(15, 17, 21, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(15, 17, 21, 1),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.w, horizontal: 20.h),
                                  suffixIcon: Icon(
                                    Icons.calendar_today_outlined,
                                    color:
                                        const Color.fromRGBO(251, 37, 118, 1),
                                    size: 22.sp,
                                  )),
                              //style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                              controller: start,
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.w300),
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    locale: const Locale("he", "HE"),
                                    textDirection: TextDirection.rtl,
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  start.text = intl.DateFormat('dd.MM.yyyy')
                                      .format(date);
                                  print('start: ${start.text}');
                                  s = date;
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('עד -',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
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
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(15, 17, 21, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(15, 17, 21, 1),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.w, horizontal: 20.h),
                                  suffixIcon: Icon(
                                    Icons.calendar_today_outlined,
                                    color:
                                        const Color.fromRGBO(251, 37, 118, 1),
                                    size: 22.sp,
                                  )),
                              style: TextStyle(fontSize: 22.sp),
                              controller: end,
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    locale: const Locale("he", "HE"),
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  end.text = intl.DateFormat('dd.MM.yyyy')
                                      .format(date);
                                  e = date;
                                }
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              height: 48.h,
                              width: 332.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(0, 222, 222, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: () => setState(() {}),
                                  child: const Text(
                                    'הצג',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Directionality(
                textDirection: TextDirection.ltr, child: AppBarBibilease()),
            SizedBox(height: 40.h),
            Text(
              'ההזמנות שלי',
              style: TextStyle(
                color: Color(0xFF0F1511),
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 40.h,),
             Container(
                      height: 48.h,
                      width: 332.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: initData&&User().currentRent!=null
                                ? turquoiseColorApp
                                : turquoiseColorApp.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 0.0,
                          ),
                          onPressed: initData&&User().currentRent!=null
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ActiveRentDetails(),
                                      ));
                                }
                              : null,
                          child: Text(
                            'הזמנה נוכחית',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    ),

            SizedBox(height: 67.h,),
            Row(
              children: [
                Text('הסטוריית הזמנות שלי:', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600,),),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'סנן לפי תאריך  ',
                          style: TextStyle(fontSize: 18.sp,color: blackColorApp),
                        ),
                        Icon(Icons.filter_alt_outlined,color: pinkColorApp,)
                      ],
                    ))
              ],
            ),
            SizedBox(height: 20.h,),
            initData ? orders.isNotEmpty
                    ? MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            Rental rent = orders[index];
                            if ((s==null || e==null) ||
                                (rent.startDate.isBefore(e!) ||
                                rent.startDate.compareTo(e!) == 0 ||
                                rent.endDate.isAfter(s!) == 0)) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetails(
                                          rent: rent,
                                        ),
                                      ));
                                },
                                child: Container(
                                  width: 332.w,
                                  height: 50.h,
                                  margin: EdgeInsets.only(bottom: 22.h,left: 30.w,right: 30.w),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 22.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          intl.DateFormat('dd.MM.yy')
                                              .format(rent.startDate),
                                          style: TextStyle(
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Spacer(),
                                        const Icon(
                                          Icons.file_download,
                                          color: Color(0xFFFB2576),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ))
                    : Text(
                        'אין הזמנות קיימות',
                        style: TextStyle(fontSize: 18.sp),
                      )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            Spacer(),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'חזרה לתפריט ראשי   ',
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
