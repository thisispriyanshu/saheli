import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saheli_app/FakeCaller/screens/call_menu.dart';
import 'package:saheli_app/services/auth/googleAuth.dart';
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/views/OnboardingScreen.dart';
import 'package:saheli_app/views/googleSignIn.dart';
import 'package:saheli_app/widgets/PrivacyPolicy.dart';
import 'package:saheli_app/widgets/profileAssistCard.dart';
import 'package:share/share.dart';

import '../views/article_screen.dart';
import '../views/login.dart';
import 'SOSStorage/CollectionScreen.dart';
import 'SOSStorage/SubmitForm.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userName = 'Aditi agrawal';
  String userEmail = 'a@gmail.com';
  String photoUrl = '';

  // Future<void> _loadUserDetails() async {
  //   await LocalDb.getName().then((value) {
  //     setState(() {
  //       userName = _auth.currentUser!.displayName;
  //     });
  //   });
  //   await LocalDb.getEmail().then((value) {
  //     setState(() {
  //       userEmail = _auth.currentUser!.email!;
  //     });
  //   });
  //   await LocalDb.getUrl().then((value) {
  //     setState(() {
  //       profileUrl = value.toString();
  //     });
  //   });
  // }

  void fetchUserData() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userName = user.displayName;
        userEmail = user.email!;
        photoUrl = user.photoURL!;
        print('User Display Name: $userName');
        print('User Email: $userEmail');
        print('User Photo URL: $photoUrl');
      } else {
        print('User is not signed in.');
      }
    } catch (e) {
      print('Error while fetching user data: $e');
    }
  }

  @override
  void initState() {
    //_loadUserDetails();
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600, fontSize: 24),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25,),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: photoUrl.isEmpty ? Container(
                height: 96,
                width: 96,
                decoration: const BoxDecoration(
                    color: Color(0xffE6F4FD)
                ),)
                  : CachedNetworkImage(
                imageUrl: photoUrl,
                fit: BoxFit.cover,
                height: 126,
                width: 126,
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              userName!,
              style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  ),
            ),
            const SizedBox(height: 5,),
            Text(
              userEmail,
              style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  ),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                ProfileAssistCard(
                    icon: Icons.call,
                    title: 'Fake Caller',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallMenu(),
                        ),
                      );
                    }),
                ProfileAssistCard(
                    icon: Icons.dangerous,
                    title: 'Report Suspicious Places',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SafeRoutesForm(),
                        ),
                      );
                    }),
                ProfileAssistCard(
                    icon: Icons.storage,
                    title: 'Your SOS Collection',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CollectionScreen(),
                        ),
                      );
                    }),
                ProfileAssistCard(
                    icon: Icons.read_more,
                    title: 'Explore Safety Articles',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArticleScreen(),
                        ),
                      );
                    }),
                ProfileAssistCard(
                    icon: Icons.add_reaction_sharp,
                    title: 'Invite a Friend',
                    onTap: () {
                      openSharePanel();
                    }),
                ProfileAssistCard(
                    icon: Icons.privacy_tip_sharp,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyPage()));
                    }),
                ProfileAssistCard(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () async {
                      await signOut();
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const OnboardingScreen(),
                              type: PageTransitionType.leftToRight));
                    }),
              ],
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }

  void openSharePanel() {
    String linkToShare = "https://saheli-app.netlify.app/";
    Share.share(linkToShare);
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    await LocalDb.clearUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
