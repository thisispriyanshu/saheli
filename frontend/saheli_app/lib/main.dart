import 'dart:async';
import 'package:android_physical_buttons/android_physical_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/views/OnboardingScreen.dart';
import 'package:saheli_app/views/googleSignIn.dart';
import 'package:saheli_app/views/home_screen.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';
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
  try{
    final url = Uri.parse(
        'https://saheli-backend-ufs3.onrender.com/safest-route');
    final requestBody = {
      "source": "28.8162605,77.1306592",
      "destination": "28.550121, 77.1866867",
      "mode": "driving",
    };
    print(requestBody.toString());

    final response = await http.post(
      url,
      body: {
        "source": "28.8162605,77.1306592",
        "destination": "28.550121, 77.1866867",
        "mode": "driving",
      }
    );
    print(response.body.toString());
  } catch(e) {
    print("error $e");
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    routes: {'/CallerScreen': (context) =>  CallerScreen(), '/HomeScreen': (context) =>  HomePage()}
  ));
}

class _MyAppState extends State<MyApp> {
  final PageController _pageController = PageController(); // Moved it here

  bool isLogin = false;

  // getLoggedinState() async {
  //   await LocalDb.getEmail().then((value) {
  //     print(value);
  //     setState(() {
  //       if (value.toString() != "null") {
  //         isLogin = true;
  //       }
  //     });
  //   });
  // }

  void checkUser() {
    print("in checkUser()");
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser == null){
      isLogin = false;
    } else {
      setState(() {
        isLogin = true;
      });
    }
    print('is logged in? $isLogin');
  }

  void playRingtone() {
    FlutterRingtonePlayer.playRingtone(asAlarm: true);
  }

  @override
  void initState() {
    print('Success in safe route');
    checkUser();
    AndroidPhysicalButtons.listen((key) {
      print(key);
    });
    AndroidVolumeButtons.listenForVolumeButtons((volume) {
      Fluttertoast.showToast(msg: "Volume changed: $volume");
    });
    print(isLogin);
    super.initState();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('shaked')));
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
    print(isLogin);

    // Add a delay to simulate a splash screen effect
    Timer(Duration(seconds: 2), () {
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
        home: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return isLogin ? BottomNavBar() : OnboardingScreen();
            } else {
              return SplashScreen();
            }
          },
        ),
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

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/img.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'S A H E L I',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
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
  static const MethodChannel _channel =
  MethodChannel('android_volume_buttons');

  static void listenForVolumeButtons(void Function(dynamic) callback) {
    EventChannel('android_volume_buttons_events').receiveBroadcastStream().listen((dynamic event) {
      callback(event);
    });
  }
}