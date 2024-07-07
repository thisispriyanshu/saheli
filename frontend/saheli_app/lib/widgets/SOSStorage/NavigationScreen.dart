import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Saheli/widgets/SOSStorage/SubmitForm.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as webGM;

class MapPicker extends StatefulWidget {
  static const DEFAULT_ZOOM = 14.4746;
  static const KINSHASA_LOCATION = LatLng(-4.325, 15.322222);

  double initZoom;
  LatLng initCoordinates;

  LatLng? value;

  MapPicker(
      {Key? key,
      this.initZoom = DEFAULT_ZOOM,
      this.initCoordinates = KINSHASA_LOCATION})
      : super(key: key);

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            _openFormScreen(context);
          },
          label: Text('Select Location'),
          icon: Icon(Icons.location_on),
          backgroundColor: Colors.blue,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text(
          'Select location',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w400, fontSize: 20),
        ),
      ),
      body: Center(
        child: SizedBox(
          // width: 400,
          child: LayoutBuilder(
            builder: (context, constraints) {
              var maxWidth = constraints.biggest.width;
              var maxHeight = constraints.biggest.height;

              return Column(
                children: [
                  Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 700,
                        width: maxWidth,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: widget.initCoordinates,
                            zoom: widget.initZoom,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          onCameraMove: (CameraPosition newPosition) {
                            setState(() {
                              _selectedLocation = newPosition.target;
                            });

                            widget.value = newPosition.target;
                          },
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: false,
                          zoomGesturesEnabled: true,
                          padding: const EdgeInsets.all(0),
                          buildingsEnabled: true,
                          cameraTargetBounds: CameraTargetBounds.unbounded,
                          compassEnabled: true,
                          indoorViewEnabled: false,
                          mapToolbarEnabled: true,
                          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                          rotateGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          tiltGesturesEnabled: true,
                          trafficEnabled: false,
                        ),
                      ),
                      Positioned(
                        bottom: maxHeight / 2,
                        right: (maxWidth - 30) / 2,
                        child: Icon(
                          Icons.person_pin_circle_sharp,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      Positioned(
                        bottom: 30,
                        left: 30,
                        child: Container(
                          color: Colors.white,
                          child: IconButton(
                            onPressed: () async {
                              var position = await _determinePosition();
                              final GoogleMapController controller =
                                  await _controller.future;
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(position.latitude,
                                          position.longitude),
                                      zoom: widget.initZoom)));
                            },
                            icon: const Icon(Icons.my_location),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: maxHeight / 44,
                      //   right: (maxWidth - 56) / 2,
                      //   child: FloatingActionButton(
                      //
                      //
                      //   ),
                      // ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _openFormScreen(
    BuildContext context,
  ) async {
    if (_selectedLocation != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location fetched successfully'),
            content: Text(
                'Location selected was:  37/38, New Municipal Market, Sainath Road, Malad (west), coordinates: $_selectedLocation'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          );
        },
      );
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SafeRoutesForm(),
        ),
      );
    } else {}
  }
}
