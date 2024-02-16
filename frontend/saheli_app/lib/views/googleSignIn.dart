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
      body: Center(
        child: Container(
          height: 30,
          alignment: Alignment.bottomCenter,
          child: SignInButton(Buttons.googleDark, onPressed: () async {
            await signInWithGoogle();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
          }),
        ),
      ),
    );
  }
}
