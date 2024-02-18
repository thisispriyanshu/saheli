import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/safeways.dart';

class SafeRoutes extends StatefulWidget {
  const SafeRoutes({super.key});
  @override
  State<SafeRoutes> createState() => _SafeRoutesState();
}

class _SafeRoutesState extends State<SafeRoutes> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final Set<Marker> _markers = {};

  final mapsApiKey = "AIzaSyBAC_OF_lWBfFr_Zjs-mO0Kwyr4f_faiMU";
  late GoogleMapController mapController;

  LatLng _currentLocation = const LatLng(28.59351217640707, 77.24437040849519);
  List<LatLng> polyLineCoordinates = [];
  final LatLng destLocation = const LatLng(28.656948267717762, 77.24093718110075 );


  //
  // void _getCurrentLocation() async {
  //   Location location = Location();
  //   location.getLocation().then((value) {
  //     _currentLocation = LatLng(value.latitude!, value.longitude!);
  //     print("Current Location - ${_currentLocation}");
  //   });
  //   location.onLocationChanged.listen((newLoc) {
  //     _currentLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //         zoom: 14, target: LatLng(newLoc.latitude!, newLoc.longitude!))));
  //     setState(() {});
  //   });
  // }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Future<void> _getCurrentLocation() async {
  //   var location = Location();// LocationData? _currentLocation = LocationData.fromMap({
  //   "latitude": 31.3310016,
  //   "longitude" : 75.5734925,
  // });
  //   try {
  //     LocationData currentLocation = await location.getLocation();
  //     setState(() {
  //       _currentLocation = currentLocation;
  //       print(_currentLocation);
  //     });
  //   } catch (e) {
  //     print('Error getting location: $e');
  //   }
  // }

  void getPolyPoints() async {
    List? steps = await makeSafeRouteRequest(_currentLocation, destLocation, "driving");
    if(steps!.isNotEmpty){
      for (var step in steps) {
        polyLineCoordinates.add(LatLng(step['end_location']['lat'], step['end_location']['lng']));
      }
      setState(() {});
    }
    else{
      print('error');
    }
    print(polyLineCoordinates);
  }

  @override
  void initState() {
    // _getCurrentLocation();
    getPolyPoints();
    //setCustomMarker();
    super.initState();
  }
  @override
  void dispose(){
    _locationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }
  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
      ));
    });
  }

  void _showCoordinates(String placeName) async {
    try {
      var locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        final LatLng position = LatLng(locations.first.latitude, locations.first.longitude);
        _addMarker(position);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location not found!'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }
  // void setCustomMarker(){
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((icon) {
  //     sourceIcon = icon;
  //   });
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((icon) {
  //     destIcon = icon;
  //   });
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((icon) {
  //     currLocIcon = icon;
  //   });
  // }

  void _launchMapsUrl() async {
    final String googleMapsUrl = "https://www.google.com/maps/dir/?api=1";
    final String waypoints = polyLineCoordinates.map((point) => "${point.latitude},${point.longitude}").join("|");
    final String origin = "${polyLineCoordinates.first.latitude},${polyLineCoordinates.first.longitude}";
    final String destination = "${destLocation.latitude},${destLocation.longitude}";
    final String finalUrl = "$googleMapsUrl&origin=$origin&destination=$destination&waypoints=$waypoints&travelmode=driving&dir_action=navigate";

    if (await canLaunch(finalUrl)) {
      await launch(finalUrl);
    } else {
      throw 'Could not launch $finalUrl';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom: 90.0),
      child: FloatingActionButton.extended(
        onPressed: () {
          // String location = _locationController.text;
          // String destination = _destinationController.text;
          // _showCoordinates(location);
          // _showCoordinates(destination);
          // getPolyPoints();
          _launchMapsUrl();
        },
        label: Text('Start journey'),
        icon: Icon(Icons.location_on),
        backgroundColor: Colors.blue,
      ),
    ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(

            children: [
              // Positioned(
              //   top: 10.0,
              //   left: 10.0,
              //   child: Container(
              //     padding: EdgeInsets.all(8.0),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         TextField(
              //           controller: _locationController,
              //           decoration: InputDecoration(
              //             labelText: 'Enter your location',
              //             border: InputBorder.none,
              //           ),
              //         ),
              //         SizedBox(height: 10.0),
              //         TextField(
              //           controller: _destinationController,
              //           decoration: InputDecoration(
              //             labelText: 'Enter destination',
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   // Positioned(
              //   //       left: 10,// you can change place of search bar any where on the map
              //   //       child: ElevatedButton(
              //   //           onPressed: _handleSearch,
              //   //           child: Text('search')),
              //   //     )
              // ),
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: _currentLocation != null
                    ? CameraPosition(
                  target: LatLng(
                      _currentLocation.latitude, _currentLocation.longitude),
                  zoom: 14.0,
                )
                    : const CameraPosition(
                  target: LatLng(28.59351217640707, 77.24437040849519),
                  zoom: 14.0,
                ),
                polylines: {
                  Polyline(
                      polylineId: const PolylineId("route"),
                      points: polyLineCoordinates,
                      color: Colors.pinkAccent,
                      width: 6)
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("current location"),
                    position: _currentLocation,
                  ),
                  Marker(
                    markerId: const MarkerId("destination"),
                    position: destLocation,
                  ),
                  if (polyLineCoordinates.isNotEmpty)
                    Marker(
                      markerId: const MarkerId("safest route"),
                      position: polyLineCoordinates[polyLineCoordinates.length ~/ 2],
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                      infoWindow: InfoWindow(
                        title: "Safest Route",

                      ),
                    ),
                },

                myLocationEnabled: true,
              ),
        Stack(
            children: <Widget>[

        Container(
            height: MediaQuery.of(context).size.width * 0.2,
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget> [

            Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _locationController,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(labelText: 'Select Source Location',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),),)

              ),
            ),),
    Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
      controller: _destinationController,
      cursorColor: Colors.white,
      style: TextStyle(
      color: Colors.white,
      ),
      decoration:InputDecoration(labelText: 'Select Destination',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),),)

      ),
    ),),


            ]
        )
    )
        ]
        )
    ]));
  }
}