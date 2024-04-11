import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/auth/fireDb.dart';
import '../../services/localDb/localDb.dart';

class VerifyScreen extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;

  VerifyScreen({required this.phoneNumber, required this.verificationId});

  String smsCode = '';

  Future<void> verifyOTP(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential).then((user) async {
        // Authentication successful, handle the user or token retrieval here
        await storeToken('JWT_TOKEN', 'YOUR_SECRET_TOKEN');
        UserCredential userCredential = await _auth.signInWithCredential(credential);


        final User? user = userCredential.user;
        print(user);

        assert(!user!.isAnonymous);

        // Get the ID token after signing in
        final String? jwtToken = await user!.getIdToken();
        print('JWT Token: $jwtToken');

        assert(await user.getIdToken() != null);

        final User? currentUser = await _auth.currentUser;
        assert(currentUser!.uid == user.uid);
        await FireDb().createNewUser(user.displayName.toString(),
            user.email.toString(), user.photoURL.toString(), user.uid.toString(), jwtToken!);
        await LocalDb.saveUserId(user.uid.toString());
        await LocalDb.saveName(user.displayName.toString());
        await LocalDb.saveEmail(user.email.toString());
        await LocalDb.saveUrl(user.photoURL.toString());
        await LocalDb.saveMobile(user.phoneNumber.toString());

        print(user);
        Fluttertoast.showToast(msg: 'Successfully Signed In!');
      }).catchError((e) {
        print('Failed to Sign In'+e.toString());
      });
    } catch (e) {
      // Handle verification failure
      print('Failed to verify OTP: $e');
      Fluttertoast.showToast(msg: 'Failed to verify OTP');
    }
  }

  Future<void> storeToken(String key, String value) async {
    // Store token in SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'Enter OTP'),
            onChanged: (value) {
              smsCode = value;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              verifyOTP(context);
            },
            child: Text('Verify OTP'),
          )
        ],
      ),
    );
  }
}
