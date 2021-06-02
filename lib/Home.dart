import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import './Models/Markers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver{
  Completer <GoogleMapController> _controller = Completer();
  GoogleMapController gMapController;

  Position currentLocation;

  void locatePosition() async{
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    currentLocation = position;

    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    CameraPosition camPos = new CameraPosition(target: currentLatLng,zoom: 16);

    gMapController.animateCamera(CameraUpdate.newCameraPosition(camPos));
  }


  String _darkMapStyle;
  String _lightMapStyle;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future _loadMapStyles() async {
    _darkMapStyle  = await rootBundle.loadString('assets/MapS/Dark.json');
    _lightMapStyle = await rootBundle.loadString('assets/MapS/Light.json');
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;
    final theme = WidgetsBinding.instance.window.platformBrightness;
    if (theme == Brightness.dark)
      controller.setMapStyle(_darkMapStyle);
    else
      controller.setMapStyle(_lightMapStyle);
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }


  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 20),
          width: MediaQuery.of(context).size.width*0.5,
          child: ElevatedButton(onPressed: (){
              locatePosition();
            },
              child: Row(
                children: [
                  Icon(Icons.my_location),
                  Text('current Location'),

            ],
          )),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_list_alt),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          __googleMap(context),
          //__searchBar(context),
          __buildContainer(context),
        ],
      ),
      endDrawer: Drawer(
        child: Center(
          child: ListView(
            children: [
              Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Icon(Icons.filter_list_alt,size: 50,),
                          Padding(padding: EdgeInsets.only(right: 20)),
                          Text('Filters',style: TextStyle(fontSize: 30)),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.topRight,

                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 40
                          ),
                          onPressed: _closeEndDrawer,

                        ),
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 40)),

                ExpansionTile(
                  title: Text('Gender'),
                  children: [
                    CheckboxListTile(value: true, onChanged: null,title: Text('Male'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('Female'),),
                  ],
                ),

                ExpansionTile(
                  title: Text('Availability'),
                  children: [
                    CheckboxListTile(value: true, onChanged: null,title: Text('Monday'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('Tuesday'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('Wednesday'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('Thursday'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('Friday'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('Saturday'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('Sunday'),),
                  ],
                ),
                ExpansionTile(
                  title: Text('Fees'),
                  children: [
                    CheckboxListTile(value: true, onChanged: null,title: Text('150-350 Rs'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('350-750 Rs'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('750-1000 Rs'),),
                    CheckboxListTile(value: true, onChanged: null,title: Text('1000 Rs+'),),
                  ],
                ),
                ElevatedButton(onPressed: null, child: Text('Clear Filters'))
              ],
            ),
            ]
          ),
        ),
      ),
    );
  }






  Widget __googleMap(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,

        initialCameraPosition: CameraPosition(target: LatLng(40.7128,-74.0060) ,zoom: 12),
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController Controller){
          _controller.complete(Controller);
          gMapController = Controller;
        },
        markers: {
          m1,m2,m3
        },
      ),
    );
  }


  Widget __buildContainer(BuildContext context){

    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: MediaQuery.of(context).size.width*0.80,
            height: MediaQuery.of(context).size.height*0.3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:<Widget> [
                        //Text('data')


                        Container(
                          width: 300,
                          height: 200,
                          child: Stack(

                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 40),
                                height: 200,
                                width: 400,
                                child: Card(
                                  child: ListView(
                                      children:[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 8, 12, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('~3.2Km~'),
                                                Icon(Icons.bookmark,color: Colors.yellow,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),

                                          child: Text('DR. Aiden Markram'),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Text('General Surgon | 4.7'),
                                              Icon(Icons.thumb_up,color: Colors.blue,)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text('Standard Clinic'),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 6)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(Icons.message),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(Icons.video_call),
                                              ],
                                            ),

                                            Column(
                                              children: [
                                                Icon(Icons.call),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                //Icon(Icons.error)
                                                Text('700 Rs')
                                              ],
                                            ),

                                          ],
                                        )
                                      ]
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: ClipRRect(
                                    borderRadius: new BorderRadius.circular(40.0),
                                    child: Image.asset('assets/Images/avtar.png', height: 80, width: 80),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 200,
                          child: Stack(

                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 40),
                                height: 200,
                                width: 400,
                                child: Card(
                                  child: ListView(
                                      children:[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 8, 12, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('~4.5Km~'),
                                                Icon(Icons.bookmark,color: Colors.yellow,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),

                                          child: Text('DR. Quinton De Cock'),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Text('Arurvedic | 3.7'),
                                              Icon(Icons.thumb_up,color: Colors.blue,)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text('MultiSpeciality Hospital'),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 6)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(Icons.message),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(Icons.video_call),
                                              ],
                                            ),

                                            Column(
                                              children: [
                                                Icon(Icons.call),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                //Icon(Icons.error)
                                                Text('450 Rs')
                                              ],
                                            ),

                                          ],
                                        )
                                      ]
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: ClipRRect(
                                    borderRadius: new BorderRadius.circular(40.0),
                                    child: Image.asset('assets/Images/avtar.png', height: 80, width: 80),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 200,
                          child: Stack(

                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 40),
                                height: 200,
                                width: 400,
                                child: Card(
                                  child: ListView(
                                      children:[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 8, 12, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('~1.6Km'),
                                                Icon(Icons.bookmark,color: Colors.yellow,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),

                                          child: Text('DR. Temba Bavuma'),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Text('Clinic | 3.3'),
                                              Icon(Icons.thumb_up,color: Colors.blue,)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text('Standard Clinic'),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 6)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(Icons.message),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(Icons.video_call),
                                              ],
                                            ),

                                            Column(
                                              children: [
                                                Icon(Icons.call),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                //Icon(Icons.error)
                                                Text('850 Rs')
                                              ],
                                            ),

                                          ],
                                        )
                                      ]
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: ClipRRect(
                                    borderRadius: new BorderRadius.circular(40.0),
                                    child: Image.asset('assets/Images/avtar.png', height: 80, width: 80),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 200,
                          child: Stack(

                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 40),
                                height: 200,
                                width: 400,
                                child: Card(
                                  child: ListView(
                                      children:[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 8, 12, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('~8.9Km~'),
                                                Icon(Icons.bookmark,color: Colors.yellow,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),

                                          child: Text('DR. Rassie Dussen'),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Text('General Surgon | 4.7'),
                                              Icon(Icons.thumb_up,color: Colors.blue,)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text('Standard Clinic'),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 6)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(Icons.message),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(Icons.video_call),
                                              ],
                                            ),

                                            Column(
                                              children: [
                                                Icon(Icons.call),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                //Icon(Icons.error)
                                                Text('700 Rs')
                                              ],
                                            ),

                                          ],
                                        )
                                      ]
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: ClipRRect(
                                    borderRadius: new BorderRadius.circular(40.0),
                                    child: Image.asset('assets/Images/avtar.png', height: 80, width: 80),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 200,
                          child: Stack(

                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 40),
                                height: 200,
                                width: 400,
                                child: Card(
                                  child: ListView(
                                      children:[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 8, 12, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('~3,2Km'),
                                                Icon(Icons.bookmark,color: Colors.yellow,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),

                                          child: Text('DR. Aiden Markram'),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Text('General Surgon | 4.7'),
                                              Icon(Icons.thumb_up,color: Colors.blue,)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text('Standard Clinic'),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 6)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(Icons.message),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(Icons.video_call),
                                              ],
                                            ),

                                            Column(
                                              children: [
                                                Icon(Icons.call),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                //Icon(Icons.error)
                                                Text('700 Rs')
                                              ],
                                            ),

                                          ],
                                        )
                                      ]
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: ClipRRect(
                                    borderRadius: new BorderRadius.circular(40.0),
                                    child: Image.asset('assets/Images/avtar.png', height: 80, width: 80),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }



  Future<void> _goToTheHospital() async {
    gMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: m1.position,zoom: 18)));
  }
}

