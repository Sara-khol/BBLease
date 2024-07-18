import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/Flow/Rental/search_car.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeparturePoint extends StatefulWidget {
  @override
  State<DeparturePoint> createState() => _DeparturePointState();
}

class _DeparturePointState extends State<DeparturePoint> {
  // location = address ?? '';
  // latitude = latitude1;
  // longitude = longitude1;
  late final FlutterGooglePlacesSdk _places;
  TextEditingController controller = TextEditingController();
  double? latitude;
  double? longitude;
  String location = '';
  DateTime? sdate ;
  DateTime? edate ;
  int nav=0 ;

  // GooglePlace googlePlace = GooglePlace('AIzaSyDrD1omOKsD-QCghL7Oaq1LmU6mgxvqaLs',headers: header);

  bool done = false;

  // List<AutocompletePrediction> predictions = [];
  List<AutocompletePrediction>? _predictions;
  Place? _place;
  final List<PlaceField> _placeFields = [
    PlaceField.Address,
    PlaceField.AddressComponents,
    PlaceField.BusinessStatus,
    PlaceField.Id,
    PlaceField.Location,
    PlaceField.Name,
    // PlaceField.OpeningHours,
    // PlaceField.PhoneNumber,
    // PlaceField.PhotoMetadatas,
    // PlaceField.PlusCode,
    // PlaceField.PriceLevel,
    // PlaceField.Rating,
    // PlaceField.Types,
    // PlaceField.UserRatingsTotal,
    // PlaceField.UTCOffset,
    // PlaceField.Viewport,
    // PlaceField.WebsiteUri,
  ];

  //Timer? debounce;

