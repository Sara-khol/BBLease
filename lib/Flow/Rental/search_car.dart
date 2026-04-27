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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/additions.dart';
import '../../models/class_user.dart';
import 'additions_dialog.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';


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
  final DateTime? startDate;
  final DateTime? endDate;

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
  late Orientation realOrientation;




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
    realOrientation = View.of(context).physicalSize.width >
        View.of(context).physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    return Scaffold(
      body:LandSpaceWidget(
        mainWidget: buildContent(realOrientation),
        imageProperties: ImageProperties('image1.png', 580.w,'תוצאות חיפוש'),
      ),
    );
  }

  buildContent(Orientation o) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              if (o == Orientation.portrait)
                const Directionality(
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
              topButtons(),
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
                                      searchCarItem(car,realOrientation);
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
                                      return searchCarItem(car,realOrientation);
                                    },
                                  ),
                                )
                              : Text('לא נמצאו תוצאות עבור: $type'),
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
                            return const Text('לא נמצאו רכבים באזורך');
                          }
                        },
                      ),
                    ),
            ]),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 400.w, // Set your desired width
                  height: 124.h, // Set your desired height
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.red,width: 2),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.0),
                        Colors.white,
                      ],
                    ),
                  ),
                )
            )
          ],
        ));
  }

  searchCarItem(Car car, Orientation orientation) {
    return PointerInterceptor(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                showLoading(context);
                await ApiService().getAdditions(
                    car.id, widget.startDate, widget.endDate, (orderJson) {
                  Navigator.pop(context);
                  List<Addition> additions = [];
                  additions = orderJson.map<Addition>((entry) => (Addition.fromJson(entry))).toList();
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
              child: SafeArea(
                top: false,
                maintainBottomViewPadding: true,
                minimum: EdgeInsets.only(bottom: 20.h),
                child: Container(
                  // width:orientation==Orientation.portrait? 347.w:100.w,
                  //height: 152.h,
                  margin: orientation == Orientation.portrait
                      ? EdgeInsets.only(
                          right: 23.w,
                          left: 23.w,
                          bottom: 12.h,
                        )
                      : EdgeInsets.only(bottom: 12.h,
                  ),
                  child: Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.only(left: 20.w),
                        color:  const Color(0xffF7F7F7),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.h, top: 10.h, right: 14.w, left: 11.w),
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
                                          : car.postName,
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
                        Positioned.fill(child: Align(
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
              ),
              // ),
            ),
          ),
        );

  }

  /*topButtons(context) {
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
                  color: const Color(0xFF0F1511),
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
  }*/

  topButtons()
  {
    return Wrap(
      alignment: WrapAlignment.center,
    //  spacing: 12,        // gap between buttons
    //  runSpacing: 8,      // gap between lines
      children: [
        _ActionBtn(
          onTap: () => filterCarType(context),
          label: 'סנן',
          asset: 'assets/icons/Filter.png',
        ),
        _ActionBtn(
          onTap: () => rentalTerm(context, 1, widget.startDate, widget.endDate),
          label: ' שנה תאריך ',
          asset: 'assets/icons/Calendar.png',
        ),
        _ActionBtn(
          onTap: () => expansionSearch(),
          label: ' הגדל טווח חיפוש ',
          asset: 'assets/icons/Range.png',
        ),
      ],
    );
  }



  filterCarType1(context,) {
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
          child: SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            minimum: EdgeInsets.only(bottom: 20.h),
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
                            color: const Color(0xFF0F1511),
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
                        const Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(80, 20),
                              padding: const EdgeInsets.all(0)),
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
                        carSearchItem("מיני",''),
                        carSearchItem("משפחתי",''),
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
      ),
      barrierColor: Colors.white10.withOpacity(0.1),
      isDismissible: true,
      elevation: 2,
    );
  }

  filterCarType(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // allow content-sized height
      backgroundColor: Colors.transparent,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          minimum: EdgeInsets.only(bottom: 20.h),
          child: Material(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: SingleChildScrollView( // scrolls only if content > viewport
              child: Padding(
                padding:  EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // <-- key: wrap to content
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header row
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        ImageIcon(
                          const AssetImage("assets/icons/Filter.png"),
                          color: pinkColorApp,
                        ),
                         SizedBox(width: 8.h),
                        Text(
                          'סנן לפי סוג הרכב',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F1511),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            setState(() => type = 'all');
                            Navigator.pop(context);
                          },
                          child: Text(
                            'נקה סינון',
                            style: TextStyle(
                              color: pinkColorApp,
                              fontSize: 18.sp,
                              decoration: TextDecoration.underline,
                              decorationColor: pinkColorApp,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),

                     SizedBox(height: 12.h),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,    // horizontal gap
                      runSpacing: 16, // vertical gap
                      children: [
                        carSearchItem('מיני','car-only.png'),
                        carSearchItem('משפחתי','car-only.png'),
                        // add more freely; height grows to fit
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  carSearchItem(String name,String imageName) {
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
                  'assets/images/$imageName',semanticLabel: 'car',
                 /* width: 115.w,
                  height: 50.h,*/
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
      builder: (context) => StatefulBuilder(builder: (BuildContext context, setState) {
        return SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          minimum: EdgeInsets.only(bottom: 20.h),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
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
              child: Directionality(
                textDirection: TextDirection.rtl,
   child: SingleChildScrollView(
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: 20.w,
                        icon: const Icon(Icons.close,),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'הגדל טווח חיפוש',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF0F1511),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                //height: 1,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                              Image.asset("assets/icons/Range.png",
                              color: pinkColorApp,
                                  width: 24.sp.clamp(22.0, 28.0),
                                  height: 24.sp.clamp(22.0, 28.0),
                                  fit: BoxFit.cover)
                          ],
                        ),
                        SizedBox(height: 23.h),
                        Padding(
                          padding: EdgeInsets.only(right: 25.w, left: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'אזור חיפוש נוכחי: ',
                                    style: TextStyle(
                                      color: const Color(0xFF0F1511),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.normal,
                                      height: 1,
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        minimumSize: const Size(80, 20),
                                        padding: const EdgeInsets.all(0)),
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
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                widget.location,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: const Color(0xFF0F1511),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                'הזז את הסמן למרחק הרצוי',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: const Color(0xFF0F1511),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: StatefulBuilder(builder: (context, state) {
                                  return SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      showValueIndicator: ShowValueIndicator.always,
                                      valueIndicatorColor: turquoiseColorApp,
                                      inactiveTrackColor: const Color(0xFFF6F6F6),
                                      activeTrackColor: turquoiseColorApp,
                                      thumbColor: turquoiseColorApp,
                                      trackHeight: 8.0,
                                      overlayColor: const Color(0xFFF6F6F6),
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 10.0),
                                      overlayShape: const RoundSliderOverlayShape(
                                          overlayRadius: 10),
                                      valueIndicatorTextStyle: TextStyle(
                                        color: blackColorApp,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      valueIndicatorShape:
                                          const PaddleSliderValueIndicatorShape(),
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
                              const SizedBox(
                                height: 19,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'הוסף ${currentSliderValue.toInt()}  ק”מ לטווח החיפוש הנוכחי',
                                  style: TextStyle(
                                    color: const Color(0xFF0F1511),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 21,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 48.h,
                                   // width: 332.w,
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
                              SizedBox(
                                height: 25.h,
                              ),
                            ],
                          ),
                        ),

                      ],
                    )),
            ),
          ),)
        );
      }),
      barrierColor: Colors.white10.withOpacity(0.1),
      isDismissible: true,
      elevation: 5,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({required this.onTap, required this.label, required this.asset});
  final VoidCallback onTap;
  final String label;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
       // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,                  // <-- prevents row from taking full width
        textDirection: TextDirection.rtl,                // ensures icon sits at the visual end
        children: [
          Text(
            label,
            style:  TextStyle(
              color: Color(0xFF0F1511),
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),

           SizedBox(width: 6.w),
          Image.asset(asset, height: 20, fit: BoxFit.contain), // constrain icon
        ],
      ),
    );
  }
}
