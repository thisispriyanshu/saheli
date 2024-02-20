//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_places_picker_refractored/google_maps_places_picker_refractored.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// class TextSrea extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   final mapsApiKey = "AIzaSyBAC_OF_lWBfFr_Zjs-mO0Kwyr4f_faiMU";
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   PickResult? selectedPlace;
//
//   LatLng _currentLocation = const LatLng(28.59351217640707, 77.24437040849519);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Map Places Picker Refractored Demo'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 child: const Text("Load Google Map"),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return Scaffold(
//                           appBar: AppBar(
//                             title: const Text(
//                                 'Google Map Places Picker Refractored Demo'),
//                           ),
//                           body: PlacePicker(
//                             apiKey: '',
//                             useCurrentLocation: true,
//                             selectInitialPosition: true,
//                             // isInScaffoldBodyAndHasAppBar: false,
//                             // border: OutlineInputBorder(),
//                             // enabledBorder: OutlineInputBorder(),
//                             height: 40.0,
//                             // borderRadius: BorderRadius.circular(5.0),
//                             //usePlaceDetailSearch: true,
//                             onPlacePicked: (result) {
//                               selectedPlace = result;
//                               Navigator.of(context).pop();
//                               setState(() {});
//                             },
//                             //forceSearchOnZoomChanged: true,
//                             automaticallyImplyAppBarLeading: false,
//                             initialPosition: _currentLocation,
//                             //autocompleteLanguage: "ko",
//                             //region: 'au',
//                             //selectInitialPosition: true,
//                             // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
//                             //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
//                             //   return isSearchBarFocused
//                             //       ? Container()
//                             //       : FloatingCard(
//                             //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
//                             //           leftPosition: 0.0,
//                             //           rightPosition: 0.0,
//                             //           width: 500,
//                             //           borderRadius: BorderRadius.circular(12.0),
//                             //           child: state == SearchingState.Searching
//                             //               ? Center(child: CircularProgressIndicator())
//                             //               : RaisedButton(
//                             //                   child: Text("Pick Here"),
//                             //                   onPressed: () {
//                             //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
//                             //                     //            this will override default 'Select here' Button.
//                             //                     print("do something with [selectedPlace] data");
//                             //                     Navigator.of(context).pop();
//                             //                   },
//                             //                 ),
//                             //         );
//                             // },
//                             // pinBuilder: (context, state) {
//                             //   if (state == PinState.Idle) {
//                             //     return Icon(Icons.favorite_border);
//                             //   } else {
//                             //     return Icon(Icons.favorite);
//                             //   }
//                             // },
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//               selectedPlace == null
//                   ? Container()
//                   : Text(selectedPlace?.formattedAddress ?? ""),
//             ],
//           ),
//         ));
//   }
// }