  @override
  void initState() {
    _places = FlutterGooglePlacesSdk('AIzaSyDrD1omOKsD-QCghL7Oaq1LmU6mgxvqaLs',
        locale:  const Locale('he', 'IL'));
    _places.isInitialized().then((value) {
      debugPrint('Places Initialized: $value');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return   showModalBottomSheet<dynamic>(
    //     isScrollControlled: true,
    //     isDismissible: false,
    //     barrierColor: Colors.black12.withOpacity(0.1),
    //     elevation: 2,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    //     ),
    //     context: context,
    //     builder: (context) {
    // return StatefulBuilder(builder: (context, StateSetter setState) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Directionality(
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
          constraints: BoxConstraints(maxHeight: 500.h),
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'מאיפה תרצה לצאת?',
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Icon(
                      Icons.fmd_good_outlined,
                      color: pinkColorApp,
                      size: 28.sp,
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.h,
                ),
                TextField(
                  autofocus: true,
                  cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: "",
                      labelStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromRGBO(15, 17, 21, 1),
                        fontFamily: 'PLONI',
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                      suffixIcon: Icon(
                        Icons.search,
                        color: turquoiseColorApp,
                        size: 24.sp,
                      )),
                  style: TextStyle(
                      color: Color.fromRGBO(15, 17, 21, 1), fontSize: 20.sp),
                  controller: controller,

                  onChanged: (value) async {
                    print('change');
                    //if (debounce?.isActive ?? false) debounce!.cancel();
                    //debounce =
                    // Timer(const Duration(milliseconds: 300), () {
                    if (value.isNotEmpty) {
                      final result = await _places.findAutocompletePredictions(
                        controller.text,
                        // countries: _countriesEnabled ? _countries : null,
                        // placeTypesFilter: _placeTypesFilter,
                        // newSessionToken: false,
                        // origin: LatLng(lat: 43.12, lng: 95.20),
                        // locationBias: _locationBiasEnabled ? _locationBias : null,
                        // locationRestriction:
                        // _locationRestrictionEnabled ? _locationRestriction : null,
                      );
                      _predictions = result.predictions;
                      print('Result: $_predictions');
                    }
                    //else
                    // predictions = [];
                    // });
                    setState(() {});
                  },
                  //=> isTyping=true,
                  onEditingComplete: () {
                    debugPrint('onEditingComplete');
                    if (controller.text.isNotEmpty)
                      done = true;
                    else
                      done = false;
                    //todo setstate??

                    FocusScope.of(context).unfocus();
                  },
                ),
                _predictions != null && _predictions!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _predictions!.length,
                            itemBuilder: (context, index) {
                              AutocompletePrediction prediction =
                                  _predictions![index];
                              return ListTile(
                                title: Text(
                                  prediction.fullText.toString(),
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                onTap: () async {
                                  debugPrint(
                                      'selected address: ${prediction.fullText.toString()}');
                                  controller.text =
                                      prediction.fullText.toString();
                                  //done = true;
                                  final placeId = prediction.placeId;
                                  debugPrint('placeId $placeId');
                                  final result = await _places.fetchPlace(placeId,fields: _placeFields);
                                  setState(() {
                                    _place = result.place;
                                  //  _fetchingPlace = false;
                                  });
                                  if (_place != null ) {
                                    debugPrint('details $_place');
                                    controller.text =
                                        _place!.address.toString();
                                    location = _place!.name
                                        .toString(); //details.result!.name!;
                                    latitude =
                                        _place!.latLng?.lat;
                                    longitude =
                                        _place!.latLng?.lng;
                                    debugPrint('location $latitude . $longitude');
                                    done = true;
                                    print('selected text: ${controller.text}');
                                  }
                                  _predictions = [];
                                },
                              );
                            }
                            ),
                      )
                    : Container(),
                //  placesAutoCompleteTextField(controller),
                //   predictions..isNotEmpty
                //       ? Expanded(
                //     child: ListView.builder(
                //         //reverse: true,
                //         shrinkWrap: true,
                //         itemCount: predictions.length,
                //         itemBuilder: (context, index) {
                //           AutocompletePrediction prediction = predictions[index];
                //           return ListTile(
                //             title: Text(
                //               prediction.description.toString(),
                //               style: TextStyle(fontSize: 20.sp),
                //             ),
                //             onTap: () async {
                //               print('selected address: ${prediction.description.toString()}');
                //               controller.text=prediction.description.toString();
                //               debugPrint(prediction.description);
                //               //done = true;
                //               final placeId = prediction.placeId!;
                //               debugPrint('placeId $placeId');
                //               final details = await googlePlace.details.get(placeId);
                //               if (details != null && details.result != null) {
                //                 debugPrint('details ${details.result}');
                //                 searchedPlace = details.result;
                //                 controller.text = prediction.description.toString();
                //                 location = prediction.description.toString();//details.result!.name!;
                //                 latitude = searchedPlace!.geometry!.location!.lat;
                //                 longitude = searchedPlace!.geometry!.location!.lng;
                //                 print('$latitude . $longitude');
                //                 done = true;
                //                 print('selected text: ${controller.text}');
                //
                //               }
                //               predictions = [];
                //             },
                //           );
                //         }),
                //   )
                //   : Spacer(),
                done
                    ? Column(
                        children: [
                          SizedBox(
                            height: 32.h,
                          ),
                          Container(
                            width: 332.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: turquoiseColorApp,
                            ),
                            child: TextButton(
                              child: Text(
                                'לבחירת תאריך',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed:
                              () {
                                  // debugPrint(
                                  //     "location $location longitude $longitude latitude $latitude");
                                  // print('address: $address');
                                  if (kIsWeb ||
                                      controller.text.isNotEmpty &&
                                          location.isNotEmpty) {
                                    //Navigator.pop(context);
                                    nav == 0
                                        ? rentalTerm(context)
                                        : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchCar(
                                                  location: location,
                                                  latitude: latitude,
                                                  longitude: longitude,
                                                  startDate: sdate,
                                                  endDate: edate),
                                        ));
                                    // MaterialPageRoute(
                                    //   builder: (context) => SearchCar(
                                    //       location: 'ירושלים',
                                    //       latitude: 31.803110,
                                    //       longitude: 35.216148,
                                    //       startDate: sdate,
                                    //       endDate: edate),
                                    // ));
                                  } else {
                                    displayMessage(context,
                                        message: 'נא הזן כתובת');
                                  }
                                }
                              ,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
    //   });
    // }); ;
  }

  Widget _buildPredictionItem(AutocompletePrediction item) {
    return InkWell(
      onTap: () => _onItemClicked(item),
      child: Column(children: [
        Text(item.fullText),
        Text(item.primaryText + ' - ' + item.secondaryText),
        const Divider(thickness: 2),
      ]),
    );
  }

  void _onItemClicked(AutocompletePrediction item) {
    controller.text = item.placeId;
  }
}
