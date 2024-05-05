import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth/fireDb.dart';
import '../../services/localDb/localDb.dart';
import '../../widgets/bottomNavBar.dart';

class VerifyScreen extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

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

  void createUser(BuildContext context) async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String gender = _genderController.text.trim();
    String age = _ageController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && gender.isNotEmpty && age.isNotEmpty) {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update user profile with name and email
        await user.updateDisplayName(name);
        await user.updateEmail(email);

        // Create user document in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'gender': gender,
          'age': age,
          // Add other fields as needed
        });

        // Save user data locally
        await LocalDb.saveName(name);
        await LocalDb.saveEmail(email);
        await LocalDb.saveGender(gender);
        await LocalDb.saveAge(age);

        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );

        Fluttertoast.showToast(msg: 'User created successfully');
      } else {
        // User not found, show error message
        Fluttertoast.showToast(msg: 'User not found');
      }
    } else {
      // Show error message if any field is empty
      Fluttertoast.showToast(msg: 'Please fill all fields');
    }
  }
}
