import 'package:bblease/landspace_widget.dart';
import 'package:bblease/utils/my_colors.dart' ;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
//import 'package:universal_html/html.dart' as html;
import '../../models/class_rent.dart';
import 'package:intl/intl.dart' as intl;
import 'package:bblease/utils/download_helper.dart';

import '../../utils/common_funcs.dart';


//import 'dart:html';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
//import 'dart:io' if (dart.library.html) 'dart:html' as html;

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.rent});

  final Rental rent;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  late double rentPrice;
  late int dayDiff;
  double additionsPrice = 0;

  int isDownloaded = 0;


  @override
  void initState() {
    dayDiff = widget.rent.endDate.difference(widget.rent.startDate).inDays /*+ 1*/;
    // rentPrice = (widget.rent.car.pricePerDay) * (dayDiff == 0 ? 1 : dayDiff);
    rentPrice = widget.rent.car.totalPrice;
    debugPrint('totalPrice $rentPrice');
    if (widget.rent.additions != null && widget.rent.additions!.isNotEmpty) {
      calculateAdditionsPrice();
    }
    super.initState();
  }

  void calculateAdditionsPrice() {
    additionsPrice = 0;
    for (var item in widget.rent.additions!) {
      additionsPrice += item.price;
    }
  }

  void downloadFileWeb() {
    String url = widget.rent.url!;
    String fileName = 'bibilease.pdf';
    // if (kIsWeb) {
    //   final anchor = html.AnchorElement(href: url)
    //     ..setAttribute("download", fileName)
    //     ..click();
    // }

    downloadFile(url, fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:LandSpaceWidget(
            mainWidget: buildContent(),
            imageProperties: ImageProperties('image3.png', 1000.w,'תמונת מידע נוסף')));
  }

  buildContent() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonFuncs().getBackButton(context),
              //SizedBox(height: 30.h),
              Text(
                ' הסטוריית הזמנות > פירוט הזמנה ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                widget.rent.car.model,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold,
                  height: null,
                ),
              ),
              SizedBox(height: 7.h),
              widget.rent.car.carImages.isNotEmpty?   SizedBox(
                height: 130.h,
                width: 292.w,
                child: Image.network(
                    widget.rent.car.carImages.first, width: 290.w,
                    height: 126.h,
                    fit: BoxFit.fitWidth),
              ):Container(),
              SizedBox(height: 20.h),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: RawScrollbar(
                      thumbVisibility: true,
                    //  thumbColor: const Color(0xFF00DEDE),
                      thumbColor: const Color(0xFF000f50),
                      thickness: 3,
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView(
                            padding: EdgeInsets.only(left: 17.w, right: 11.w,),
                            shrinkWrap: true,
                            children: [
                              Stack(
                                children: [
                                  Center(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 720), // keeps layout sane on wide web
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 28.h),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF6F6F6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 33.w, left: 50.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 40.h),
                                              Row(
                                                children: [
                                                  Text('מספר הזמנה: ${widget.rent.orderNum} ',
                                                    style: TextStyle(
                                                      color: const Color(0xFF0F1511),
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    intl.DateFormat('dd.MM.yyyy')
                                                        .format(
                                                        widget.rent.startDate),
                                                    style: TextStyle(
                                                      color: const Color(0xFF0F1511),
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20.h,),
                                              Text(widget.rent.car.model,
                                                style: TextStyle(
                                                  color: const Color(0xFF0F1511),
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.bold,),),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text('מספר רכב',
                                                        style: TextStyle(
                                                          color: const Color(0xFF0F1511),
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight
                                                              .normal,),),
                                                      Text(widget.rent.car.carNumber
                                                          .toString(),
                                                        style: TextStyle(
                                                          color: const Color(0xFF0F1511),
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight
                                                              .bold,),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60.w,),
                                                  Column(
                                                    children: [
                                                      Text('קטגוריית רכב',
                                                        style: TextStyle(
                                                          color: const Color(0xFF0F1511),
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight
                                                              .normal,),),
                                                      Text(widget.rent.car.type,
                                                        style: TextStyle(
                                                          color: const Color(0xFF0F1511),
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight
                                                              .bold,),),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 20.h),
                                            ],
                                          ),
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
                                          Text('פרטי הזמנה', style: TextStyle(
                                            color: const Color(0xFF0F1511),
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.normal,),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.h),
                              Stack(
                                children: [
                                  Center(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 720), // keeps layout sane on wide web
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 28.h),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF6F6F6),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 30.w, left: 20.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 35.h),
                                              Row(
                                                children: [
                                                  Icon(Icons.fmd_good_outlined, color: const Color(0xFF0F1511), size: 20.w),
                                                  SizedBox(width: 9.w,),
                                                  Expanded(
                                                    child: Text(widget.rent.car.address,
                                                      style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        color: const Color(0xFF0F1511),
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.normal,),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15.h,),
                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_today_outlined, size: 20.w),
                                                  SizedBox(width: 16.w,),
                                                  Column(
                                                    children: [
                                                      Text(/*kIsWeb ?
                                                      " מ- ${intl.DateFormat('mm:HH yyyy.MM.dd').format(widget.rent.startDate)}":
                                                      */" מ- ${intl.DateFormat('dd.MM.yyyy HH:mm').format(widget.rent.startDate)}",
                                                        style: TextStyle(
                                                          color: const Color(0xFF0F1511),
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                        ),
                                                      ),
                                                      Text(/*kIsWeb ?
                                                      " עד- ${intl.DateFormat('mm:HH yyyy.MM.dd').format(widget.rent.endDate)}":
                                                      */" עד- ${intl.DateFormat('dd.MM.yyyy HH:mm').format(widget.rent.endDate)}",
                                                        style: TextStyle(
                                                          color: const Color(0xFF0F1511),
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],),
                                              SizedBox(height: 20.h,)
                                            ],
                                          ),
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
                                            Text('פרטי השכרה',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFF0F1511),
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: 30.h),
                              Stack(
                                children: [
                                  Center(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 720), // keeps layout sane on wide web
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 28.h),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF6F6F6),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 40.h),
                                              Row(
                                                children: [
                                                  Text('סך הכל לתשלום',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 24.sp),),
                                                  SizedBox(width: 40.w,),
                                                  Text(
                                                    '₪ ${rentPrice + additionsPrice}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 24.sp),
                                                  ),
                                                ],
                                              ),
                                              TextButton(
                                                  onPressed: () => paymentDetails(context),
                                                  child: Text('  פירוט התשלום >  ', style: TextStyle(fontSize: 18.sp)))
                                            ],
                                          ),
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
                                            Text('תשלום',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFF0F1511),
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: 25.h),
                              Container(
                                height: 48.h,
                                  width: double.infinity,
                                //width: 332.w,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: pinkColorApp,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),),
                                      elevation: 0.0,
                                    ),
                                    onPressed: () {
                                      if (kIsWeb) {
                                        downloadFileWeb();
                                        // Optionally, update UI immediately since web doesn't track download progress
                                        setState(() {
                                          isDownloaded = 2;

                                        });
                                      }
                                      else {
                                        FileDownloader.downloadFile(
                                          url: widget.rent.url!,
                                          onProgress: (fileName, progress) =>
                                              setState(() {
                                                isDownloaded = 1;
                                              }),
                                          onDownloadCompleted: (path) =>
                                              setState(() {
                                                isDownloaded = 2;
                                              }),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 27.w),
                                      child: Row(
                                        children: [
                                          if (isDownloaded == 0)
                                            Text('להורדה', style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),),
                                          if (isDownloaded == 1)
                                            Text('מוריד...', style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),),
                                          if (isDownloaded == 2)
                                            Text('ההורדה הושלמה',
                                              style: TextStyle(fontSize: 22.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white),),
                                          const Spacer(),
                                          buildDownloadIcon(),
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                height: 48.h,
                              //  width: 332.w,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: pinkColorApp,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),),
                                      elevation: 0.0,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 27.w),
                                      child: Row(
                                        children: [
                                          Text('חזרה לאזור המידע',
                                            style: TextStyle(fontSize: 22.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),),
                                          const Spacer(),
                                           Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.white,
                                            size: 20.sp,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
        )
    );
  }

  paymentDetails(context) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      barrierColor: Colors.black12.withOpacity(0.1),
      elevation: 2,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical
        (top: Radius.circular(25))),
      builder: (context) =>
          SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            minimum: EdgeInsets.only(bottom: 20.h),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: double.infinity,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 250,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      padding: EdgeInsets.only(left: 0.w, right: 0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('פירוט תשלום', style: TextStyle(fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),),
                              SizedBox(width: 9.w,),
                              Icon(Icons.credit_card, color: pinkColorApp, size: 24.sp),
                            ],
                          ),
                          SizedBox(height: 30.h),
                        Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: _paymentColumn([
                                    'השכרה ללא מע"מ',
                                    'תוספות',
                                    'מע”מ',
                                    'סך הכל',
                                  ], isLastPink: true),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _paymentColumn([
                                    '₪ ${(rentPrice * 0.82).round()}',
                                    '₪ $additionsPrice',
                                    '₪ ${(rentPrice * 0.18).round()}',
                                    '₪ ${rentPrice + additionsPrice}',
                                  ], bold: true),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: _paymentColumn([
                                    'תקופת ההשכרה',
                                    'תוספות',
                                    'תוספת 17%',
                                    'תשלום כולל מע”מ',
                                  ], isLastPink: true),
                                ),
                              ],
                            ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _paymentColumn(
      List<String> items, {
        bool bold = false,
        bool isLastPink = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final isLast = index == items.length - 1;

        return Padding(
          padding: EdgeInsets.only(bottom: index == items.length - 1 ? 0 : 17.h),
          child: Text(
            items[index],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp.clamp(18.0, 22.0),
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: isLastPink && isLast ? pinkColorApp : blackColorApp,
            ),
          ),
        );
      }),
    );
  }

  Widget buildDownloadIcon() {
    if (isDownloaded == 1) {
      return SizedBox(
        height: 20.sp.clamp(18.0, 24.0),
        width: 20.sp.clamp(18.0, 24.0),
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    }

    if (isDownloaded == 2) {
     return  Icon(
          Icons.check_circle_outline,
          color: Colors.white,
          size: 20.sp
      );
    }

    return Icon(
      Icons.download,
      color: Colors.white,
      size: 26.sp.clamp(22.0, 28.0),
    );
  }
}

