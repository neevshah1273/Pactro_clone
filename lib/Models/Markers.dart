import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker m1= Marker(
    markerId: MarkerId('1'),
    position: LatLng(40.7028,-74.0160),
    infoWindow: InfoWindow(title: 'M1',onTap: null),
    onTap: null,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
);

Marker m2= Marker(
    markerId: MarkerId('1'),
    position: LatLng(40.7138,-74.0050),
    infoWindow: InfoWindow(title: 'M2',onTap: null),
    onTap: null,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
);

Marker m3= Marker(
    markerId: MarkerId('1'),
    position: LatLng(40.7119,-74.0063),
    infoWindow: InfoWindow(title: 'M3',onTap: null),
    onTap: null,

    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
);