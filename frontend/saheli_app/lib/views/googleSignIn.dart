import 'dart:math';

import 'package:flutter/material.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../services/auth/googleAuth.dart';

class GoogleSignIn extends StatelessWidget {
  const GoogleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      //backgroundColor: Colors.white,
      body: Center(
        child: Stack(

          children: [
            Container(
              color: Theme.of(context).primaryColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   margin: const EdgeInsets.all(30),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(25),
                //         child: Image.asset("assets/auth.jpg"))),
                Text('Welcome to', style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text('Saheli', style: TextStyle(color:Theme.of(context).colorScheme.tertiary, fontSize: 50.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 60,),
                Container(
                  height: 35,
                  alignment: Alignment.bottomCenter,
                  child: SignInButton(Buttons.google, onPressed: () async {
                    await signInWithGoogle();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
