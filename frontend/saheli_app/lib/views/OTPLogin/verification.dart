import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../services/auth/fireDb.dart';
import '../../services/localDb/localDb.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  VerifyScreen({required this.phoneNumber, required this.verificationId});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String smsCode = '';

  final pinController = TextEditingController();

  Future<void> verifyOTP(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xffF55442)),
      borderRadius: BorderRadius.circular(20),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color(0xffFEECEB),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verification', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('Enter the code sent to your number \n ${widget.phoneNumber}', textAlign: TextAlign.center, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w300),),
            const SizedBox(height: 30,),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
              controller: pinController,
              validator: (s) {
                verifyOTP(context);
                return null;
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) {
                smsCode = pin;
              },
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Verify OTP'),
    //   ),
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       TextField(
    //         decoration: InputDecoration(hintText: 'Enter OTP'),
    //         onChanged: (value) {
    //           smsCode = value;
    //         },
    //       ),
    //       SizedBox(height: 16.0),
    //       ElevatedButton(
    //         onPressed: () {
    //           verifyOTP(context);
    //         },
    //         child: Text('Verify OTP'),
    //       )
    //     ],
    //   ),
    // );
  }
}
