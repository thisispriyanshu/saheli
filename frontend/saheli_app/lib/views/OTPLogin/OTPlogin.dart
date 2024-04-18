import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saheli_app/views/OTPLogin/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

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

  String dialCode = '+91';

  final countryPicker = const  FlCountryCodePicker();

  Future<void> verifyPhone() async {
    // pr.show();
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceResendingToken]) {
      verificationId = verId;
      // pr.close();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(
            phoneNumber: phoneNo,
            verificationId: verificationId,
          ),
        ),
      );
    } as PhoneCodeSent;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        codeSent: smsOTPSent,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (AuthCredential phoneAuthCredential) async {
          try {

          } catch (e) {
            // Show error message if sign-in fails
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
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter Phone Number', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final picked= await countryPicker.showPicker(context: context);
                    dialCode = picked!.dialCode;
                    setState(() {
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1)
                    ),
                    child: Text(
                      dialCode,
                      style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: TextField(
                    style: GoogleFonts.outfit(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18.0,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      phoneNo = dialCode+value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: verifyPhone,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Send OTP',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
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
