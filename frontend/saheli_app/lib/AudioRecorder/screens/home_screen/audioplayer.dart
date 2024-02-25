import 'dart:async';
import 'dart:io';

import 'package:background_sms/background_sms.dart' as sms;
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:background_sms/background_sms.dart';
import 'package:background_sms/background_sms.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saheli_app/views/home_screen.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import '../../../db/databases.dart';
import '../../../model/PhoneContact.dart';
import '../../../views/BlinkingButton.dart';
import '../../../widgets/bottomNavBar.dart';

class AudioPlayer extends StatefulWidget {
  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isRecording = false;
  bool isUploading = false;
  double uploadProgress = 0.0;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  String statusText = "Sending Location";

  late int _volumeListenerId;
  void initState() {
    super.initState();
    initRecorder();
    _getPermission();
    _getCurrentLocation();
    Timer(Duration(seconds: 10), () {
      setState(() {
        _captureAndSaveImage();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Location Sent Successfully')));
      // _captureAndSaveImage(); // Call the function to open the camera after 3 seconds
    });
    Timer(Duration(seconds: 20), () {
      setState(() {
        record();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image Captured')));
      // record(); // Call the function to start recording after 6 seconds
    });
    Timer(Duration(seconds: 30), () {
      setState(() {
        // buttonText = "Sent";
        if (isRecording) {
          stop();
        }
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Recorded Audio')));
      // record(); // Call the function to start recording after 6 seconds
    });
    isRecording = false;
    getAndSendSms();
  }

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    // sms.SmsStatus result = (await sms.BackgroundSms.sendMessage(
    //     phoneNumber: phoneNumber, message: message, simSlot: 1));
    // if (result == sms.SmsStatus.sent) {
    // Fluttertoast.showToast(msg: "send");
    _showSOSDialog();

    // } else {
    //   Fluttertoast.showToast(msg: "failed");
    // }
  }

  void _showSOSDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text("SOS Activated"),
            ],
          ),
          content: Text(
              "Your location has been shared with your added emergency contacts along with your location. We have also shared your emergency message with them. The recorder is now being activated automatically for investigation purpose."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // record();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text("SOS Activated"),
            ],
          ),
          content: Text(
              "Your location, images taken, audio recorded has been sent to your emergency contact. Help is on the way!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // record();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
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
        "https://maps.google.com/?daddr=${_curentPosition?.latitude ?? 1.2325},${_curentPosition?.longitude ?? 5.45634}";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        _sendSms("${element.number}",
            "I am in trouble! $messageBody This message is sent from Saheli App");
      });
    } else {
      Fluttertoast.showToast(msg: "something wrong");
    }
  }

  @override
  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    setState(() {
      isRecorderReady = true;
    });
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> record() async {
    if (!isRecorderReady) return;

    setState(() {
      isRecording = true;
    });

    await recorder.startRecorder(toFile: 'audio');
  }

  Future<void> stop() async {
    if (!isRecorderReady || !isRecording) return;

    setState(() {
      isRecording = false;
      isUploading = true;
    });

    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Recorded SOS file at: $path')));
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child('audio')
        .child('audio_${DateTime.now()}.mp3');
    final UploadTask uploadTask = ref.putFile(
      audioFile,
      SettableMetadata(contentType: 'audio/mp3'),
    );

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    });

    // Get download URL
    final url = await (await uploadTask).ref.getDownloadURL();

    // Show snackbar with URL
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recorder audio uploaded. URL: $url'),
      ),
    );

    setState(() {
      isUploading = false;
      uploadProgress = 0.0;
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  void _captureAndSaveImage() async {
    ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      final File file = File(image.path);
      final Reference ref =
          FirebaseStorage.instance.ref().child('images').child(image.path);
      final UploadTask uploadTask = ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      // Get download URL
      final url = await (await uploadTask).ref.getDownloadURL();
    } else {
      Fluttertoast.showToast(msg: "No image captured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text(
          "SOS Mode",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "SOS mode turned ON, now your location is being shared to saved emergency contacts, image and audio will be captured automatically and saved even when you're offline. \nCaptured images and audio can be accessed from profile->your sos collection" ,
                  style: TextStyle(fontSize: 18),
                ).animate().fadeIn(),
              ),
            ),
            SizedBox(
              height: 120.0,
            ),
            Center(
              child: MyBlinkingButton(
                buttonText: statusText,
              ),
            ),
            StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                final twoDigits = (int n) => n.toString().padLeft(2, '0');
                final twoDigitMinutes =
                    twoDigits(duration.inMinutes.remainder(60));
                final twoDigitSeconds =
                    twoDigits(duration.inSeconds.remainder(60));
                return Text(
                  '$twoDigitMinutes:$twoDigitSeconds',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                );
              },
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 100.0,
                  ),
                  // ElevatedButton(
                  //   style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),),
                  //   onPressed: () async {
                  //     if (isRecording) {
                  //       await stop();
                  //     } else {
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recording started')));
                  //       await record();
                  //     }
                  //   },
                  //   child: isRecording?  Icon(
                  //
                  //     Icons.stop,
                  //     size: 40,
                  //     color: Colors.redAccent,
                  //   ): Text('Record more', style: TextStyle(color: Colors.white),),),
                  // ElevatedButton(
                  //
                  //   style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),),
                  //
                  //   onPressed: () async {
                  //       _captureAndSaveImage();
                  //   },
                  //   child:Text('Capture More Images', style: TextStyle(color: Colors.white),),
                  // ),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(80.0, 50.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      );
                    },
                    child: Text(
                      'STOP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
