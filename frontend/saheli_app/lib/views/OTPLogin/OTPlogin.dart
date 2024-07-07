import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Saheli/views/OTPLogin/verification.dart';
import 'package:Saheli/widgets/SOSStorage/AudioListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

import '../../services/auth/fireDb.dart';
import '../../services/localDb/localDb.dart';
class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  late ProgressDialog pr;
  late String phoneNo;
  late String smsOTP;
  late String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    // pr.show();
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceResendingToken]) {
      this.verificationId = verId;
      // pr.close();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(
            phoneNumber: this.phoneNo,
            verificationId: this.verificationId
          ),
        ),
      );
    } as PhoneCodeSent;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeSent: smsOTPSent,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (AuthCredential phoneAuthCredential) async {
          try {

          } catch (e) {
            Fluttertoast.showToast(msg: 'Failed to Sign In');
          }
        },

        verificationFailed: (FirebaseAuthException authException) {
          print('Exception is ${authException.message}');
          switch (authException.code) {
            case 'invalid-phone-number':
              errorMessage = 'The provided phone number is not valid.';
              break;
            default:
              errorMessage = 'An unknown error occurred.';
              break;
          }
          Fluttertoast.showToast(msg: errorMessage);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      // handleError();
    }
  }


  Future<void> handleError(FirebaseAuthException error) async {
    switch (error.code) {
      case 'invalid-phone-number':
        errorMessage = 'The provided phone number is not valid.';
        break;
      case 'invalid-verification-code':
        errorMessage = 'The provided verification code is invalid.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests have been sent to this phone number.';
        break;
      default:
        errorMessage = 'An unknown error occurred.';
        break;
    }
    await storeToken('ERROR_MESSAGE', errorMessage);
    Fluttertoast.showToast(msg: errorMessage);
  }

  Future<void> storeToken(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  void initState() {
    super.initState();
    // pr = new ProgressDialog( context: context);
    // pr.show(
    //     msg: 'Please wait...',
    //     borderRadius: 10.0,
    //     backgroundColor: Colors.white,
    //     progressType: ProgressType.normal,
    //     elevation: 10.0,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Phone Number'),
              onChanged: (value) {
                this.phoneNo = value;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: verifyPhone,
              child: Text('Send OTP'),
            )
          ],
        ),
      ),
    );
  }


  void signInWithPhoneAuthCredential(PhoneAuthCredential credential) {
    _auth.signInWithCredential(credential)
        .then((userCredential) {
      // Sign in success, update UI with the signed-in user's information
      User? user = userCredential.user;
      if (user != null) {
        // User is signed in
        print('User is signed in: ${user.uid}');
        // You can further process user data here
      }
    })
        .catchError((error) {
      // Sign in failed, display a message and update the UI
      print('Failed to sign in: $error');
      if (error is FirebaseAuthException) {
        // Handle specific errors if needed
        if (error.code == 'invalid-verification-code') {
          // The verification code entered was invalid
        }
      }
      // Update UI
    });
  }

}
