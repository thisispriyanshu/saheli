
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_autocomplete_field/map_autocomplete_field.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as loc;
import '../../api/safeways.dart';
import 'BrakeDetection.dart';

class SafeRoutes extends StatefulWidget {
  const SafeRoutes({super.key});
  @override
  State<SafeRoutes> createState() => _SafeRoutesState();
}

class _SafeRoutesState extends State<SafeRoutes> {
  bool flag = false;
  bool _isLoading = false;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  late final LatLng initialLocation;
  late final LatLng finalLocation;
  late double startlat, startlong, destlat, destlong;
  final Set<Marker> _markers = {};
  double previousAcceleration = 0.0;
  late String _selectedTravelMethod='Walking';
  late String _selectedStart='Select Start Location';
  late String _selectedEnd='Select End Location';
  double threshold = 5.0; // Adjust this threshold as needed
  final sensorController = Get.put(SensorController());


  final mapsApiKey = FlutterConfig.get("MAPS_API_KEY");
  late GoogleMapController mapController;
  var _controller = TextEditingController();
  var _controller2 = TextEditingController();
  late String drivingMode;
  var uuid = new Uuid();
  String _sessionToken = "";

  LatLng _currentLocation = LatLng(28.59351217640707, 77.24437040849519);
  List<LatLng> polyLineCoordinates = [];
   LatLng destLocation = LatLng(28.656948267717762, 77.24093718110075 );


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
      polyLineCoordinates.clear();
      for (var step in steps) {
        polyLineCoordinates.add(LatLng(step['end_location']['lat'], step['end_location']['lng']));
      }
      setState(() {});
    }
    else{
      print('error');
    }
  }

  @override
  void initState() {
    // _getCurrentLocation();
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      double acceleration = event.y; // You can use other axes as needed
      sensorController.currentAcceleration.value = acceleration;
      if ((previousAcceleration - acceleration) >= threshold) {
        // Harsh braking detected, take action here
        print('Harsh braking detected!');
        print('Please drive slowly!');
        sensorController.isHarshBraking.value = true;
        _showHarshBrakingDialog(); // Show dialog box when harsh braking is detected
      } else {
        sensorController.isHarshBraking.value = false;
      }
      previousAcceleration = acceleration;
    });
    // getPolyPoints();
    _controller.addListener(() {
      _onChanged();
    });
    _controller2.addListener(() {
      _onChanged2();
    });
    //setCustomMarker();
  }

  @override
  void dispose(){
    _locationController.dispose();
    _destinationController.dispose();

    accelerometerEvents.drain();

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

  void _showHarshBrakingDialog() {
    if (flag) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Harsh Braking Detected'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 48,
                ),
                SizedBox(height: 10),
                Text(
                  'Please drive slowly!',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    // getSuggestion(_controller.text, false);
  }

  _onChanged2() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    // getSuggestion(_controller2.text, true);
  }

  // void getSuggestion(String input, bool isDest) async {
  //   String kPLACES_API_KEY = FlutterConfig.get("MAPS_API_KEY");
  //   String type = '(regions)';
  //   String baseURL =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request =
  //       '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
  //   var response = await  http.get(Uri.parse(request));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //
  //       if(isDest){
  //         if (_placeList['result'] != null &&
  //             _placeList['result']['geometry'] != null &&
  //             _placeList['result']['geometry']['location'] != null) {
  //           double latitude = _placeList['result']['geometry']['location']['lat'];
  //           double longitude = _placeList['result']['geometry']['location']['lng'];
  //         }
  //       }
  //     });
  //   } else {
  //     throw Exception('Failed to load predictions');
  //   }
  // }

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
    // if (await canLaunchUrl(Uri(path: finalUrl))) {
    //   await launch(finalUrl);
    // } else {
    //   throw 'Could not launch $finalUrl';
    // }
    await launchUrl(Uri.parse(finalUrl));
    // _launchMap(Uri(path: finalUrl));
  }
  Future<void> _launchMap(url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(url)) {

    } else {
      throw 'Could not launch $url';
    }}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton:  Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              String location = _locationController.text;
              String destination = _destinationController.text;
              _showCoordinates(location);
              _showCoordinates(destination);
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
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: _locationController.text.isNotEmpty
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
                      color: Colors.blueAccent,
                      width: 6)
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("Your location"),
                    position: _currentLocation,
                  ),
                  Marker(
                    markerId: const MarkerId("Destination"),
                    position: destLocation,
                  ),

                },

                myLocationEnabled: true,
              ),

              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Semi-transparent black background
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              Positioned(
                top: 10,
                right: 15,
                left: 15,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        splashColor: Colors.grey,
                        icon: Icon(Icons.directions_run
                        ),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: MapAutoCompleteField(
                          // cursorColor: Colors.black,
                          // keyboardType: TextInputType.text,
                          // textInputAction: TextInputAction.go,
                          controller: _locationController,
                          inputDecoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Search start location..."),
                          googleMapApiKey: FlutterConfig.get("MAPS_API_KEY"),
                          // controller: addressCtrl,
                          itemBuilder: (BuildContext context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.description),
                            );
                          },
                          onSuggestionSelected: (suggestion) async {
                            List<loc.Location> startloc = await locationFromAddress(_destinationController.text);
                            loc.Location firstLocation = startloc[0];

                            _currentLocation = LatLng(firstLocation.latitude, firstLocation.longitude);
                            _locationController.text = suggestion.description;

                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.search),

                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 15,
                left: 15,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        splashColor: Colors.grey,
                        icon: Icon(Icons.flag
                        ),
                        onPressed: () {},
                      ),
                      Expanded(
                        child:
                        MapAutoCompleteField(
                          // cursorColor: Colors.black,
                          // keyboardType: TextInputType.text,
                          // textInputAction: TextInputAction.go,
                          controller: _destinationController,
                          inputDecoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Search destination location..."),
                          googleMapApiKey: FlutterConfig.get("MAPS_API_KEY"),
                          // controller: addressCtrl,
                          itemBuilder: (BuildContext context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.description),
                            );
                          },
                          onSuggestionSelected: (suggestion) async {
                            List<loc.Location> destloc = await locationFromAddress(_destinationController.text);
                            loc.Location firstLocation = destloc[0];

                            destLocation = LatLng(firstLocation.latitude, firstLocation.longitude);
                            _destinationController.text = suggestion.description;
                            getPolyPoints();
                          },
                        ),
                        // TextField(
                        //   onTap: () async {
                        //     //   Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //     builder: (context) =>
                        //     //   ),
                        //     // );
                        //   },

                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.search),

                      ),
                    ],
                  ),
                ),
              ),

            ]));
  }
}

