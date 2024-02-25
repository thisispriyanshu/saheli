import 'dart:async';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../db/databases.dart';
import '../../model/PhoneContact.dart';
class CallerScreen extends StatefulWidget {
  @override
  State<CallerScreen> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<CallerScreen> {
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;

  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SOS message sent successfully')));
      Fluttertoast.showToast(msg: "SOS Message Sent");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }
  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }


  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
        "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  static const routeName = '/CallerScreen';
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    // String name = args['name'];
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(35.0, 70.0, 35.0, 0.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor:Colors.grey,
              radius: 40,
              child: Text(
                'Apoorv',
                style: GoogleFonts.lato(),

              ),
            ),
            const SizedBox(
              height: 5.0,
            ), //CircleAvatar
            Text(
             'Yash',
              style: GoogleFonts.lato(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5.0,
            ),
            TickingTimer(),
            const Expanded(
              child: SizedBox(
                height: 1.0,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe3e5, fontFamily: 'MaterialIcons'),
                        size: 45.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Mute",
                        style: GoogleFonts.lato(),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed:
                          () async {
                            String recipients = "";
                            List<TContact> contactList =
                                await DatabaseHelper().getContactList();
                            print(contactList.length);
                            if (contactList.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "emergency contact is empty");
                            } else {
                              String messageBody ="";
                                  // "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";

                              if (await _isPermissionGranted()) {
                                Fluttertoast.showToast(msg: "Emergency SOS Sent to emergency contacts");
                          // contactList.forEach((element) {
                          // _sendSms("${element.number}"

                          // "I am in trouble! $messageBody This message is sent from Saheli App");
                          // });
                          } else {
                          Fluttertoast.showToast(msg: "something wrong");
                          }
                        }

                        },
                        child: const Icon(
                          IconData(0xe1ce, fontFamily: 'MaterialIcons'),
                          size: 30.0,
                        ),
                        style: ElevatedButton.styleFrom(

                          padding: const EdgeInsets.all(24),
                        ),
                      ),
                      // const Icon(
                      //   IconData(0xe1ce, fontFamily: 'MaterialIcons'),
                      //   size: 45.0,
                      // ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Keypad",
                        style: GoogleFonts.lato(),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe6c5, fontFamily: 'MaterialIcons'),
                        size: 48.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Speaker",
                        style: GoogleFonts.lato(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe04d, fontFamily: 'MaterialIcons'),
                        size: 45.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Add Call",
                        style:GoogleFonts.lato(),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe47d, fontFamily: 'MaterialIcons'),
                        size: 50.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Hold",
                        style: GoogleFonts.lato(),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe503, fontFamily: 'MaterialIcons'),
                        size: 50.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Record",
                        style: GoogleFonts.lato(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Icon(
                IconData(0xe127, fontFamily: 'MaterialIcons'),
                size: 30.0,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                primary: Colors.red,
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }

}

class TickingTimer extends StatefulWidget {
  @override
  _TickingTimerState createState() => _TickingTimerState();
}

class _TickingTimerState extends State<TickingTimer> {
  int _intMin = 0;
  int _intSec = 00;
  String _seconds = "00";
  String _minutes = "0";
  late Timer _callTimer;

  void _startTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_intSec < 9) {
        setState(() {
          _intSec++;
          _seconds = "0$_intSec";
        });
      } else if (_intSec == 59) {
        setState(() {
          _intSec = 0;
          _intMin++;
          _seconds = "0$_intSec";
          _minutes = "$_intMin";
        });
      } else {
        setState(() {
          _intSec++;
          _seconds = "$_intSec";
        });
      }
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _callTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$_minutes:$_seconds",
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
    );
  }
}
