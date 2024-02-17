import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:saheli_app/services/localDb/localDb.dart';

class FireDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> data = [] as Map<String, dynamic>;
  createNewUser(String name, String email, String photoUrl, String uid,
      String jwtToken) async {
    final User? currentUser = _auth.currentUser;

    //check if user already exists
    final credential = GoogleAuthProvider.credential(idToken: jwtToken);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (await getUser(jwtToken)) {
      print("User already exists");
    } else {
      // User does not exist, create the user and store data locally
      final credential = GoogleAuthProvider.credential(idToken: jwtToken);
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      String url = 'https://saheli-backend-ufs3.onrender.com//users/';
      final response = await http.post(url as Uri, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      });

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        data = {
          'userId': uid,
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
}
