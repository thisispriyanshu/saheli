import 'dart:convert';

import 'package:Saheli/apiRepository/apiHttpResponse.dart';
import 'package:Saheli/apiRepository/productRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Saheli/services/auth/fireDb.dart';
import 'package:Saheli/services/localDb/localDb.dart';
import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<bool> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
    await GoogleSignIn(
      scopes: ['email', 'profile'],
      hostedDomain: '',
    ).signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final userCredential = await _auth.signInWithCredential(credential);

    final User? user = userCredential.user;
    debugPrint(user.toString());
    if(user != null) {
      final String? jwtToken = await user.getIdToken();
      debugPrint('JWT Token: $jwtToken');
      await LocalDb.saveUserId(user.uid.toString());
      bool newUser = await saveUserToFirestore(user);
      //await sendTokenToBackend(jwtToken!, user);
      return newUser;
    }


    // final User? currentUser = await _auth.currentUser;
    // assert(currentUser!.uid == user.uid);
    // await FireDb().createNewUser(user.displayName.toString(),
    //     user.email.toString(), user.photoURL.toString(), user.uid.toString(), jwtToken!);
    // await LocalDb.saveUserId(user!.uid.toString());
    // await LocalDb.saveName(user.displayName.toString());
    // await LocalDb.saveEmail(user.email.toString());
    // await LocalDb.saveUrl(user.photoURL.toString());
    // await LocalDb.saveMobile(user.phoneNumber.toString());

    debugPrint(user.toString());
  } catch (e) {
    debugPrint("Error Occurred In Google Auth!");
    debugPrint(e.toString());
  }
  return false;
}

Future<bool> saveUserToFirestore(User user) async {
  final userDoc = _firestore.collection('users').doc(user.uid);
  final userSnapshot = await userDoc.get();
  if (!userSnapshot.exists) {
    // User does not exist, create a new document
    await userDoc.set({
      'age': 0,
      'gender': 'Female',
      'firebase_uid': user.uid,
      'email': user.email,
      'name': user.displayName,
      'photoURL': user.photoURL,
    });
    return true;
  } else {
    // User exists, update the existing document
    await userDoc.update({
      'email': user.email,
      'name': user.displayName,
      'photoURL': user.photoURL,
    });
  }
  return false;
}

Future<void> sendTokenToBackend(String jwtToken, User user) async {
  try{
    String url = 'https://saheli-backend-ufs3.onrender.com/users/';
    ApiHttpResponse response = await callPostMethod(
    {
      'name': user.displayName,
      'email': user.email,
      'phone_number': user.phoneNumber,
      'firebase_uid': user.uid
    },
    'users');
    final data = jsonDecode(response.responceString!);
    String res = data[''];
    if(response.responseCode == 200){
      debugPrint('User registered successfully');
    }
  }catch(e){
    debugPrint('Failed to upload user $e');
  }
}

// //if user exists already
Future<bool> getUser() async{
  final User? currentUser = _auth.currentUser;
  String user = "";

  await FirebaseFirestore.instance.collection("User").doc(currentUser!.uid).get().then((value) =>
  {
    user = value.data().toString()  //if user does not exists it returns null
  });
  if(user == "null"){
    return false;
  }
  else {
    return true;
  }
}

Future<String> signOut() async {
  await googleSignIn.signOut();
  await _auth.signOut();
  await LocalDb.saveUserId('null');
  await LocalDb.saveEmail('null');
  return "SUCCESS";
}
