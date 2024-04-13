import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../services/auth/googleAuth.dart';
import 'OTPLogin/OTPlogin.dart';

class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({super.key});

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      //backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(50),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset("lib/assets/images/img.png"))),
                Text(
                  'S A H E L I',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
                height: 40,
                alignment: Alignment.bottomCenter,
                child: isLoading
                    ? const SpinKitDoubleBounce(
                        color: Colors.white,
                        size: 50.0,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          // await Future.delayed(Duration(seconds: 2));
                          // setState(() {
                          //   isLoading = false;
                          // });
                          //await _googleSignInManager.signIn();
                          await signInWithGoogle();
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const BottomNavBar(),
                                  type: PageTransitionType.fade));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(
                              0xffF5F5F5)), // Change the button color as needed
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'lib/assets/images/google.jpg', // Replace with the path to your Google logo asset
                              height: 20.0, // Adjust the height as needed
                            ),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                // SignInButton(Buttons.google, onPressed: () async {
                //   setState(() {
                //     isLoading = true;
                //   });
                //   // await Future.delayed(Duration(seconds: 2));
                //   // setState(() {
                //   //   isLoading = false;
                //   // });
                //   //await _googleSignInManager.signIn();
                //   await signInWithGoogle();
                //   Navigator.pushReplacement(context, PageTransition(child: const BottomNavBar(), type: PageTransitionType.fade));
                // }),
                ),
            Container(
              height: 40,
              alignment: Alignment.bottomCenter,
              child: isLoading
                  ? const SpinKitDoubleBounce(
                      color: Colors.white,
                      size: 50.0,
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        // await Future.delayed(Duration(seconds: 2));
                        // setState(() {
                        //   isLoading = false;
                        // });
                        //await _googleSignInManager.signIn();

                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child:  PhoneAuth(),
                                type: PageTransitionType.fade));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(
                            0xffF5F5F5)), // Change the button color as needed
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'lib/assets/images/otp_pic.jpg', // Replace with the path to your Google logo asset
                            height: 20.0, // Adjust the height as needed
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            'Sign in using OTP',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

