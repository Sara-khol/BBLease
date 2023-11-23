import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'dialogs.dart';


class RentalWidget extends StatefulWidget {
  const RentalWidget({super.key});

  @override
  _RentalWidgetState createState() => _RentalWidgetState();
}

class _RentalWidgetState extends State<RentalWidget> {

  late GoogleMapController _mapController;

  Future<Position> _determinePosition() async{
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

  void _setCurrentLocation() async {
    try {
      Position position = await _determinePosition();

      CameraPosition updatedPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17,
      );

      _mapController.animateCamera(CameraUpdate.newCameraPosition(updatedPosition));

      Marker userLocationMarker = Marker(
        markerId: MarkerId('userLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      // Add the user's location marker to the list of markers
      _markers.add(userLocationMarker);
      print('marker: ${_markers.length}');


      setState(() {
        _kGoogle = updatedPosition;
      });
    } catch (e) {
      print("There was an issue fetching the location: $e");
    }
  }

  CameraPosition _kGoogle = CameraPosition(target: LatLng(31.802364052347162, 35.09444909735681), zoom: 17,);
  final List<Marker> _markers = <Marker>[];

  //List<String> images = ['assets/images/Vector.png',];

  //TODO: get locations from API
  final List<LatLng> _latLen = <LatLng>[

    LatLng(31.814850481904614, 35.19863145952789),
    LatLng(31.812005967321277, 35.20367401242728),
    LatLng(31.81645504122628, 35.20084159973486),
    LatLng(31.81572569953603, 35.19584196217929),
    LatLng(31.812334185013373, 35.19592779286694),
    LatLng(31.81895299286649, 35.19504802831853),
  ];

// declared method to get Images
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

// created method for displaying custom markers according to index
  loadData() async{
    //for(int i=0 ;i<images.length; i++){
      //final Uint8List markIcons = await getImages(images[i], 50);
      // makers added according to index
      _markers.add(
          Marker(
            // given marker id
            markerId: MarkerId('i.toString()'),
            // given marker icon
            icon:  BitmapDescriptor.defaultMarker,//BitmapDescriptor.fromBytes(markIcons),
            visible: true,
            // given position
            position: LatLng(_kGoogle.target.latitude, _kGoogle.target.longitude),//_latLen[i],
            infoWindow: InfoWindow(
              // given title for marker
              title: 'You are here',//'Location: '+i.toString(),
            ),
          )
      );
      setState(() {
      });
    //}
  }

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void disposeController(){
    print('dispose...');
    _mapController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
      // given camera position
      initialCameraPosition: _kGoogle,
      // set markers on google map
      markers: Set<Marker>.of(_markers),
      // on below line we have given map type
      mapType: MapType.normal,
      zoomControlsEnabled: true,
      // on below line we have enabled location
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      // on below line we have enabled compass
      compassEnabled: true,
      // below line displays google map in our app
      onMapCreated: (GoogleMapController controller){
        _mapController=controller;
        Navigator.pop(context);
        departurePoint(context,disposeController);
      },
        ),
    );
  }

}
