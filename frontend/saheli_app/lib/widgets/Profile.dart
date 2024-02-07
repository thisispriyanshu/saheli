import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/widgets/PrivacyPolicy.dart';
import 'package:share/share.dart';

import '../views/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userName = 'null';
  String userEmail = 'null';

  Future<void> _loadUserDetails() async {
    await LocalDb.getName().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await LocalDb.getEmail().then((value) {
      setState(() {
        userEmail = value!;
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white54,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const ListTile(
                  leading: Icon(Icons.arrow_back),
                  trailing: Icon(Icons.menu),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      maxRadius: 65,
                      backgroundImage: AssetImage("assets/6195145.jpg"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/download.png"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/GooglePlus-logo-red.png"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/1_Twitter-new-icon-mobile-app.jpg"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/600px-LinkedIn_logo_initials.png"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Master manipulator, deal-maker and\n                   entrepreneur",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Expanded(
                      child: ListView(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          leading: Icon(
                            Icons.privacy_tip_sharp,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Privacy Policy',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: const ListTile(
                          leading:
                              Icon(Icons.help_outline, color: Colors.black54),
                          title: Text(
                            'Help & Support',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: const ListTile(
                          leading: Icon(
                            Icons.privacy_tip_sharp,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Settings',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          leading: Icon(
                            Icons.add_reaction_sharp,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Invite a Friend',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            openSharePanel();
                          },
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                          onTap: () {
                            logout(context);
                          },
                        ),
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        ));
  }

  final String linkToShare = 'your_link_here';

  void openSharePanel() {
    // Use the share function from the share package to open the share panel
    Share.share(linkToShare);
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    await LocalDb.clearUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
