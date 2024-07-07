import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Saheli/views/home_screen.dart';
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
    Timer(const Duration(seconds: 10), () {
      setState(() {
        _captureAndSaveImage();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location Sent Successfully')));
      // _captureAndSaveImage(); // Call the function to open the camera after 3 seconds
    });
    Timer(const Duration(seconds: 20), () {
      setState(() {
        record();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Captured')));
      // record(); // Call the function to start recording after 6 seconds
    });
    Timer(const Duration(seconds: 30), () {
      setState(() {
        // buttonText = "Sent";
        if (isRecording) {
          stop();
        }
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Recorded Audio')));
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
          title: const Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text("SOS Activated"),
            ],
          ),
          content: const Text(
              "Your location has been shared with your added emergency contacts along with your location. We have also shared your emergency message with them. The recorder is now being activated automatically for investigation purpose."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // record();
              },
              child: const Text(
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
          title: const Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text("SOS Activated"),
            ],
          ),
          content: const Text(
              "Your location, images taken, audio recorded has been sent to your emergency contact. Help is on the way!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // record();
              },
              child: const Text(
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
    final snackBar1 = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Recorded SOS file at: ',
        message:
        path,
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar1);
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Recorded SOS file at: $path')));
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child('audio')
        .child('audio_${DateTime.now()}.3gp');
    final UploadTask uploadTask = ref.putFile(
      audioFile,
      SettableMetadata(contentType: 'audio/3gp'),
    );

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    });

    // Get download URL
    final url = await (await uploadTask).ref.getDownloadURL();

    // Show snackbar with URL
    final snackBar2 = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Recorder audio uploaded. URL: ',
        message:
        url,
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar2);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Recorder audio uploaded. URL: $url'),
    //   ),
    // );

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
          FirebaseStorage.instance.ref().child('images').child('image_${DateTime.now()}.mp3');
      final UploadTask uploadTask = ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      final url = await (await uploadTask).ref.getDownloadURL();
      final snackBar3 = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Captured image',
          message:
          url,
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar3);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(new SnackBar(content: Text('Captured image' + url)));
    } else {
      Fluttertoast.showToast(msg: "No image captured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SOS Mode",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'lib/assets/images/sos.jpg',
                      color: Colors.black.withOpacity(0.4),
                      colorBlendMode: BlendMode.multiply,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SOS mode turned ON',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Your location is being shared to saved emergency contacts, image and audio will be captured automatically and saved even when you're offline. \nCaptured images and audio can be accessed from profile->your sos collection",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                              fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: MyBlinkingButton(
                buttonText: statusText,
              ),
            ),
            const SizedBox(height: 20,),
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
                  style: GoogleFonts.outfit(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'STOP',
                      style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
