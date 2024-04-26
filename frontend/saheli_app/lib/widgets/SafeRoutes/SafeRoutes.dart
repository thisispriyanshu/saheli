import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
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
  final Set<Marker> _markers = {};
  Future<BitmapDescriptor> getCustomMarkerIcon(String assetName) async {
    final ByteData byteData = await rootBundle.load(assetName);
    final Uint8List imageData = byteData.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(imageData);
  }
  final mapsApiKey = "AIzaSyBAC_OF_lWBfFr_Zjs-mO0Kwyr4f_faiMU";
  late GoogleMapController mapController;
  var _controller = TextEditingController();
  var _controller2 = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];

  LatLng _currentLocation = const LatLng(28.59351217640707, 77.24437040849519);
  List<LatLng> polyLineCoordinates = [];
  final LatLng destLocation =
      const LatLng(28.656948267717762, 77.24093718110075);

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

    print(polyLineCoordinates);
  }

  @override
  void initState() {
    // _getCurrentLocation();
    getPolyPoints();
    _controller.addListener(() {
      _onChanged();
    });
    _controller2.addListener(() {
      _onChanged2();
    });
    //setCustomMarker();
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _addMarker(LatLng position) {
    setState(() async {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
          icon: await getCustomMarkerIcon('assets/human_marker.jpg'),
      ));
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  _onChanged2() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller2.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyBAC_OF_lWBfFr_Zjs-mO0Kwyr4f_faiMU";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        // String textResponse =jsonDecode(response.body);
        _placeList = jsonDecode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void _showCoordinates(String placeName) async {
    try {
      var locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        final LatLng position =
            LatLng(locations.first.latitude, locations.first.longitude);
        _addMarker(position);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
    final String waypoints = polyLineCoordinates
        .map((point) => "${point.latitude},${point.longitude}")
        .join("|");
    final String origin =
        "${polyLineCoordinates.first.latitude},${polyLineCoordinates.first.longitude}";
    final String destination =
        "${destLocation.latitude},${destLocation.longitude}";
    final String finalUrl =
        "$googleMapsUrl&origin=$origin&destination=$destination&waypoints=$waypoints&travelmode=driving&dir_action=navigate";

    if (await canLaunch(finalUrl)) {
      await launch(finalUrl);
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
            label: Text(
              'Start journey',
              style: GoogleFonts.outfit(),
            ),
            icon: SvgPicture.asset(
              'lib/assets/images/mapsArrow.svg',
              height: 24,
              width: 24,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(children: [
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
                  color: Theme.of(context).colorScheme.primary,
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
                  position:
                      polyLineCoordinates[polyLineCoordinates.length ~/ 2],
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  infoWindow: const InfoWindow(
                    title: "Safest Route",
                  ),
                ),
            },
            myLocationEnabled: true,
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent black background
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     color: Theme.of(context).colorScheme.secondary,
              //     border: Border.all(
              //         color: Theme.of(context).colorScheme.primary, width: 1)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: TextField(
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
                            onPressed: () {},
                            icon: const Icon(Icons.cancel),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _placeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_placeList[index]["description"]),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            right: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     color: Theme.of(context).colorScheme.secondary,
              //     border: Border.all(
              //         color: Theme.of(context).colorScheme.primary, width: 1)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: TextField(
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
                            onPressed: () {},
                            icon: const Icon(Icons.cancel),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _placeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_placeList[index]["description"]),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
