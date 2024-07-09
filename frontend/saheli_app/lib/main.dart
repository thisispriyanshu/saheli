import 'dart:async';
import 'package:Saheli/views/addUserDetails.dart';
import 'package:android_physical_buttons/android_physical_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Saheli/services/localDb/localDb.dart';
import 'package:Saheli/views/OnboardingScreen.dart';
import 'package:Saheli/views/googleSignIn.dart';
import 'package:Saheli/views/home_screen.dart';
import 'package:Saheli/views/login.dart';
import 'package:Saheli/widgets/bottomNavBar.dart';
import 'package:shake/shake.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AudioRecorder/screens/home_screen/cubit/record/record_cubit.dart';
import 'AudioRecorder/screens/recordings_list/cubit/files/files_cubit.dart';
import 'FakeCaller/screens/caller_screen.dart';
import 'FakeCaller/screens/incoming_call.dart';
import 'common/theme/theme.dart';
import 'firebase_options.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
// List<Permission> statuses = [
//   Permission.audio,
//   Permission.location,
//   Permission.camera,
//   Permission.sms,
//   Permission.storage,
//   Permission.contacts
// ];
// Future<void> requestPermission() async {
//   try {
//     for (var element in statuses) {
//       if ((await element.status.isDenied ||
//           await element.status.isPermanentlyDenied)) {
//         await statuses.request();
//       }
//     }
//   } catch (e) {
//     debugPrint('$e');
//   } finally {
//     await requestPermission();
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  //await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // try{
  //   final url = Uri.parse(
  //       'https://saheli-backend-ufs3.onrender.com/safest-route');
  //   final requestBody = {
  //     "source": "28.8162605,77.1306592",
  //     "destination": "28.550121, 77.1866867",
  //     "mode": "driving",
  //   };
  //   print(requestBody.toString());
  //
  //   final response = await http.post(
  //     url,
  //     body: {
  //       "source": "28.8162605,77.1306592",
  //       "destination": "28.550121, 77.1866867",
  //       "mode": "driving",
  //     }
  //   );
  //   debugPrint("res: ${response.body.toString()}");
  // } catch(e) {
  //   print("error $e");
  // }
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
        //builder: (context) => MyApp(),
        builder: (context) => MaterialApp(
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            debugShowCheckedModeBanner: false,
            home: MyApp(),
            routes: {'/CallerScreen': (context) =>  CallerScreen(), '/HomeScreen': (context) =>  HomePage()}
        )
    )
  );
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final PageController _pageController = PageController(); // Moved it here

  bool isLogin = false;
  bool contactAdded = false;

  Future<void> checkUser() async {
    debugPrint("in checkUser()");
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser == null){
      isLogin = false;
    } else {
      setState(() {
        isLogin = true;
      });
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      if(data['phone_number'] != ''){
        setState(() {
          contactAdded = true;
        });
      }
    }
    debugPrint('is logged in? $isLogin');
    debugPrint('is contact added? $contactAdded');
  }

  void playRingtone() {
    FlutterRingtonePlayer.playRingtone(asAlarm: true);
  }

  @override
  void initState() {
    checkUser();
    AndroidPhysicalButtons.listen((key) {
      debugPrint('key $key');
    });
    AndroidVolumeButtons.listenForVolumeButtons((volume) {
      Fluttertoast.showToast(msg: "Volume changed: $volume");
    });
    super.initState();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('shaked')));
        debugPrint('phone shaken');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IncomingCall(
              name: "Unknown",
              number: "(410) 0679 890",
            ),
          ),
        );
        // playRingtone();
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 200,
      shakeThresholdGravity: 3.0,
      shakeCountResetTime: 3000,
    );
    // Add a delay to simulate a splash screen effect
    Timer(const Duration(seconds: 2), () {
      //getLoggedinState();
      checkUser();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the controller here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<RecordCubit>(
          create: (context) => RecordCubit(),
        ),
        BlocProvider<FilesCubit>(
          create: (context) => FilesCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Styles.themeData(context),
        home: isLogin ? (contactAdded ? const BottomNavBar() : const AddUserDetails()) : GoogleSignIn(),
          routes: {
            '/CallerScreen': (context) => CallerScreen(),
          }),

    );
  }

  _calling() async {
    const url = 'tel:+12345678';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 30, 128),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 250,

                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/img.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'S A H E L I',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Towards A Safe \'YOU\'',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )
            ]),
      ),
    );
  }

}
void addExamplePosts() async {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  await posts.add({
    'username': 'Sakshi agrawal',
    'content': 'This is an example post.',
    'upvotes': 10,
    'downvotes': 2,
  });

  await posts.add({
    'username': 'Alice Smith',
    'content': 'Another example post here.',
    'upvotes': 5,
    'downvotes': 1,
  });

  print('Example posts added to Firestore.');
}


class AndroidVolumeButtons {
  static const MethodChannel _channel = MethodChannel('android_volume_buttons');
  static const EventChannel _eventChannel = EventChannel('android_volume_buttons_events');

  static void listenForVolumeButtons(void Function(dynamic) callback) {
    _eventChannel.receiveBroadcastStream().listen((dynamic event) {
      callback(event);
    });
  }

  static Future<void> setAccelerationSamplingPeriod(int period) async {
    try {
      await _channel.invokeMethod('setAccelerationSamplingPeriod', period);
    } on MissingPluginException catch (e) {
      debugPrint('Error: $e');
    }
  }
}