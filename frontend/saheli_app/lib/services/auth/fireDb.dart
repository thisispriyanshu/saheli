import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:Saheli/services/localDb/localDb.dart';

class FireDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> data = {};
  createNewUser(String name, String email, String photoUrl, String uid,
      String jwtToken) async {
    final User? currentUser = _auth.currentUser;

    final credential = GoogleAuthProvider.credential(idToken: jwtToken);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (await getUser(jwtToken)) {
      print("User already exists");
    } else {
      final credential = GoogleAuthProvider.credential(idToken: jwtToken);
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      String url = 'https://saheli-backend-ufs3.onrender.com/users/';
      final response = await http.post(url as Uri, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      });
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        data = {
          'firebase_uid': uid,
          'name': name,
          'email': email,
        };
        await LocalDb.saveUserId(uid);
        await LocalDb.saveName(name);
        print('User created: $data');
      }else{
        print('Error: ${response.statusCode}');
      }
    }
  }

  Future<bool> getUser(String jwtToken) async {
    String url = 'https://saheli-backend-ufs3.onrender.com/auth/';
    final response = await http.get(url as Uri, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwtToken',
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      print(json.decode(response.body));
      Map<String, dynamic> data = json.decode(response.body);
      print("getUser data-> $data");
      return true;
    } else {
      print('Error: ${response.statusCode}');
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String uid) async {
    try {
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        debugPrint('User does not exist in Firestore');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      return null;
    }
  }
}
