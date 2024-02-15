import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:saheli_app/api/safeRoute.dart';

class SafeRoutes extends StatefulWidget {
  const SafeRoutes({super.key});

  @override
  State<SafeRoutes> createState() => _SafeRoutesState();
}

class _SafeRoutesState extends State<SafeRoutes> {
  final mapsApiKey = "AIzaSyBAC_OF_lWBfFr_Zjs-mO0Kwyr4f_faiMU";
  late GoogleMapController mapController;

  LatLng _currentLocation = const LatLng(28.59351217640707, 77.24437040849519);
  List<LatLng> polyLineCoordinates = [];
  final LatLng destLocation = const LatLng(28.656948267717762, 77.24093718110075 );

    

  void _getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((value) {
      _currentLocation = LatLng(value.latitude!, value.longitude!);
      print("Current Location - ${_currentLocation}");
    });
    location.onLocationChanged.listen((newLoc) {
      _currentLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 14, target: LatLng(newLoc.latitude!, newLoc.longitude!))));
      setState(() {});
    });
  }

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
    List steps = await makeSafeRouteRequest(_currentLocation, destLocation, "driving");
    if(steps.isNotEmpty){
      steps.forEach((step) {
        polyLineCoordinates.add(LatLng(step['end_location']['lat'], step['end_location']['lng']));
      });
      setState(() {});
    }
    print(polyLineCoordinates);
  }

  @override
  void initState() {
    _getCurrentLocation();
    getPolyPoints();
    //setCustomMarker();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                color: Colors.blue,
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
          },
          myLocationEnabled: true,
        ),
        // Positioned(
        //       left: 10,// you can change place of search bar any where on the map
        //       child: ElevatedButton(
        //           onPressed: _handleSearch,
        //           child: Text('search')),
        //     )
        ]
      )
    );
  }
}