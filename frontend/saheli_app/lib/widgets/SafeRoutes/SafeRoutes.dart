import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../api/safeways.dart';

class SafeRoutes extends StatefulWidget {
  const SafeRoutes({super.key});
  @override
  State<SafeRoutes> createState() => _SafeRoutesState();
}

class _SafeRoutesState extends State<SafeRoutes> {
  bool _isLoading = false;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  late final LatLng initialLocation;
  late final LatLng finalLocation;
  final Set<Marker> _markers = {};
  bool flag = false;
  double previousAcceleration = 0.0;
  late String _selectedTravelMethod = 'Walking';
  late String _selectedStart = 'Select Start Location';
  late String _selectedEnd = 'Select End Location';
  double threshold = 5.0; // Adjust this threshold as needed
  //final sensorController = Get.put(SensorController());

  final mapsApiKey = FlutterConfig.get('MAPS_API_KEY');
  late GoogleMapController mapController;
  var _controller = TextEditingController();
  var _controller2 = TextEditingController();
  late String drivingMode;
  var uuid = new Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];
  List<dynamic> _placeList2 = [];

  LatLng _currentLocation = const LatLng(28.59351217640707, 77.24437040849519);
  List<LatLng> polyLineCoordinates = [];
  LatLng destLocation = const LatLng(28.656948267717762, 77.24093718110075);

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
    List? steps =
        await makeSafeRouteRequest(_currentLocation, destLocation, "driving");
    if (steps!.isNotEmpty) {
      for (var step in steps) {
        polyLineCoordinates.add(
            LatLng(step['end_location']['lat'], step['end_location']['lng']));
      }
      setState(() {});
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    // _getCurrentLocation();
    getPolyPoints();
    // setCustomMarker();
    super.initState();
  }

  @override
  void dispose() {
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
        final LatLng position =
            LatLng(locations.first.latitude, locations.first.longitude);
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
    final String googleMapsUrl = "https://www.google.com/maps/dir/?api=${FlutterConfig.get("")}";
    final String waypoints = polyLineCoordinates
        .map((point) => "${point.latitude},${point.longitude}")
        .join("|");
    final String origin =
        "${polyLineCoordinates.first.latitude},${polyLineCoordinates.first.longitude}";
    final String destination =
        "${destLocation.latitude},${destLocation.longitude}";
    final String finalUrl =
        "$googleMapsUrl&origin=$origin&destination=$destination&waypoints=$waypoints&travelmode=driving&dir_action=navigate";
    if (await canLaunchUrl(Uri(path: finalUrl))) {
      await launchUrl(Uri(path: finalUrl));
    } else {
      throw 'Could not launch $finalUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              String location = _locationController.text;
              String destination = _destinationController.text;
              _showCoordinates(location);
              _showCoordinates(destination);
              getPolyPoints();
              _launchMapsUrl();
            },
            label: Text('Start journey'),
            icon: Icon(Icons.location_on),
            backgroundColor: Colors.blue,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(children: [
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
          icon: BitmapDescriptor.defaultMarkerWithHue(
                   BitmapDescriptor.hueAzure),
              ),
              Marker(
                markerId: const MarkerId("Destination"),
                position: destLocation,
              ),
              // if (polyLineCoordinates.isNotEmpty)
              //   Marker(
              //     markerId: const MarkerId("Safest Route"),
              //     position:
              //         polyLineCoordinates[polyLineCoordinates.length ~/ 2],
              //     icon: BitmapDescriptor.defaultMarkerWithHue(
              //         BitmapDescriptor.hueGreen),
              //     infoWindow: InfoWindow(
              //       title: "Safest Route",
              //     ),
              //   ),
            },
            myLocationEnabled: true,
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent black background
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
    Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller2,
                      decoration: InputDecoration(
                        hintText: "Search start location",
                        hintStyle: GoogleFonts.outfit(),
                        focusColor: Colors.white,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.add_location_alt),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controller2.clear();
                          },
                          icon: const Icon(Icons.cancel),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    _placeList.isEmpty
                        ? SizedBox()
                        : Container(
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Color(0xffE4F3EC)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _placeList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    // Set the selected item in the text field
                                    setState(() {
                                      _controller2.text =
                                          _placeList[index]["description"];
                                      _placeList.clear();
                                    });
                                  },
                                  title: Text(_placeList[index]["description"]),
                                );
                              },
                            ),
                          ),
                    SizedBox(
                      height: 3,
                    ),
                    // Obx(
                    //   () => Center(
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Visibility(
                    //           visible: sensorController.isHarshBraking.value,
                    //           child: const Text(
                    //             "Harsh Braking",
                    //             style:
                    //                 TextStyle(fontSize: 22, color: Colors.red),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Search destination location",
                        hintStyle: GoogleFonts.outfit(),
                        focusColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.map),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controller.clear();
                          },
                          icon: const Icon(Icons.cancel),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    _placeList2.isEmpty
                        ? SizedBox()
                        : Container(
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Color(0xffE4F3EC)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _placeList2.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    // Set the selected item in the text field
                                    setState(() {
                                      _controller.text =
                                          _placeList2[index]["description"];
                                      _placeList.clear();
                                    });
                                  },
                                  title:
                                      Text(_placeList2[index]["description"]),
                                );
                              },
                            ),
                          ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          style: GoogleFonts.outfit(
                              color: Colors.black, fontSize: 16),
                          value: _selectedTravelMethod,
                          hint: Text("Select travel method"),
                          items: <String>['Driving', 'Walking']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          buttonStyleData: ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Color(0xffFEECEB),
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            iconSize: 24,
                            iconDisabledColor: Colors.black26,
                            iconEnabledColor: Colors.black,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Color(0xffFEECEB),
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                            elevation: 8,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                          onChanged: (String? newValue) {
                            if (newValue == 'Driving') {
                              if (!flag) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Turn on accident prevention?"),
                                        content: Text(
                                            "Accident prevention detects and warns about harsh brakes, and thus keeps you safe during driving"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                flag = true;
                                                _selectedTravelMethod =
                                                    'driving';
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(SnackBar(
                                                //     content: Text(
                                                //         'Accident prevention turned on')));
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Yes"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Cancel action
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Already turned prevention on!')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Switched to walking, Turned off prevention')));
                              setState(() {
                                flag = false;
                                _selectedTravelMethod = 'Walking';
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(SnackBar(
                                //     content: Text(
                                //         'Accident prevention turned on')));
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_config/flutter_config.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
// import '../../api/safeways.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sensors_plus/sensors_plus.dart';
//
// class SafeRoutes extends StatefulWidget {
//   const SafeRoutes({super.key});
//   @override
//   State<SafeRoutes> createState() => _SafeRoutesState();
// }
//
// class _SafeRoutesState extends State<SafeRoutes> {
//   bool flag = false;
//   bool _isLoading = false;
//   String _selectedValue = '';
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//   final Set<Marker> _markers = {};
//   double previousAcceleration = 0.0;
//   late String _selectedTravelMethod = 'Walking';
//   late String _selectedStart = 'Select Start Location';
//   late String _selectedEnd = 'Select End Location';
//   double threshold = 5.0; // Adjust this threshold as needed
//   final sensorController = Get.put(SensorController());
//   Future<BitmapDescriptor> getCustomMarkerIcon(String assetName) async {
//     final ByteData byteData = await rootBundle.load(assetName);
//     final Uint8List imageData = byteData.buffer.asUint8List();
//     return BitmapDescriptor.fromBytes(imageData);
//   }
//
//   final mapsApiKey = FlutterConfig.get('MAPS_API_KEY');
//   late GoogleMapController mapController;
//   var _controller = TextEditingController();
//   var _controller2 = TextEditingController();
//   late String drivingMode;
//   var uuid = new Uuid();
//   String _sessionToken = "";
//   List<dynamic> _placeList = [];
//   List<dynamic> _placeList2 = [];
//
//   LatLng _currentLocation = const LatLng(28.59351217640707, 77.24437040849519);
//   List<LatLng> polyLineCoordinates = [];
//   LatLng destLocation = const LatLng(28.656948267717762, 77.24093718110075);
//
//   //
//   // void _getCurrentLocation() async {
//   //   Location location = Location();
//   //   location.getLocation().then((value) {
//   //     _currentLocation = LatLng(value.latitude!, value.longitude!);
//   //     print("Current Location - ${_currentLocation}");
//   //   });
//   //   location.onLocationChanged.listen((newLoc) {
//   //     _currentLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
//   //     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//   //         zoom: 14, target: LatLng(newLoc.latitude!, newLoc.longitude!))));
//   //     setState(() {});
//   //   });
//   // }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   // Future<void> _getCurrentLocation() async {
//   //   var location = Location();// LocationData? _currentLocation = LocationData.fromMap({
//   //   "latitude": 31.3310016,
//   //   "longitude" : 75.5734925,
//   // });
//   //   try {
//   //     LocationData currentLocation = await location.getLocation();
//   //     setState(() {
//   //       _currentLocation = currentLocation;
//   //       print(_currentLocation);
//   //     });
//   //   } catch (e) {
//   //     print('Error getting location: $e');
//   //   }
//   // }
//
//   void getPolyPoints() async {
//     print("curr $_currentLocation");
//     print("travel $_selectedTravelMethod");
//     List? steps = await makeSafeRouteRequest(
//         _currentLocation.latitude,
//         _currentLocation.longitude,
//         destLocation.latitude,
//         destLocation.longitude,
//         _selectedTravelMethod);
//     print('steps');
//     print(steps);
//     if (steps!.isNotEmpty) {
//       for (var step in steps) {
//         polyLineCoordinates.add(
//             LatLng(step['end_location']['lat'], step['end_location']['lng']));
//       }
//       setState(() {});
//     } else {
//       print('error');
//     }
//
//     print(polyLineCoordinates);
//   }
//
//   @override
//   void initState() {
//     print('poly');
//     getPolyPoints();
//     _controller.addListener(() {
//       _onChanged();
//     });
//     _controller2.addListener(() {
//       _onChanged2();
//     });
//     // _getCurrentLocation();
//     super.initState();
//     // accelerometerEvents.listen((AccelerometerEvent event) {
//     //   double acceleration = event.y; // You can use other axes as needed
//     //   sensorController.currentAcceleration.value = acceleration;
//     //   if ((previousAcceleration - acceleration) >= threshold) {
//     //     // Harsh braking detected, take action here
//     //     print('Harsh braking detected!');
//     //     print('Please drive slowly!');
//     //     sensorController.isHarshBraking.value = true;
//     //     _showHarshBrakingDialog(); // Show dialog box when harsh braking is detected
//     //   } else {
//     //     sensorController.isHarshBraking.value = false;
//     //   }
//     //   previousAcceleration = acceleration;
//     // });
//     //setCustomMarker();
//   }
//
//   @override
//   void dispose() {
//     _locationController.dispose();
//     _destinationController.dispose();
//
//     accelerometerEvents.drain();
//
//     super.dispose();
//   }
//
//   void _addMarker(LatLng position) {
//     setState(() async {
//       _markers.clear();
//       _markers.add(Marker(
//         markerId: MarkerId(position.toString()),
//         position: position,
//         icon: await getCustomMarkerIcon('assets/human_marker.jpg'),
//       ));
//     });
//   }
//
//   void _showHarshBrakingDialog() {
//     if (flag) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Harsh Braking Detected'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.warning,
//                   color: Colors.red,
//                   size: 48,
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Please drive slowly!',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   _onChanged() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(_controller.text, true);
//   }
//
//   _onChanged2() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(_controller2.text, false);
//   }
//
//   void getSuggestion(String input, bool isDest) async {
//     String kPLACES_API_KEY = FlutterConfig.get('MAPS_API_KEY');
//     String type = '(regions)';
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
//     var response = await http.get(Uri.parse(request));
//     if (response.statusCode == 200) {
//       setState(() {
//         // String textResponse =jsonDecode(response.body);
//         if (isDest) {
//           _placeList2 = jsonDecode(response.body)['predictions'];
//         } else {
//           _placeList = jsonDecode(response.body)['predictions'];
//         }
//         // if(isDest){
//         //   if (_placeList['result'] != null &&
//         //       _placeList['result']['geometry'] != null &&
//         //       _placeList['result']['geometry']['location'] != null) {
//         //     double latitude = _placeList['result']['geometry']['location']['lat'];
//         //     double longitude = _placeList['result']['geometry']['location']['lng'];
//         //   }
//         // }
//       });
//     } else {
//       throw Exception('Failed to load predictions');
//     }
//   }
//
//   void _showCoordinates(String placeName) async {
//     try {
//       var locations = await locationFromAddress(placeName);
//       if (locations.isNotEmpty) {
//         final LatLng position =
//             LatLng(locations.first.latitude, locations.first.longitude);
//         _addMarker(position);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Location not found!'),
//         ));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error: $e'),
//       ));
//     }
//   }
//   // void setCustomMarker(){
//   //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((icon) {
//   //     sourceIcon = icon;
//   //   });
//   //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((icon) {
//   //     destIcon = icon;
//   //   });
//   //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((icon) {
//   //     currLocIcon = icon;
//   //   });
//   // }
//
//   void _launchMapsUrl() async {
//     final String googleMapsUrl = "https://www.google.com/maps/dir/?api=1";
//     final String waypoints = polyLineCoordinates
//         .map((point) => "${point.latitude},${point.longitude}")
//         .join("|");
//     final String origin =
//         "${polyLineCoordinates.first.latitude},${polyLineCoordinates.first.longitude}";
//     final String destination =
//         "${destLocation.latitude},${destLocation.longitude}";
//     final String finalUrl =
//         "$googleMapsUrl&origin=$origin&destination=$destination&waypoints=$waypoints&travelmode=driving&dir_action=navigate";
//
//     if (await canLaunch(finalUrl)) {
//       await launch(finalUrl);
//     } else {
//       throw 'Could not launch $finalUrl';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.only(bottom: 20.0),
//           child: FloatingActionButton.extended(
//             onPressed: () {
//               String location = _locationController.text;
//               String destination = _destinationController.text;
//               _showCoordinates(location);
//               _showCoordinates(destination);
//               getPolyPoints();
//               _launchMapsUrl();
//             },
//             label: Text(
//               'Start journey',
//               style: GoogleFonts.outfit(),
//             ),
//             icon: SvgPicture.asset(
//               'lib/assets/images/mapsArrow.svg',
//               height: 24,
//               width: 24,
//               color: Colors.white,
//             ),
//             backgroundColor: Colors.blue,
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         body: Stack(children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: _currentLocation != null
//                 ? CameraPosition(
//                     target: LatLng(
//                         _currentLocation.latitude, _currentLocation.longitude),
//                     zoom: 14.0,
//                   )
//                 : const CameraPosition(
//                     target: LatLng(28.59351217640707, 77.24437040849519),
//                     zoom: 14.0,
//                   ),
//             polylines: {
//               Polyline(
//                   polylineId: const PolylineId("route"),
//                   points: polyLineCoordinates,
//                   color: Theme.of(context).colorScheme.primary,
//                   width: 6)
//             },
//             markers: {
//               Marker(
//                 markerId: const MarkerId("current location"),
//                 position: _currentLocation,
//               ),
//               Marker(
//                 markerId: const MarkerId("destination"),
//                 position: destLocation,
//               ),
//               if (polyLineCoordinates.isNotEmpty)
//                 Marker(
//                   markerId: const MarkerId("safest route"),
//                   position:
//                       polyLineCoordinates[polyLineCoordinates.length ~/ 2],
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                       BitmapDescriptor.hueGreen),
//                   infoWindow: const InfoWindow(
//                     title: "Safest Route",
//                   ),
//                 ),
//             },
//             myLocationEnabled: true,
//           ),
//           if (_isLoading)
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black
//                     .withOpacity(0.5), // Semi-transparent black background
//                 child: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//           Positioned(
//               top: 0,
//               right: 0,
//               left: 0,
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: _controller2,
//                       decoration: InputDecoration(
//                         hintText: "Search start location",
//                         hintStyle: GoogleFonts.outfit(),
//                         focusColor: Colors.white,
//                         fillColor: Theme.of(context).colorScheme.secondary,
//                         filled: true,
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Theme.of(context).colorScheme.primary),
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Theme.of(context).colorScheme.primary),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         prefixIcon: const Icon(Icons.add_location_alt),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             _controller2.clear();
//                           },
//                           icon: const Icon(Icons.cancel),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     _placeList.isEmpty
//                         ? SizedBox()
//                         : Container(
//                             height: 100,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(18),
//                                 color: Color(0xffE4F3EC)),
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: _placeList.length,
//                               itemBuilder: (context, index) {
//                                 return ListTile(
//                                   onTap: () {
//                                     // Set the selected item in the text field
//                                     setState(() {
//                                       _controller2.text =
//                                           _placeList[index]["description"];
//                                       _placeList.clear();
//                                     });
//                                   },
//                                   title: Text(_placeList[index]["description"]),
//                                 );
//                               },
//                             ),
//                           ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Obx(
//                       () => Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Visibility(
//                               visible: sensorController.isHarshBraking.value,
//                               child: const Text(
//                                 "Harsh Braking",
//                                 style:
//                                     TextStyle(fontSize: 22, color: Colors.red),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         hintText: "Search destination location",
//                         hintStyle: GoogleFonts.outfit(),
//                         focusColor: Colors.white,
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         fillColor: Theme.of(context).colorScheme.secondary,
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Theme.of(context).colorScheme.primary),
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Theme.of(context).colorScheme.primary),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         prefixIcon: const Icon(Icons.map),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             _controller.clear();
//                           },
//                           icon: const Icon(Icons.cancel),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     _placeList2.isEmpty
//                         ? SizedBox()
//                         : Container(
//                             height: 100,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(18),
//                                 color: Color(0xffE4F3EC)),
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: _placeList2.length,
//                               itemBuilder: (context, index) {
//                                 return ListTile(
//                                   onTap: () {
//                                     // Set the selected item in the text field
//                                     setState(() {
//                                       _controller.text =
//                                           _placeList2[index]["description"];
//                                       _placeList.clear();
//                                     });
//                                   },
//                                   title:
//                                       Text(_placeList2[index]["description"]),
//                                 );
//                               },
//                             ),
//                           ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(18),
//                         color: Theme.of(context).colorScheme.secondary,
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           style: GoogleFonts.outfit(
//                               color: Colors.black, fontSize: 16),
//                           value: _selectedTravelMethod,
//                           hint: Text("Select travel method"),
//                           items: <String>['Driving', 'Walking']
//                               .map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           buttonStyleData: ButtonStyleData(
//                             padding: EdgeInsets.symmetric(horizontal: 3),
//                             width: 180,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18),
//                               color: Color(0xffFEECEB),
//                             ),
//                             elevation: 2,
//                           ),
//                           iconStyleData: const IconStyleData(
//                             iconSize: 24,
//                             iconDisabledColor: Colors.black26,
//                             iconEnabledColor: Colors.black,
//                           ),
//                           dropdownStyleData: DropdownStyleData(
//                             maxHeight: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18),
//                               color: Color(0xffFEECEB),
//                             ),
//                             scrollbarTheme: ScrollbarThemeData(
//                               radius: const Radius.circular(40),
//                               thickness: MaterialStateProperty.all(6),
//                               thumbVisibility: MaterialStateProperty.all(true),
//                             ),
//                             elevation: 8,
//                           ),
//                           menuItemStyleData: const MenuItemStyleData(
//                             height: 40,
//                             padding: EdgeInsets.only(left: 14, right: 14),
//                           ),
//                           onChanged: (String? newValue) {
//                             if (newValue == 'Driving') {
//                               if (!flag) {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: Text(
//                                             "Turn on accident prevention?"),
//                                         content: Text(
//                                             "Accident prevention detects and warns about harsh brakes, and thus keeps you safe during driving"),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             onPressed: () {
//                                               setState(() {
//                                                 flag = true;
//                                                 _selectedTravelMethod =
//                                                     'driving';
//                                                 // ScaffoldMessenger.of(context)
//                                                 //     .showSnackBar(SnackBar(
//                                                 //     content: Text(
//                                                 //         'Accident prevention turned on')));
//                                               });
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("Yes"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               // Cancel action
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("Cancel"),
//                                           ),
//                                         ],
//                                       );
//                                     });
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                         content: Text(
//                                             'Already turned prevention on!')));
//                               }
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                   content: Text(
//                                       'Switched to walking, Turned off prevention')));
//                               setState(() {
//                                 flag = false;
//                                 _selectedTravelMethod = 'Walking';
//                                 // ScaffoldMessenger.of(context)
//                                 //     .showSnackBar(SnackBar(
//                                 //     content: Text(
//                                 //         'Accident prevention turned on')));
//                               });
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ]));
//   }
// }
//
// class SensorController extends GetxController {
//   var currentAcceleration = 0.0.obs;
//   RxBool isHarshBraking = false.obs;
// }
//
// // class MyHomePage extends StatefulWidget {
// //   MyHomePage({Key key, this.title}) : super(key: key);
// //
// //   final String title;
// //
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
