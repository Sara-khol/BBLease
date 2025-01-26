import 'dart:ui';

import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/UserInformation/ordersHistory.dart';
import 'package:bblease/landspace_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bblease/utils/my_colors.dart';
import '../../customWidgets/appBarB.dart';
import '../../models/additions.dart';
import '../../models/class_rent.dart';
import 'package:intl/intl.dart' as intl;
//import 'package:carousel_slider/carousel_slider.dart';
import '../../models/class_user.dart';
import '../../services/api_service.dart';
import 'dialogs.dart';

class CarDetails extends StatefulWidget {
  /*final Car selectedCar;
  final DateTime? startDate;
  final DateTime? endDate;*/
  final Rental rent;

  const CarDetails({
    super.key,
    required this.rent,
  });

  @override
  State<StatefulWidget> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  //late Car carDetails;
  double additionsPrice = 0;
  late int rentPrice;
  late int dayDiff;

  void calculateAdditionsPrice() {
    additionsPrice = 0;
    for (var item in widget.rent.additions!) {
      if (item.isChecked) additionsPrice += item.price;
    }
  }

  @override
  void initState() {
    debugPrint('widget.rent.car.pricePerDay ${widget.rent.car.pricePerDay}');
    dayDiff = widget.rent.endDate.difference(widget.rent.startDate).inDays/* + 1*/;
    rentPrice = (widget.rent.car.pricePerDay) * (dayDiff == 0 ? 1 : dayDiff);
    debugPrint('rentPrice $rentPrice');
    calculateAdditionsPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:OrientationBuilder(
        builder: (context,orientation) {
          return orientation==Orientation.landscape?
          LandSpaceWidget(
              mainWidget: buildContent(orientation),
              imageProperties: ImageProperties('image6.png', 1000.w,'תמונה בהצלחה'),
              ):
          buildContent(orientation);
  }));
  }

  buildContent(Orientation o) {
    //print(' additions length ${widget.rent.additions!.length}');

    final controller = ScrollController();

    return  Directionality(
        textDirection: TextDirection.rtl,
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
         if(o==Orientation.portrait) const Directionality(textDirection: TextDirection.ltr, child: AppBarBibilease()),
          SizedBox(height: 30.h),
          Text(
            widget.rent.car.postName, //carDetails.postName,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: blackColorApp,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              height: null,
            ),
          ),

          SizedBox(height: 30.h),
          if (widget.rent.car.carImages.isNotEmpty)
            SizedBox(
              height: 130.h,
              width: 292.w,
              child: Image.network(widget.rent.car.carImages.first)
              // CarouselSlider(
              //     items: widget.rent.car.carImages.map((i) {
              //       return Image.network(i, width: 290.w);
              //     }).toList(),
              //     options: CarouselOptions(
              //       enlargeCenterPage: true,
              //       autoPlay: false,
              //       enableInfiniteScroll: false,
              //       reverse: true,
              //       padEnds: true,
              //     )
              // ),
            ),
          Image.asset('assets/images/Ellipse.png',semanticLabel: 'אליפסה קוקוים',),
          SizedBox(height: 40.h),
          Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: RawScrollbar(
                      thumbColor: turquoiseColorApp,
                      controller: controller,
                      trackVisibility: true,
                      thickness: 4,
                      thumbVisibility: true,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false,dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse,}),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView(
                            //primary: true,
                            controller: controller,
                            padding: EdgeInsets.only(left: 17.w, right: 11.w,),
                            shrinkWrap: true,
                            children: [
                              Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 355.w,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 30.w, left: 30.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 41),
                                            Text(widget.rent.car.postName,
                                                style: TextStyle(
                                                  color: blackColorApp,
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.15,
                                                )),
                                            Text(
                                              '200 ק"מ',
                                              style: TextStyle(
                                                color: blackColorApp,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                height: 1.15,
                                              ),
                                            ),
                                            SizedBox(height: 25.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(Icons.chair_outlined, color: pinkColorApp,),
                                                    SizedBox(height: 10.h),
                                                    Text('${widget.rent.car.seats} מושבים',
                                                        style: TextStyle(
                                                          color: blackColorApp,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.normal,
                                                        ))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(
                                                      Icons.sensor_door_outlined,
                                                      color: pinkColorApp,
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Text(
                                                      '${widget.rent.car.doors} דלתות',
                                                      style: TextStyle(
                                                        color: blackColorApp,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                /* widget.rent.car.autoGeer
                                                      ? Column(
                                                          children: [
                                                            Icon(
                                                              Icons.hdr_auto_outlined,
                                                              color:
                                                                  pinkColorApp,
                                                            ),
                                                            SizedBox(height: 10.h),
                                                            Text(
                                                              'אוטומטי',
                                                              style: TextStyle(
                                                                color: colors
                                                                    .blackColorApp,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight.normal,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Column(
                                                          children: [
                                                            Icon(
                                                              Icons.flash_on_outlined,
                                                              color:
                                                                  pinkColorApp,
                                                            ),
                                                            SizedBox(height: 10.h),
                                                            Text(
                                                              'ידני',
                                                              style: TextStyle(
                                                                color: colors
                                                                    .blackColorApp,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight.normal,
                                                              ),
                                                            )
                                                          ],
                                                        ),*/
                                                if (widget.rent.car.type == 'היברידי')
                                                  Column(
                                                    children: [
                                                      Icon(Icons.electrical_services_outlined, color: pinkColorApp,),
                                                      SizedBox(height: 10.h),
                                                      Text('היברידי',
                                                        style: TextStyle(
                                                          color: blackColorApp,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 6.h),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
                                        shadows: const [
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
                                              color: blackColorApp,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 355.w,
                                      //height: 260.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 30.w, left: 20.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 41),
                                            Row(
                                              children: [
                                                Icon(Icons.fmd_good_outlined, color: blackColorApp, size: 20.w),
                                                SizedBox(width: 9.w,),
                                                Text(
                                                  widget.rent.car.address,
                                                  style: TextStyle(
                                                    color: blackColorApp,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                const ImageIcon(AssetImage("assets/icons/Calendar.png"),),
                                                SizedBox(
                                                  width: 9.w,
                                                ),
                                                Text(
                                                  /*kIsWeb?
                                                  '${intl.DateFormat('mm:HH yyyy.MM.dd').format(widget.rent.startDate!)} - ${intl.DateFormat('mm:HH yyyy.MM.dd').format(widget.rent.endDate!)}':
                                                  */'${intl.DateFormat('dd.MM.yyyy HH:mm').format(widget.rent.startDate)} - ${intl.DateFormat('dd.MM.yyyy HH:mm').format(widget.rent.endDate)}',
                                                  style: TextStyle(
                                                    color: blackColorApp,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                            SizedBox(height: 18.h),

                                            SizedBox(height: 20.h,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 6.h),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          shadows: const [
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
                                                color: blackColorApp,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Visibility(visible: additionsPrice>0, child: SizedBox(height: 20.h)),
                              Visibility(
                                visible: additionsPrice>0,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 355.w,
                                        //height: 265.h,
                                        margin: EdgeInsets.only(top: 13.h),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF6F6F6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 10.h, top: 20.h),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: widget.rent.additions!.length,
                                            itemBuilder: (context, index) {
                                              if (widget.rent.additions![index].isChecked) {
                                                return createExtra(index, widget.rent.additions![index].name != 'new_driver' &&widget.rent.additions![index].name != 'young_driver');
                                              }
                                              return const SizedBox();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(25),
                                            ),
                                            shadows: const [
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
                                                'תוספות',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: blackColorApp,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 33.h),
                              Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 355.w,
                                      //height: 265.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 41),
                                            Text('סך הכל לתשלום     ${rentPrice + additionsPrice} ₪', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                                            SizedBox(height: 7.h),
                                            Text('פירוט התשלום', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.sp),),
                                            SizedBox(height: 10.h),
                                            Container(
                                              decoration: BoxDecoration(color: const Color(0xFFEFFFFE), borderRadius: BorderRadius.circular(8)),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 0.w, right: 0.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(height: 30.h,),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('השכרה',style: TextStyle(fontSize: 16.sp)),
                                                            SizedBox(height: 17.h),
                                                            Text('תוספות', style: TextStyle(fontSize: 16.sp)),
                                                            SizedBox(height: 17.h),
                                                            Text('מע”מ', style: TextStyle(fontSize: 16.sp)),
                                                            SizedBox(height: 17.h),
                                                            Text('סך הכל', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.sp, color: pinkColorApp))
                                                          ],
                                                        ),
                                                        // SizedBox(width: 25.h),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('₪ ${(rentPrice*0.83).round()}', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold)),
                                                            SizedBox(height: 17.h),
                                                            Text('₪ ${(additionsPrice*0.83).round()}',style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                                            SizedBox(height: 17.h),
                                                            Text('₪ ${((rentPrice + additionsPrice) * 0.17).round()}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                                            SizedBox(height: 17.h),
                                                            Text('₪ ${(rentPrice + additionsPrice)}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: pinkColorApp)),
                                                          ],
                                                        ),
                                                        // SizedBox(width: 20.h),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('${dayDiff == 0 ? 1 : dayDiff} ימים ללא מע"מ ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal)),
                                                            SizedBox(height: 17.h),
                                                            Text('תוספות', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal)),
                                                            SizedBox(height: 17.h),
                                                            Text('תוספת מע"מ 17%', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal)),
                                                            SizedBox(height: 17.h),
                                                            Text('תשלום כולל מע”מ', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: pinkColorApp)),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 12.h),
                                            Text(
                                              'התשלום יגבה אוטמטית באמצעות מערכת הסליקה ממספר אשראי שמופיע במערכת על שמך',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.sp),
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 6.h),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(25),
                                          ),
                                          shadows: const [
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
                                              'תשלום',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: blackColorApp,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              SizedBox(
                                height: 48.h,
                                width: 332.w,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: turquoiseColorApp,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {
                                      // User().currentRent = widget.rent;
                                      Map<String, bool> additionsMap = {};

                                      for (Addition addition in widget.rent.additions!) {
                                        additionsMap[addition.name] = addition.isChecked;
                                      }
                                      Map<String, dynamic> map = {
                                        'phone-number': User().phoneNumber,
                                        'car-number': widget.rent.car.carNumber,
                                        'start_date': intl.DateFormat('yyyy-MM-dd').format(widget.rent.startDate),
                                        'end_date': intl.DateFormat('yyyy-MM-dd').format(widget.rent.endDate),
                                        'extra': additionsMap,
                                        'start-hour':intl.DateFormat('HH:mm').format(widget.rent.startDate),
                                        'end-hour':intl.DateFormat('HH:mm').format(widget.rent.endDate),
                                      };
                                      print(map);
                                      showLoading(context);
                                      ApiService().newOrder(map, (res) {
                                        //widget.rent.orderNum=res;
                                        //User().currentRent=widget.rent;
                                        Navigator.pop(context);
                                        displayMessage(context,
                                            message: 'ההזמנה התקבלה בהצלחה',
                                            onClose: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const OrdersHistory(index: 2,goBack: false,)),
                                                      (route) => false);
                                            });
                                      });
                                    },
                                    child: Text(
                                      'לתשלום',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

        ]));
  }

  Widget createExtra(index, bool showRemove) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w /*,right: 20.w*/, top: 10.h, bottom: 10.h),
        child: Row(
          children: [
            Visibility(
              visible: showRemove,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: IconButton(
                  onPressed: () {
                    displayQuestion1(context,
                        header: 'פעולה זו תבטל לך את התוספת של',
                        message: ' ${widget.rent.additions![index].title} בסך ${widget.rent.additions![index].price} ש"ח ',
                        onYes: () {
                      widget.rent.additions![index].isChecked = false;
                      calculateAdditionsPrice();
                      setState(() {});
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(Icons.close, color: pinkColorApp)),
            ),
            Expanded(
                child: Text(widget.rent.additions![index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.check, color: turquoiseColorApp, size: 21.sp,),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Text('${widget.rent.additions![index].price} ₪ ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
                    if(!widget.rent.additions![index].title.contains("50")) Text('ליום', style: TextStyle(fontSize: 16.sp),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
