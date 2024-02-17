import 'package:flutter/material.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../services/auth/googleAuth.dart';

class GoogleSignIn extends StatelessWidget {
  const GoogleSignIn({super.key});

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
              child: SignInButton(Buttons.google, onPressed: () async {
                await signInWithGoogle();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
