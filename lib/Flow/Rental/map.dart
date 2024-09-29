import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../customWidgets/appBarB.dart';
import '../../models/car.dart';
import '../../services/api_service.dart';
import '../../utils/my_colors.dart';
import 'car_dialog.dart';
import 'dialogs.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';


late GoogleMapController mapController;
class RentalWidget extends StatefulWidget {
  const RentalWidget({super.key});

  @override
  _RentalWidgetState createState() => _RentalWidgetState();
}

class _RentalWidgetState extends State<RentalWidget> {

  CameraPosition _kGoogle = const CameraPosition(target: LatLng(31.80012237280773, 35.212884511532316), zoom: 13,);

   String? formattedAddress;
  late Uint8List  available;
  late Uint8List  unAvailable;
  List<Car> availableCars = [];
  List<Car> unAvailableCars = [];
  final List<Marker> _markers = <Marker>[];
  bool dialogShown=false;
  double long=0, lat=0;


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled= await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Please enable location service');
    }

    permission= await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission= await Geolocator.requestPermission();

      if(permission==LocationPermission.denied){
        return Future.error('Location permission denied');
      }
    }

    Position position =await Geolocator.getCurrentPosition();

    return position;
  }

  Future<String?> getAddressFromLatLng(double latitude, double longitude, String apiKey) async {
    print('getAddressFromLatLng');
    final String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey&language=he';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['status'] == 'OK') {
          print("my location: ${decoded['results'][0]['formatted_address']}");
          return decoded['results'][0]['formatted_address'];
        }
      }
    } catch (e) {
      print('Error retrieving address: $e');
    }
    return null;
  }

  void _setCurrentLocation() async {
    print('_setCurrentLocation');
    try {
      Position position = await _determinePosition();
      formattedAddress = await getAddressFromLatLng(
        position.latitude,
        position.longitude,
        'AIzaSyDrD1omOKsD-QCghL7Oaq1LmU6mgxvqaLs',
      );
      long=position.longitude;
      lat=position.latitude;

    } catch (e) {
      print("There was an issue fetching the location: $e");
      formattedAddress='יפו 1, ירושלים';
      lat=31.781937670130752;
      long=35.21984481790195;
    }

    print('address: $formattedAddress');
    CameraPosition updatedPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
    );

    mapController.animateCamera(CameraUpdate.newCameraPosition(updatedPosition));

    /*Marker userLocationMarker = Marker(
        markerId: MarkerId('userLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );*/
    setState(() {
      _kGoogle = updatedPosition;
    });

    if(!dialogShown) {
      print('going to dialog');
      //var formattedAddress;
      if(formattedAddress!=null) {

        departurePoint(context, formattedAddress, 0,onClose:(){
        },latitude1: lat,longitude1: long);
      }
    }
  }


  getCarsList()  async{
print('getCarsList');
    await ApiService().getCarsAvailableOrNot((data){
      var available=data['available_car'];
      var unavailable=data['active_car'];

      availableCars = available.map<Car>((entry) => (Car.fromJson(entry))).toList();
      unAvailableCars = unavailable.map<Car>((entry) => (Car.fromJson(entry))).toList();
      setState(() {});

      generateMarkers();
    });

  }

// created method for displaying custom markers according to index
  addMarkers() async{
    print('loadData');
    int index=0;
    for(var car in availableCars){
      _markers.add(
          Marker(
            markerId: MarkerId('${index++}'),
            icon:   BitmapDescriptor.fromBytes(available) ,
            visible: true,
            position: LatLng(car.parkPosition["latitude"]!,car.parkPosition["longitude"]!),//_latLen[i],
            onTap: () {
              carDetailsDialog(context,car,true);
            },
          )
      );
      print('marker: ${_markers.length}');
    }
    for(var car in unAvailableCars){
      _markers.add(
          Marker(
            markerId: MarkerId('${index++}'),
            icon: BitmapDescriptor.fromBytes(unAvailable),
            visible: true,
            position: LatLng(car.parkPosition["latitude"]!,car.parkPosition["longitude"]!),
            onTap: () {
              carDetailsDialog(context,car,false);
            },
          )
      );
    }
    print('marker: ${_markers.length}');
    setState(() {});
  }

  Future getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  generateMarkers()async{
    available=await getBytesFromAsset('assets/images/car-available.png', kIsWeb?50:300);
    unAvailable=await getBytesFromAsset('assets/images/car-not-available.png', kIsWeb?50:300);
    //print('generate markers: $available, $unAvailable');
    addMarkers();
  }

  @override
  void initState() {
    super.initState();
    getCarsList();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGoogle,
            markers: _markers.toSet(),//Set<Marker>.of(_markers),
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,

          onMapCreated: (GoogleMapController controller){
            mapController=controller;
            _setCurrentLocation();
            },

          ),
          const AppBarBibilease(),
          Align(
            alignment: Alignment.bottomLeft,
            child:
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 48.h,
                  //width: 183.w,
                  child: PointerInterceptor(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: turquoiseColorApp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          dialogShown=true;
                          if(formattedAddress!=null) {
                            departurePoint(context, formattedAddress, 0,latitude1: lat,longitude1: long);
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ' לביצוע הזמנה  ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1,
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                            const ImageIcon(AssetImage("assets/icons/ADD.png"), color: Colors.white,),
                          ],
                        )),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
