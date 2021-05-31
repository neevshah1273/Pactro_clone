import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatelessWidget{

  Completer <GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Stack(
        children: <Widget>[
          __googleMap(context),
        ],
      ),
    );
  }

  Widget __googleMap(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(40.7128,-74.0060),zoom: 12),
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController Controller){
          _controller.complete(Controller);
        },
        markers: {
          m1,m2,m3
        },
      ),
    );
  } 
}

Marker m1= Marker(
  markerId: MarkerId('1'),
  position: LatLng(40,-74),
  infoWindow: InfoWindow(title: 'M1',onTap: null),
  onTap: null,
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
);

Marker m2= Marker(
  markerId: MarkerId('1'),
  position: LatLng(42,-72),
  infoWindow: InfoWindow(title: 'M2',onTap: null),
  onTap: null,
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
);

Marker m3= Marker(
  markerId: MarkerId('1'),
  position: LatLng(44,-74),
  infoWindow: InfoWindow(title: 'M3',onTap: null),
  onTap: null,
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
);