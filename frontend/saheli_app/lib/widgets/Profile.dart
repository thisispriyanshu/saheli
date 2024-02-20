import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/FakeCaller/screens/call_menu.dart';
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/widgets/PrivacyPolicy.dart';
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
  String? userName = 'Aditi Agrawal';
  String userEmail = 'apoorvyash123@gmail.com';

  Future<void> _loadUserDetails() async {
    await LocalDb.getName().then((value) {
      setState(() {
        userName = _auth.currentUser!.displayName;
      });
    });
    await LocalDb.getEmail().then((value) {
      setState(() {
        userEmail = _auth.currentUser!.email!;
      });
    });
  }

  @override
  void initState() {
    _loadUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white54,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 65,
                  backgroundImage: AssetImage("assets/profile.png"),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 26),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(userEmail)],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A happy wanderer by passion',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Expanded(
                child: ListView(
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallMenu(),
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.call,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        title: const Text(
                          'Fake Caller',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SafeRoutesForm(),
                            ),
                          );
                        },
                        leading: const Icon(
                          Icons.dangerous,
                          color: Colors.black54,
                        ),
                        title: const Text(
                          'Report Suspicious Places',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CollectionScreen(),
                            ),
                          );
                        },
                        leading: const Icon(
                          Icons.storage,
                          color: Colors.black54,
                        ),
                        title: const Text(
                          'Your SOS Collection',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.privacy_tip_sharp,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        title: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyPage(),
                            ),
                          );
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ArticleScreen(),
                            ),
                          );
                        },
                        leading: Icon(Icons.read_more,
                            color: Theme.of(context).colorScheme.tertiary),
                        title: const Text(
                          'Explore Safety Articles',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.add_reaction_sharp,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        title: const Text(
                          'Invite a Friend',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          openSharePanel();
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        onTap: () {
                          logout(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openSharePanel() {
    String linkToShare="saheli.dev";
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
