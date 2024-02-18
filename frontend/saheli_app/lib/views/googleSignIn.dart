import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../services/auth/googleAuth.dart';
import '../services/auth/googleSignin.dart';

class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({super.key});

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  final GoogleSignInManager _googleSignInManager = GoogleSignInManager();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      //backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.all(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                    child: Image.asset("assets/auth.jpg"))),
            Container(
              height: 35,
              alignment: Alignment.bottomCenter,
              child: isLoading ? const SpinKitDoubleBounce(
                color: Colors.white,
                size: 50.0,
              ) : SignInButton(Buttons.google, onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                // await Future.delayed(Duration(seconds: 2));
                // setState(() {
                //   isLoading = false;
                // });
                //await _googleSignInManager.signIn();
                await signInWithGoogle();
                Navigator.pushReplacement(context, PageTransition(child: const BottomNavBar(), type: PageTransitionType.fade));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
