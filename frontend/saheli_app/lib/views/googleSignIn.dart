import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
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
  bool isLoadingGoogleSignin = false;
  bool isLoadingOtp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                  height: 196,
                  width: 196,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset("lib/assets/images/logo.png"))),
              const SizedBox(
                height: 20,
              ),
              Text(
                'S A H E L I',
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Create your account to save your information securely',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 50,
              ),
              isLoadingGoogleSignin
                  ? const SpinKitDoubleBounce(
                      color: Colors.white,
                      size: 50.0,
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton.icon(
                        icon: Brand(Brands.google),
                        onPressed: () async {
                          setState(() {
                            isLoadingGoogleSignin = true;
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
                          backgroundColor: isLoadingOtp
                              ? MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.tertiary)
                              : MaterialStateProperty.all(Theme.of(context)
                                  .colorScheme
                                  .secondary), // Change the button color as needed
                        ),
                        label: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Sign in with Google',
                            style: GoogleFonts.outfit(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              isLoadingOtp
                  ? const SpinKitDoubleBounce(
                      color: Colors.white,
                      size: 50.0,
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.password_rounded),
                        onPressed: () async {
                          setState(() {
                            isLoadingOtp = true;
                          });
                          // await Future.delayed(Duration(seconds: 2));
                          // setState(() {
                          //   isLoading = false;
                          // });
                          //await _googleSignInManager.signIn();

                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: PhoneAuth(),
                                  type: PageTransitionType.fade));
                        },
                        style: ButtonStyle(
                          backgroundColor: isLoadingGoogleSignin
                              ? MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.tertiary)
                              : MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.secondary),
                        ),
                        label: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Sign in using OTP',
                            style: GoogleFonts.outfit(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
