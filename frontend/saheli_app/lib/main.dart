import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saheli_app/FakeCaller/screens/caller_screen.dart';
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/views/home_screen.dart';
import 'package:saheli_app/views/OnboardingScreen.dart';
import 'package:saheli_app/views/googleSignIn.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/widgets/Chatbot/geminiAuth.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';
import 'package:shake/shake.dart';

import 'AudioRecorder/screens/home_screen/cubit/record/record_cubit.dart';
import 'AudioRecorder/screens/recordings_list/cubit/files/files_cubit.dart';
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
  //await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    routes: {
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/CallerScreen': (context) =>  CallerScreen(),
    },

  ));

}

class _MyAppState extends State<MyApp> {

  final PageController _pageController = PageController(); // Moved it here

  bool isLogin = false;

  getLoggedinState() async {
    await LocalDb.getEmail().then((value) {
      print(value);
      setState(() {
        if (value.toString() != "null") {
          isLogin = true;
        }
      });
    });
  }

  void playRingtone() {
    FlutterRingtonePlayer.playRingtone(asAlarm: true);
  }

  @override
  void initState() {
    getLoggedinState();
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
      playRingtone();
    },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 200,
      shakeThresholdGravity: 3.0,
      shakeCountResetTime: 3000,
    );
    // Add a delay to simulate a splash screen effect
    Timer(Duration(seconds: 2), () {
      getLoggedinState();

      setState(() {});
    });
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
          // Simulate the initialization process with a Future
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //return isLogin ? BottomNavBar() : GoogleSignIn();
              return OnboardingScreen();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 30, 128),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: Container(
              height: 250,

              // Use BoxDecoration to cover the whole screen with the image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img.png'),
                ),
              ),

                        ),
            ),
            SizedBox(height: 30,),
            Text('S A H E L I', style: TextStyle(color: Colors.white,fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text('towards a safe \'YOU\'', style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold),)
        ]),
      
      ),
    );

  }
}
