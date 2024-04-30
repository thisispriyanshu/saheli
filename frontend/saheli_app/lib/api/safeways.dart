import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>?> makeSafeRouteRequest(LatLng source, LatLng destination, String mode) async {
  final url = Uri.parse('https://saheli-backend-ufs3.onrender.com/safest-route');

  print('Source: $source');
  print('Destination: $destination');
  print('Mode: $mode');

  final response = await http.post(
    url,
    body: jsonEncode({
      'source': "${source.latitude},${source.longitude}",
      'destination': "${destination.latitude},${destination.longitude}",
      'mode': mode,
    }),
    headers: {'Content-Type': 'application/json'}, // Specify JSON content type
  );

  if (response.statusCode == 200) {
    // Request successful
    final body = jsonDecode(response.body);
    print('Safe route request successful');

    // Extract and return the steps from the response
    return body[0]['legs'][0]['steps']; // Assuming there's only one leg
  } else {
    // Request failed
    print('Safe route request failed: ${response.body}');
    return null; // Return null or handle the error as needed
  }
}








// import 'dart:async';
// import 'dart:convert';
// import 'dart:convert';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// // Function to fetch user profile photo URL from Firebase Authentication
// Future<String?> fetchUserProfilePhotoUrl() async {
//   final User? user = FirebaseAuth.instance.currentUser;
//   if (user != null && user.photoURL != null) {
//     return user.photoURL!;
//   } else {
//     return null;
//   }
// }
//
// // Function to make a safe route request
// Future<List<dynamic>?> makeSafeRouteRequest(
//     double sourcelat, double sourcelong, double destlat, double destlong, String mode) async {
//   final url = Uri.parse('https://saheli-backend-ufs3.onrender.com/safest-route');
//   final response = await http.post(
//     url,
//     body: {
//       'source': '$sourcelat,$sourcelong',
//       'destination': '$destlat,$destlong',
//       'mode': mode,
//     },
//   );
//   print('Source: $sourcelat, $sourcelong');
//   print('Destination: $destlat, $destlong');
//   print('Mode: $mode');
//
//   if (response.statusCode == 200) {
//     List<dynamic> body = jsonDecode(response.body);
//     print('Safe route request successful');
//     return body[0]['legs'][0]['steps'];
//   } else {
//     print('Safe route request failed ${response.statusCode}');
//     return null;
//   }
//
//
//   // final response = await http.post(
//   //   url,
//   //   body: jsonEncode({
//   //     'source': {'lat': source.latitude, 'lng': source.longitude},
//   //     'destination': {'lat': destination.latitude, 'lng': destination.longitude},
//   //     'mode': mode,
//   //   }),
//   //   headers: {'Content-Type': 'application/json'},
//   // );
//   //
//   // if (response.statusCode == 200) {
//   //   final body = jsonDecode(response.body);
//   //   print('Safe route request successful');
//   //   return body['safestRoute']['legs'][0]['steps'];
//   // } else {
//   //   print('Safe route request failed ${response.statusCode}');
//   //   return null;
//   // }
// }
//
// class SafeRouteMapWithCustomMarker extends StatefulWidget {
//   @override
//   _SafeRouteMapWithCustomMarkerState createState() =>
//       _SafeRouteMapWithCustomMarkerState();
// }
//
// class _SafeRouteMapWithCustomMarkerState
//     extends State<SafeRouteMapWithCustomMarker> {
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = {};
//   List<LatLng> _polylineCoordinates = [];
//
//   LocationData? _currentLocation;
//   Location _location = Location();
//   LatLng _sourceLocation = LatLng(37.42796133580664, -122.085749655962);
//   LatLng _destination = LatLng(37.43206904117217, -122.08415906260109);
//
//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//     _loadUserProfilePhotoUrl();
//     _loadCustomMarkers();
//   }
//
//   Future<void> _getUserLocation() async {
//     try {
//       _currentLocation = await _location.getLocation();
//       setState(() {
//         _sourceLocation =
//             LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
//       });
//     } catch (e) {
//       print('Could not get the location: $e');
//     }
//   }
//
//   Future<void> _loadUserProfilePhotoUrl() async {
//     final userProfilePhotoUrl = await fetchUserProfilePhotoUrl();
//     setState(() {
//       _addUserMarker(userProfilePhotoUrl);
//     });
//   }
//
//   void _addUserMarker(String? userProfilePhotoUrl) async {
//     _markers.clear();
//     _markers.add(
//       Marker(
//         markerId: MarkerId("source"),
//         position: _sourceLocation,
//         icon: userProfilePhotoUrl != null
//             ? await BitmapDescriptor.fromAssetImage(userProfilePhotoUrl as ImageConfiguration, userProfilePhotoUrl) // Use profile photo as marker icon
//             : BitmapDescriptor.defaultMarker,
//       ),
//     );
//     _markers.add(
//       Marker(
//         markerId: MarkerId("destination"),
//         position: _destination,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       ),
//     );
//   }
//
//   Future<void> _loadCustomMarkers() async {
//     final List<String> images = [
//       'images/car.png',
//       'images/car2.png',
//       'images/marker2.png',
//       'images/marker3.png',
//       'images/marker.png',
//       'images/motorcycle.png',
//     ];
//
//     for (int i = 0; i < images.length; i++) {
//       final Uint8List markerIcon =
//       await getBytesFromAsset(images[i].toString(), 100);
//       _markers.add(
//         Marker(
//           markerId: MarkerId(i.toString()),
//           position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
//           icon: BitmapDescriptor.fromBytes(markerIcon),
//           infoWindow: InfoWindow(
//             title: 'The title of the marker',
//           ),
//         ),
//       );
//     }
//     setState(() {});
//   }
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec =
//     await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(33.6910, 72.98072),
//     zoom: 15,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           initialCameraPosition: _kGooglePlex,
//           mapType: MapType.normal,
//           myLocationButtonEnabled: true,
//           myLocationEnabled: true,
//           markers: Set<Marker>.of(_markers),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         ),
//       ),
//     );
//   }
// }
