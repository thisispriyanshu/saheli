
import 'dart:async';
import 'dart:math';

import 'package:background_sms/background_sms.dart' as sms;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saheli_app/common/widgets/customBtn.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/widgets/Chatbot/chatbot.dart';
import 'package:saheli_app/widgets/SafeRoutes/SafeHome.dart';
import 'package:saheli_app/widgets/custom_widgets/CustomCarousel.dart';
import 'package:saheli_app/widgets/custom_widgets/custom_appBar.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';
import 'package:volume_watcher/volume_watcher.dart';

import '../db/databases.dart';
import '../model/PhoneContact.dart';
import '../widgets/NearbyLocations/nearby_places.dart';
import '../widgets/emergency.dart';


class HomePage extends StatefulWidget {
  int qIndex = 0;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int qIndex = 0;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;

  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }
  late int _volumeListenerId;
  void initState() {

    super.initState();
    getRandomQuote();
    _getPermission();
    _getCurrentLocation();
    ShakeDetector.autoStart(onPhoneShake: (){ ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
        content: Text(
            'Shake ho gya')));
      getAndSendSms();},
    minimumShakeCount: 1,
    shakeSlopTimeMS: 500,
    shakeCountResetTime: 3000,
    shakeThresholdGravity: 5.0);

  }

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    sms.SmsStatus result = (await sms.BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1));
    if (result == sms.SmsStatus.sent) {
      Fluttertoast.showToast(msg: "send");
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
    final Telephony telephony = Telephony.instance;
    await telephony.requestPhoneAndSmsPermissions;
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
  getAndSendSms() async {
    List<TContact> contactList = await DatabaseHelper().getContactList();

    String messageBody =
        "https://maps.google.com/?daddr=${_curentPosition?.latitude??1.2325},${_curentPosition?.longitude?? 5.45634}";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        _sendSms("${element.number}", "i am in trouble $messageBody");
      });
    } else {
      Fluttertoast.showToast(msg: "something wrong");
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 208),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8.0, bottom: 9.0, right: 8.0),
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 57, 116),
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  child: Container(
                    color: Colors.grey.shade100,
                  ),
                ),
                SizedBox(height: 10),                CustomAppBar(
                  quoteIndex: qIndex,
                  onTap: getRandomQuote(),
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                SizedBox(
                  height: 10,
                  child: Container(
                    color: Colors.grey.shade100,
                  ),
                ),

                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 10),
                      SafeHome(),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Incase of emergency",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Emergency(),

                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Find on Map",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      LiveSafe(),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Explore Inspiring Stories",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      CustomCarouel(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }


}
