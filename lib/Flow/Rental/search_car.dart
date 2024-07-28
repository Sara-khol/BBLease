import 'dart:async';

import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/landspace_widget.dart';
import 'package:bblease/models/car.dart';
import 'package:bblease/models/class_rent.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:bblease/Flow/Rental/car_details.dart';

import '../../models/additions.dart';
import '../../models/class_user.dart';
import 'additions_dialog.dart';

class SearchCar extends StatefulWidget {
  SearchCar(
      {super.key,
      required this.location,
      required this.latitude,
      required this.longitude,
      this.startDate,
      this.endDate, required this.index});

  final String location;
  final int index;
  final double? latitude;
  final double? longitude;
  DateTime? startDate;
  DateTime? endDate;

  @override
  State<SearchCar> createState() => _SearchCarState();
}

class _SearchCarState extends State<SearchCar> {
  List<Car> cars = [];
  Map<String, List<Car>> filteredCarsMap = {};

  final _scrollController = ScrollController();
  bool showProgressIndicator = true;

  Rental rent = Rental();
  bool isTapped = false;

  double currentSliderValue = 3;
  String type = 'all';
  late Future myFuture ;



  @override
  void initState() {
    if(widget.index==0)mapController.dispose();
    rent.startDate = widget.startDate!;
    rent.endDate = widget.endDate!;
   myFuture= getCarsList();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getCarsList() async {
    String start = intl.DateFormat('yyyy-MM-dd').format(widget.startDate!);
    String end = intl.DateFormat('yyyy-MM-dd').format(widget.endDate!);
    String timef = intl.DateFormat('HH:mm').format(widget.startDate!);
    String timet = intl.DateFormat('HH:mm').format(widget.endDate!);
    await ApiService().getCarsAround(
        start,
        end,
        widget.latitude!,
        widget.longitude!,
        currentSliderValue.toInt() * 10,
        timef,
        timet, (car) {
      cars = car.map<Car>((entry) => (Car.fromJson(entry))).toList();
      setState(() {});
      createMap();
    });
  }

  createMap() {
    filteredCarsMap['all'] = cars;
    for (var car in cars) {
      if (filteredCarsMap.containsKey(car.type)) {
        filteredCarsMap[car.type]!.add(car);
      } else {
        filteredCarsMap[car.type] = [car];
      }
    }
  }

  //int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: orientation == Orientation.landscape
            ? LandSpaceWidget(
                mainWidget: buildContent(orientation),
                imageProperties: ImageProperties('l_search_car.jpg', 618.w),
                showAppBar: true)
            : buildContent(orientation),
      );
    });
  }

  buildContent(Orientation orientation) {
    debugPrint('currentSliderValue $currentSliderValue');
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              if (orientation == Orientation.portrait)
                Directionality(
                    textDirection: TextDirection.ltr, child: AppBarBibilease()),
              SizedBox(height: 40.h),
              Text(
                'הי, מצאנו באזורך ${cars.length} רכבים',
                style: TextStyle(
                  color: blackColorApp,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                '${widget.location}  ${intl.DateFormat('dd.MM.yy').format(widget.startDate!)} ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  height: 1.15,
                ),
              ),
              SizedBox(height: 26.h), //26
              topButtons(context),
              SizedBox(height: 23.h), //23
              cars.isNotEmpty
                  ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: type == 'all'
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: cars.length,
                                itemBuilder: (context, index) {
                                  Car car = cars[index];
                                  //bool isHovered = _hoveredIndex == index;
                                  return /*MouseRegion(
                                                onEnter: (_) {
                                                  print('enter to index $index');
                                                  setState(() {
                                                        _hoveredIndex = index;
                                                  });
                                                },
                                                onExit: (_) {
                                                  print('exit from index $index');
                                                  setState(() {
                                                        _hoveredIndex = null;
                                                  });
                                                },
                                                child:*/
                                      searchCarItem(car, orientation);
                                },
                              ),
                            )
                          : filteredCarsMap[type] != null
                              ? Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filteredCarsMap[type]!.length,
                                    itemBuilder: (context, index) {
                                      Car car = filteredCarsMap[type]![index];
                                      return searchCarItem(car, orientation)
                                          /*GestureDetector(
                                        onTap: () async {
                                          */ /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CarDetails(car,startDate: widget.startDate,endDate: widget.endDate,))
                        ),*/
                                          /*
                                          await ApiService().getAdditions(
                                              car.id,
                                              widget.startDate,
                                              widget.endDate, (orderJson) {
                                            List<Addition> additions = [];
                                            additions = orderJson
                                                .map<Addition>((entry) =>
                                                    (Addition.fromJson(entry)))
                                                .toList();
                                            for (Addition item in additions) {
                                              if (item.name == 'new_driver' ||
                                                  item.name == 'young_driver') {
                                                item.isEnabled = false;
                                                if (item.name == 'new_driver' &&
                                                        User().isNewDriver ||
                                                    item.name ==
                                                            'young_driver' &&
                                                        User().isYoungDriver) {
                                                  item.isChecked = true;
                                                }
                                              }
                                            }
                                            setState(() {});
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              isDismissible: false,
                                              backgroundColor: Colors.white,
                                              barrierColor: Colors.black12
                                                  .withOpacity(0.1),
                                              //isDismissible: false,
                                              elevation: 2,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            25)),
                                              ),
                                              context: context,
                                              builder: (_) => AdditionsDialog(
                                                  rent: rent,
                                                  car: car,
                                                  additionsList: additions),
                                            );
                                            //extras(context,car,widget.startDate,widget.endDate,additions,rent);
                                          });
                                        },
                                        child: Container(
                                          width:orientation==Orientation.portrait? 347.w:200.w,
                                          height: 152.h,
                                          margin: EdgeInsets.only(
                                            right: 23.w,
                                            left: 23.w,
                                            bottom: 12.h,
                                          ),
                                          child: Stack(
                                            children: [
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                shadowColor: Colors.transparent,
                                                margin:
                                                    EdgeInsets.only(left: 20.w),
                                                color: Color(0xffF7F7F7),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.h,
                                                      top: 10.h,
                                                      right: 14.w,
                                                      left: 11.w),
                                                  child: IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              car.postName.length >
                                                                      12
                                                                  ? '${car.postName.substring(0, 12)}...'
                                                                  : '${car.postName}',
                                                              style: TextStyle(
                                                                fontSize: 34.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                height: 1,
                                                              ),
                                                            ),
                                                            Text(
                                                              'או רכב זהה',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                height: 1.15,
                                                              ),
                                                            ),
                                                            Text(
                                                              car.address,
                                                              style: TextStyle(
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                height: 1.15,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: SizedBox(
                                                                    height:
                                                                        29.h)),
                                                            Text(
                                                              '${car.pricePerDay} ₪  |  ליום',
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                height: 1.15,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${car.pricePerDay * widget.endDate!.difference(widget.startDate!).inDays} ₪  |  סה"כ',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                height: 1.15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 2.h),
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Icon(
                                                                  Icons.circle,
                                                                  color:
                                                                      turquoiseColorApp,
                                                                  size: 8.w,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (car.carImages.isNotEmpty)
                                                Positioned.fill(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.h),
                                                      child: Image.network(
                                                        car.carImages.first,
                                                        width: 175.w,
                                                        height: 75.h,
                                                      )),
                                                )),
                                            ],
                                          ),
                                        ),
                                      )*/
                                          ;
                                    },
                                  ),
                                )
                              : Text('לא נמצאו תוצאות עבור: ${type}'),
                    )
                  : Center(
                      child: FutureBuilder(
                        future: myFuture,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // If the Future is still running, show the progress indicator
                            return CircularProgressIndicator(
                              color: pinkColorApp,
                            );
                          } else {
                            // If the Future is complete, update the UI accordingly
                            return Text('לא נמצאו רכבים באזורך');
                          }
                        },
                      ),
                    ),
            ]),
            Align(
                alignment: Alignment.bottomCenter,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                  child: Container(
                    width: 124,
                    height: 397,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.00, -0.00),
                        end: Alignment(1, 0),
                        colors: [Colors.white, Colors.white.withOpacity(0)],
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }

  searchCarItem(Car car, Orientation orientation) {
    return GestureDetector(
      onTap: () async {
        showLoading(context);
        await ApiService().getAdditions(
            car.id, widget.startDate, widget.endDate, (orderJson) {
          Navigator.pop(context);
          List<Addition> additions = [];
          additions = orderJson
              .map<Addition>((entry) => (Addition.fromJson(entry)))
              .toList();
          for (Addition item in additions) {
            if (item.name == 'new_driver' || item.name == 'young_driver') {
              item.isEnabled = false;
              if (item.name == 'new_driver' && User().isNewDriver ||
                  item.name == 'young_driver' && User().isYoungDriver) {
                item.isChecked = true;
              }
            }
          }
          //setState(() {});
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            barrierColor: Colors.black12.withOpacity(0.1),
            backgroundColor: Colors.white,
            //isDismissible: false,
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            context: context,
            builder: (_) =>
                AdditionsDialog(rent: rent, car: car, additionsList: additions),
          );
        });
      },
      child: Container(
        // width:orientation==Orientation.portrait? 347.w:100.w,
        //height: 152.h,
        margin: orientation == Orientation.portrait
            ? EdgeInsets.only(
                right: 23.w,
                left: 23.w,
                bottom: 12.h,
              )
            : null,
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              shadowColor: Colors.transparent,
              margin: EdgeInsets.only(left: 20.w),
              color: /*isHovered?Colors.yellow:Color(0xffEFFFFE):*/
                  Color(0xffF7F7F7),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 10.h, top: 10.h, right: 14.w, left: 11.w),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.postName.length > 12
                                ? '${car.postName.substring(0, 12)}...'
                                : '${car.postName}',
                            style: TextStyle(
                              fontSize: 34.sp,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            'או רכב זהה',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              height: 1.15,
                            ),
                          ),
                          Text(
                            car.address,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                              height: 1.15,
                            ),
                          ),
                          SizedBox(height: 29.h),
                          Text(
                            '${car.pricePerDay} ₪  |  ליום',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.15,
                            ),
                          ),
                          Text(
                            '${car.totalPrice} ₪  |  סה"כ',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.circle,
                                color: turquoiseColorApp,
                                size: 8.w,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (car.carImages.isNotEmpty)
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: Image.network(
                      car.carImages.first,
                      width: 175.w,
                      //height: 75.h,
                    )),
              )),
          ],
        ),
      ),
      // ),
    );
  }

  topButtons(context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        TextButton(
          onPressed: () => filterCarType(context, _scrollController),
          child: Row(
            children: [
              Text(
                'סנן ',
                style: TextStyle(
                  color: Color(0xFF0F1511),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
                Image.asset("assets/icons/Filter.png"),
            ],
          ),
        ),
        TextButton(
          onPressed: () =>
              rentalTerm(context,1, widget.startDate, widget.endDate),
          child: Row(
            children: [
              Text(
                ' שנה תאריך  ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
                Image.asset("assets/icons/Calendar.png"),
            ],
          ),
        ),
        TextButton(
          onPressed: () => expansionSearch(),
          child: Row(
            children: [
              Text(
                ' הגדל טווח חיפוש ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Image.asset("assets/icons/Range.png"),

            ],
          ),
        ),
      ],
    );
  }

  filterCarType(context, _controller,) {
    return showModalBottomSheet(
      //isScrollControlled: true,
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
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
          height: 230.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  // padding: EdgeInsets.zero,
                  // constraints: const BoxConstraints(minWidth: 20, maxWidth: 20),
                  iconSize: 20.w,
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                ),
              ),
              /*Container(
                       padding: EdgeInsets.only(top:8.5.h,),
                      width:393.w,
                      //height: 195.h,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 65.w,right: 65.w),
                        child: Container(
                         // color:Colors.green,
                          width:263.w,
                          height: 230.h,
                          child: Scrollbar(
                            controller: _controller,
                            thumbVisibility: true,
                            radius: const Radius.circular(10),
                            scrollbarOrientation:ScrollbarOrientation.top ,
                            child: ListView(
                              controller: _controller,
                              //defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                              scrollDirection: Axis.horizontal,
                              // border: TableBorder.all(width:4.w,color: Colors.red),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:25.w,bottom: 5.h),
                                  child: Container(
                                    height: 230.h,
                                    width: 270.w,
                                    //color:Colors.yellow,
                                    child:Row(
                                      children:[
                                        //SizedBox(height:120.h,),
                                        carSearchItem("מיני"),
                                        carSearchItem("משפחתי"),
                                      ],
                                    ),
                                  ),
                                ),
                               */
              /* Padding(
                                  padding: EdgeInsets.only(left:25.w,bottom: 5.h),
                                  child: Container(
                                    height: 195.h,
                                    width: 119.w,
                                    child:Column(
                                      children:[
                                        SizedBox(height:78.5.h,),
                                        carSearchItem("ג'יפון"),
                                        carSearchItem("היברידי/חשמלי"),
                                      ],),),
                                ),
                                Container(
                                  height: 195.h,
                                  width: 119.w,
                                  child:Column(
                                    children:[
                                      SizedBox(height:78.5.h,),
                                      carSearchItem("VIP"),
                                      carSearchItem("משפחתי+"),
                                    ],),),*/
              /*
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 98.w,
                      ),
                      Text(
                        'סנן לפי סוג הרכב',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0F1511),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      ImageIcon(
                        const AssetImage("assets/icons/Filter.png"),
                        color: pinkColorApp,
                      ),
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size(80, 20),
                            padding: EdgeInsets.all(0)),
                        onPressed: () => {
                          setState(() => type = 'all'),
                          Navigator.pop(context),
                        },
                        child: Text(
                          'נקה סינון',
                          style: TextStyle(
                            color: pinkColorApp,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                            decorationColor: pinkColorApp,
                            height: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 34.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      carSearchItem("מיני"),
                      carSearchItem("משפחתי"),
                    ],
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.white10.withOpacity(0.1),
      isDismissible: true,
      elevation: 2,
    );
  }

  carSearchItem(String name,) {
    return GestureDetector(
      onTap: () {
        setState(() {
          type = name;
          Navigator.pop(context);
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 5.h,
        ),
        width: 130.w,
        //height: 95.h,
        child: Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: blackColorApp,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              //  SizedBox(height: 13.h,),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                ),
                child: Image.asset(
                  'assets/images/car-only.png',
                  width: 115.w,
                  height: 50.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  expansionSearch() {
    return showModalBottomSheet(
      context: context,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, setState) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
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
            //height: 365.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    // padding: EdgeInsets.zero,
                    // constraints: const BoxConstraints(minWidth: 20, maxWidth: 20),
                    iconSize: 20.w,
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'הגדל טווח חיפוש',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF0F1511),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            //height: 1,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        ImageIcon(
                          const AssetImage("assets/icons/Range.png"),
                          color: pinkColorApp,
                        ),
                      ],
                    ),
                    SizedBox(height: 23.h),
                    Padding(
                      padding: EdgeInsets.only(right: 31.w, left: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'אזור חיפוש נוכחי: ',
                                style: TextStyle(
                                  color: Color(0xFF0F1511),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                    minimumSize: Size(80, 20),
                                    padding: EdgeInsets.all(0)),
                                onPressed: () => departurePoint(
                                    context, widget.location, 1,
                                    sdate: widget.startDate,
                                    edate: widget.endDate,
                                    latitude1: widget.latitude ?? 0,
                                    longitude1: widget.longitude ?? 0),
                                child: Text(
                                  'שנה כתובת ',
                                  style: TextStyle(
                                    color: pinkColorApp,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                    decorationColor: pinkColorApp,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.location,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF0F1511),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Text(
                            'הזז את הסמן למרחק הרצוי',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF0F1511),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          SizedBox(
                            height: 34,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: StatefulBuilder(builder: (context, state) {
                              return SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  showValueIndicator: ShowValueIndicator.always,
                                  valueIndicatorColor: turquoiseColorApp,
                                  inactiveTrackColor: Color(0xFFF6F6F6),
                                  activeTrackColor: turquoiseColorApp,
                                  thumbColor: turquoiseColorApp,
                                  trackHeight: 8.0,
                                  overlayColor: Color(0xFFF6F6F6),
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 10.0),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 10),
                                  valueIndicatorTextStyle: TextStyle(
                                    color: blackColorApp,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  valueIndicatorShape:
                                      PaddleSliderValueIndicatorShape(),
                                  // thumbShape: CustomSliderThumbCircle(thumbRadius: 20, min: 0, max: 100),
                                ),
                                child: Slider(
                                  value: currentSliderValue,
                                  max: 16,
                                  //divisions: 10,
                                  label: currentSliderValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      debugPrint('onChanged $value');
                                      currentSliderValue = value;
                                    });
                                  },
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'הוסף ${currentSliderValue.toInt()}  ק”מ לטווח החיפוש הנוכחי',
                              style: TextStyle(
                                color: Color(0xFF0F1511),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 21,
                          ),
                          Container(
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
                                  Navigator.pop(context);
                                  getCarsList();
                                },
                                child: Text(
                                  'הצג תוצאות נוספות',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      barrierColor: Colors.white10.withOpacity(0.1),
      isDismissible: true,
      elevation: 5,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)
    );
  }
}
