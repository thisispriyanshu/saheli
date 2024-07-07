import 'dart:async';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_autocomplete_field/map_autocomplete_field.dart';
import 'package:Saheli/AudioRecorder/screens/home_screen/audioplayer.dart';
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
  late String _selectedTravelMethod='walking';
  late String _selectedStart='Select Start Location';
  late String _selectedEnd='Select End Location';
  double threshold = 5.0; // Adjust this threshold as needed
  final sensorController = Get.put(SensorController());

  final mapsApiKey = FlutterConfig.get('MAPS_API_KEY');
  late GoogleMapController mapController;
  var _controller = TextEditingController();
  var _controller2 = TextEditingController();
  late String drivingMode;
  var uuid = new Uuid();
  String _sessionToken = "";
  int _countdown = 60;
  Timer? _timer;
  bool _isBottomSheetVisible = false;
  late Function sheetSetState;
  List<dynamic> _placeList = [];
  List<dynamic> _placeList2 = [];

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

  AlertTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _countdown--);
      sheetSetState(() {
        // No need to calculate duration here, just assign _countdown directly
        final seconds = Duration().inSeconds + _countdown;
        Duration() = Duration(seconds: seconds);
      });
      if (_countdown == 0) {
        _timer!.cancel();
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AudioPlayer()),
        );
      }
    });
  }

  void showBottomSheet() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            sheetSetState = setState; // Initialize sheetSetState
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Safety assurance mode activated!",
                      style: GoogleFonts.outfit(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "Are you safe?",
                      style: GoogleFonts.outfit(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.tertiary,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            value: _countdown / 60),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _countdown.toString(),
                            style: GoogleFonts.outfit(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          backgroundColor:
                          Theme.of(context).colorScheme.tertiary),
                      onPressed: () {
                        _timer!.cancel();
                        Navigator.pop(context);
                        //_isBottomSheetVisible = false;
                      },
                      child: Text(
                        'Yes',
                        style: GoogleFonts.outfit(
                            color: Colors.black54, fontSize: 18),
                      )),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AudioPlayer()));
                      },
                      child: Text(
                        'No',
                        style: GoogleFonts.outfit(
                            color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            );
          });
        },
      );
    });
  }

  @override
  void initState() {
    // _getCurrentLocation();
    super.initState();
    _countdown=60;
    accelerometerEvents.listen((AccelerometerEvent event) {
      double acceleration = event.y; // You can use other axes as needed
      sensorController.currentAcceleration.value = acceleration;
      if ((previousAcceleration - acceleration) >= threshold) {
        // Harsh braking detected, take action here

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
                  AlertTimer();
                  showBottomSheet();
                  // AlertDialog();
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
            icon: Icon(Icons.navigation),
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
              Obx(
                () => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: sensorController.isHarshBraking.value,
                        child: const Text(
                          "Harsh Braking",
                          style:
                              TextStyle(fontSize: 22, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 3,
              ),

              Positioned(
                top: 10,
                right: 15,
                left: 15,

                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: MapAutoCompleteField(
                          // cursorColor: Colors.black,
                          // keyboardType: TextInputType.text,
                          // textInputAction: TextInputAction.go,
                          controller: _locationController,
                          inputDecoration: InputDecoration(
                            hintText: "Search start location",
                            hintStyle: GoogleFonts.outfit(),
                            focusColor: Colors.white,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.tertiary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _locationController.clear();
                              },
                              icon: const Icon(Icons.cancel),
                            ),
                          ),
                          googleMapApiKey: FlutterConfig.get("MAPS_API_KEY"),
                          // controller: addressCtrl,
                          itemBuilder: (BuildContext context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.description),
                            );
                          },
                          onSuggestionSelected: (suggestion) async {
                            List<loc.Location> startloc = await locationFromAddress(_locationController.text);
                            loc.Location firstLocation = startloc[0];

                            _currentLocation = LatLng(firstLocation.latitude, firstLocation.longitude);
                            _locationController.text = suggestion.description;

                          },
                        ),
                      ),

                    ],
                  ),

              ),
              Positioned(
                top: 80,
                right: 15,
                left: 15,

                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child:
                        MapAutoCompleteField(
                          // cursorColor: Colors.black,
                          // keyboardType: TextInputType.text,
                          // textInputAction: TextInputAction.go,
                          controller: _destinationController,
                          inputDecoration: InputDecoration(
                            hintText: "Search destination location",
                            hintStyle: GoogleFonts.outfit(),
                            focusColor: Colors.white,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.tertiary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.map),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _destinationController.clear();
                              },
                              icon: const Icon(Icons.cancel),
                            ),
                          ),
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
    ),




                    ],
                  ),

              ),
              Positioned(
              top: 150,
              left: 55,
              right: 55,

              child: Container(
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
                    items: ['driving', 'walking']
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

                      if (newValue == 'driving') {
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
                          _selectedTravelMethod = 'walking';
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


            ]));
  }
}


