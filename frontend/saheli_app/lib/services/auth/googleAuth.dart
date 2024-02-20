import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saheli_app/services/auth/fireDb.dart';
import 'package:saheli_app/services/localDb/localDb.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final userCredential = await _auth.signInWithCredential(credential);

    final User? user = userCredential.user;

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
    await LocalDb.saveMobile(user.phoneNumber.toString());

    print(user);
    return jwtToken;
  } catch (e) {
    print("Error Occurred In Google Auth!");
    print(e);
    return null;
  }
}

// //if user exists already
// Future<bool> getUser() async{
//   final User? currentUser = _auth.currentUser;
//   String user = "";
//
//   await FirebaseFirestore.instance.collection("User").doc(currentUser!.uid).get().then((value) =>
//   {
//     user = value.data().toString()  //if user does not exists it returns null
//   });
//   if(user == "null"){
//     return false;
//   }
//   else {
//     return true;
//   }
// }

Future<String> signOut() async {
  await googleSignIn.signOut();
  await _auth.signOut();
  await LocalDb.saveUserId('null');
  return "SUCCESS";
}
