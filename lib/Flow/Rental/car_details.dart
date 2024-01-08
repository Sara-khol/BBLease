import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import '../../customWidgets/appBarB.dart';
import '../../models/additions.dart';
import '../../models/car.dart';
import '../../models/class_rent.dart';

import 'package:intl/intl.dart' as intl;
import 'package:carousel_slider/carousel_slider.dart';

import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../../utils/my_colors.dart';
import 'dialogs.dart';


class CarDetails extends StatefulWidget {
  /*final Car selectedCar;
  final DateTime? startDate;
  final DateTime? endDate;*/
  final Rental rent;



  CarDetails({super.key, required this.rent,});

  @override
  State<StatefulWidget> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  //late Car carDetails;
  double price = 0;
  late int rentPrice;
  late int dayDiff;


  void calculatePrice() {
    for (var item in widget.rent.additions) {
      if (item.isChecked)
        price += item.price;
    }
  }

  @override
  void initState() {
    debugPrint('widget.rent.car.pricePerDay ${widget.rent.car.pricePerDay}');
    dayDiff = widget.rent.startDate!.difference(widget.rent.endDate!).inDays;
    rentPrice = (widget.rent.car.pricePerDay) *
        (dayDiff==0?1:dayDiff);
    debugPrint('rentPrice $rentPrice');
    calculatePrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.rtl,
          child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32.h),
                const Directionality(
                    textDirection: TextDirection.ltr, child: AppBarBibilease()),
                SizedBox(height: 50.h),
                Text(widget.rent.car.model, //carDetails.postName,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: colors.blackColorApp,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    height: null,
                  ),
                ),
                Text('רכב זה זמין רק בחיבור לאפליקציה',
                  style: TextStyle(
                    color: colors.blackColorApp,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    height: null,
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  height: 130.h,
                  width: 292.w,
                  child: CarouselSlider(
                      items: [
                        Image.asset('assets/images/car-only.png', width: 290.w,
                          height: 126.h,),
                      ],
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        reverse: true,
                      )),
                ),
                Stack(children: [
                  Image.asset('assets/images/Ellipse.png', width: 232.w,
                      height: 35.5.h),
                ],),
                SizedBox(height: 40.h),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: RawScrollbar(
                        thumbVisibility: true,
                        thumbColor: colors.turquoiseColorApp,
                        thickness: 3,
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView(
                              padding: EdgeInsets.only(
                                left: 17.w, right: 11.w,),
                              shrinkWrap: true,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 355.w,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              25),),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 30.w, left: 30.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(height: 41.h),
                                            Text(widget.rent.car.model,
                                                style: TextStyle(
                                                  color: colors.blackColorApp,
                                                  fontSize: 34.sp,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.15,)),
                                            Text('או רכב זהה', style: TextStyle(
                                              color: colors.blackColorApp,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w400,
                                              height: 1.15,)),
                                            Text('ללא הגבלת ק”מ',
                                              style: TextStyle(
                                                color: colors.blackColorApp,
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w600,
                                                height: 1.15,),),
                                            SizedBox(height: 25.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(Icons.chair_outlined,
                                                      color: colors
                                                          .pinkColorApp,),
                                                    SizedBox(height: 10.h),
                                                    Text('${widget.rent.car
                                                        .seats} מושבים',
                                                        style: TextStyle(
                                                          color: colors
                                                              .blackColorApp,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight
                                                              .w400,))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(Icons
                                                        .sensor_door_outlined,
                                                      color: colors
                                                          .pinkColorApp,),
                                                    SizedBox(height: 10.h),
                                                    Text('${widget.rent.car
                                                        .doors} דלתות',
                                                      style: TextStyle(
                                                        color: colors
                                                            .blackColorApp,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight
                                                            .w400,),
                                                    )
                                                  ],
                                                ),
                                                widget.rent.car.autoGeer
                                                    ? Column(
                                                  children: [
                                                    Icon(
                                                      Icons.hdr_auto_outlined,
                                                      color: colors
                                                          .pinkColorApp,),
                                                    SizedBox(height: 10.h),
                                                    Text('אוטומטי',
                                                      style: TextStyle(
                                                        color: colors
                                                            .blackColorApp,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight
                                                            .w400,),
                                                    )
                                                  ],
                                                )
                                                    : Column(
                                                  children: [
                                                    Icon(
                                                      Icons.flash_on_outlined,
                                                      color: colors
                                                          .pinkColorApp,),
                                                    SizedBox(height: 10.h),
                                                    Text('ידני',
                                                      style: TextStyle(
                                                        color: colors
                                                            .blackColorApp,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight
                                                            .w400,),
                                                    )
                                                  ],
                                                ),
                                                if(widget.rent.car.type ==
                                                    'היברידי')Column(
                                                  children: [
                                                    Icon(Icons
                                                        .electrical_services_outlined,
                                                      color: colors
                                                          .pinkColorApp,),
                                                    SizedBox(height: 10.h),
                                                    Text('היברידי',
                                                      style: TextStyle(
                                                        color: colors
                                                            .blackColorApp,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight
                                                            .w400,),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
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
                                            borderRadius: BorderRadius.circular(
                                                25),),
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
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Text('פרטי הרכב',
                                              style: TextStyle(
                                                color: colors.blackColorApp,
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w400,),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Stack(
                                  children: [
                                    Container(
                                      width: 355.w,
                                      //height: 260.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              25),
                                        ),
                                      ),
                                      child: Padding(padding: EdgeInsets.only(
                                          right: 30.w, left: 20.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                Icon(Icons.fmd_good_outlined,
                                                    color: colors.blackColorApp,
                                                    size: 20.w),
                                                SizedBox(width: 9.w,),
                                                Text(widget.rent.car.city,
                                                  style: TextStyle(
                                                    color: colors.blackColorApp,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight
                                                        .w400,),),
                                                Spacer(),
                                                IconButton(
                                                  icon: ImageIcon(AssetImage(
                                                      "assets/images/edit.png"),
                                                    size: 20.sp,
                                                    color: colors
                                                        .turquoiseColorApp,),
                                                  onPressed: () {
                                                    //TODO: onPressed
                                                  },
                                                ),
                                              ],
                                            ),
                                            //SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: colors.blackColorApp,
                                                  size: 20.w,),
                                                SizedBox(width: 9.w,),
                                                Text('${intl.DateFormat(
                                                    'dd.MM.yyyy').format(
                                                    widget.rent
                                                        .startDate!)} - ${intl
                                                    .DateFormat('dd.MM.yyyy')
                                                    .format(
                                                    widget.rent.endDate!)}',
                                                  style: TextStyle(
                                                    color: colors.blackColorApp,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight
                                                        .w400,),),
                                                Spacer(),
                                                IconButton(
                                                  icon: ImageIcon(AssetImage(
                                                      "assets/images/edit.png"),
                                                    size: 20.sp,
                                                    color: colors
                                                        .turquoiseColorApp,),
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context), //TODO: onPressed
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 18.h),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text('כולל', style: TextStyle(
                                                  color: colors.blackColorApp,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.15,),),
                                                Row(
                                                  children: [
                                                    Icon(Icons.check,
                                                      color: colors
                                                          .turquoiseColorApp,),
                                                    SizedBox(width: 9.w,),
                                                    Text('ביטוח',
                                                      style: TextStyle(
                                                        color: colors
                                                            .blackColorApp,
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight
                                                            .w400,),),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.check,
                                                      color: colors
                                                          .turquoiseColorApp,),
                                                    SizedBox(width: 9.w,),
                                                    Text('ללא הגבלת קילומטרים',
                                                      style: TextStyle(
                                                        color: colors
                                                            .blackColorApp,
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight
                                                            .w400,),),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.check,
                                                      color: colors
                                                          .turquoiseColorApp,),
                                                    SizedBox(width: 9.w,),
                                                    Text('השתתפות עצמית בנזקים',
                                                      style: TextStyle(
                                                        color: colors
                                                            .blackColorApp,
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight
                                                            .w400,),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h,)
                                          ],
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
                                              borderRadius: BorderRadius
                                                  .circular(25),),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x33A7A7A7),
                                                blurRadius: 40,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,)
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text('פרטי השכרה',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: colors.blackColorApp,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight
                                                      .w400,),),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Stack(
                                  children: [
                                    Container(
                                      width: 355.w,
                                      //height: 265.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 10.h),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: widget.rent.additions
                                              .length,
                                          itemBuilder: (context, index) {
                                            if (widget.rent.additions[index]
                                                .isChecked) {
                                              return createExtra(index);
                                            }
                                            return SizedBox();
                                          },
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
                                              borderRadius: BorderRadius
                                                  .circular(25),),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x33A7A7A7),
                                                blurRadius: 40,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,)
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text('תוספות',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: colors.blackColorApp,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight
                                                      .w400,),),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 33.h),
                                Stack(
                                  children: [
                                  /*  Container(
                                      width: 355.w,
                                      //height: 265.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 10.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(height: 40.h),
                                            Text(
                                              'סך הכל לתשלום       ${(rentPrice +
                                                  price) * 0.17} ₪',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 22.sp),),
                                            SizedBox(height: 7.h),
                                            Text('פירוט התשלום',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.sp),),
                                            SizedBox(height: 10.h),
                                            Container(
                                              //height: 68.h,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFEFFFFE),
                                                  borderRadius: BorderRadius
                                                      .circular(8)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 30.w, right: 30.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    SizedBox(height: 30.h,),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text('השכרה',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text('תוספות',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text('מע”מ',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text('סך הכל',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                        SizedBox(width: 50.h),
                                                        Column(
                                                          children: [
                                                            Text('₪ $rentPrice',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text('₪ $price',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text(
                                                                '₪ ${(rentPrice +
                                                                    price) *
                                                                    0.17}',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text(
                                                                '₪ ${(rentPrice +
                                                                    price) *
                                                                    0.17}',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                        SizedBox(width: 50.h),
                                                        Column(
                                                          children: [
                                                            Text('${widget.rent
                                                                .startDate!
                                                                .difference(
                                                                widget.rent
                                                                    .endDate!)
                                                                .inDays} ימים * ${widget
                                                                .rent.car
                                                                .pricePerDay} ליום',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w500,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text('מחיר כולל',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w500,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text('תוספת 17%',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w500,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(height: 17
                                                                .h),
                                                            Text(
                                                                'תשלום כולל מע”מ',
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w500,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        )

                                                      ],
                                                    ),
                                                    SizedBox(height: 15.h,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 12.h),
                                            Text(
                                              'התשלום יגבה אוטמטית באמצעות מערכת הסליקה ממספר אשראי שמופיע במערכת על שמך',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.sp),),
                                            SizedBox(height: 20.h),

                                          ],
                                        ),
                                      ),
                                    ),*/
                                    Container(
                                      width: 355.w,
                                      //height: 265.h,
                                      margin: EdgeInsets.only(top: 13.h),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 40.h),
                                            Text(
                                                // 'סך הכל לתשלום       ${widget.rent.car.pricePerDay * (dayDiff == 0 ? 1 : dayDiff)} ₪',
                                                'סך הכל לתשלום       ${((rentPrice + price) * 0.17+(rentPrice + price)).round()} ₪',
                                              // ' ${((rentPrice+price)*1.17).round()} ₪'
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 22.sp)),
                                            SizedBox(height: 7.h),
                                            Text(
                                              'פירוט התשלום',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.sp),
                                            ),
                                            SizedBox(height: 10.h),
                                            Container(
                                              //height: 68.h,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFEFFFFE),
                                                  borderRadius:
                                                  BorderRadius.circular(8)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0.w, right: 0.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 30.h,
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text('השכרה',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text('תוספות',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text('מע”מ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text('סך הכל',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,color:pinkColorApp))
                                                          ],
                                                        ),
                                                        // SizedBox(width: 25.h),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                // '${widget.rent.car.pricePerDay * (dayDiff==0?1:dayDiff)} ₪',
                                                        '₪ $rentPrice',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text('₪ $price',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text(  '₪ ${((rentPrice +
                                                                price) *
                                                                0.17).round()}',
                                                                style: TextStyle(
                                                                    fontSize: 18.sp, fontWeight: FontWeight.w700)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text( '₪ ${(rentPrice +
                                                                price)+((rentPrice +
                                                                price) *
                                                                0.17).round()}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,color:pinkColorApp)),
                                                          ],
                                                        ),
                                                        // SizedBox(width: 20.h),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                '${dayDiff==0?1:0} ימים * ${widget.rent.car.pricePerDay} ליום',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text('תוספות',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text('תוספת 17%',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,
                                                                    fontWeight: FontWeight.w500)),
                                                            SizedBox(
                                                                height: 17.h),
                                                            Text('תשלום כולל מע”מ',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18.sp,
                                                                    fontWeight: FontWeight.w500,color:pinkColorApp)),
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
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.sp),
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
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
                                              borderRadius: BorderRadius
                                                  .circular(25),),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x33A7A7A7),
                                                blurRadius: 40,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,)
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text('תשלום',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: colors.blackColorApp,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight
                                                      .w400,),),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25.h,),
                                SizedBox(
                                  height: 48.h,
                                  width: 332.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colors
                                            .turquoiseColorApp,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              100),
                                        ),
                                      ),
                                      onPressed: () {
                                        Map<String,bool> additionsMap={};

                                        for(Addition addition in widget.rent.additions)
                                          {
                                            additionsMap[addition.name]=addition.isChecked;
                                          }
                                        Map<String, dynamic> map = {
                                          'phone-number': User().phoneNumber,
                                          'car-number': widget.rent.car.carNumber,
                                          'start_date':
                                          intl.DateFormat('dd/MM/yyyy')
                                              .format(widget.rent.startDate),
                                          'end_date':
                                          intl.DateFormat('dd/MM/yyyy')
                                              .format(widget.rent.endDate),
                                          'extra':additionsMap
                                        };
                                        showLoading(context);
                                        ApiService().newOrder(map, (res) {
                                          Navigator.pop(context);
                                            displayMessage(context,message: 'ההזמנה התקבלה בהצלחה',onClose: (){
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>  HomePage()),
                                                      (route) => false);
                                            });
                                        } );
                                      },
                                      child: Text(
                                        'לתשלום',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ),
                                SizedBox(height: 30.h,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ])
      ),
    );
  }

  Widget createExtra(index){
    return Container(
      //height: 68.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w/*,right: 20.w*/,top: 10.h,bottom: 10.h),
        child: Row(
          children: [
            IconButton(onPressed: () {},
                icon: Icon(Icons.close,color: colors.pinkColorApp)),
            Expanded(child: Text(widget.rent.additions[index].title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18.sp))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.check,color: colors.turquoiseColorApp,size: 21.sp,),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Text('${widget.rent.additions[index].price} ₪ ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                    Text('ליום',style: TextStyle(fontSize: 16.sp),),
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
