import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/views/article_screen.dart';
import 'package:saheli_app/widgets/PrivacyPolicy.dart';
import 'package:share/share.dart';

import '../views/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String linkToShare = 'saheli.dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 236, 208),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
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
                  backgroundImage: AssetImage(
                      "assets/600px-LinkedIn_logo_initials.png"),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Thomas Shelby",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text("@peakyBlinders")],
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
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(

                        leading: Icon(
                          Icons.privacy_tip_sharp,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Privacy Policy',
                          style: TextStyle(color: Colors.white,
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
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(

                        onTap: (){
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => ArticleScreen(),
                      ),
                      );},
                        leading:
                        Icon(Icons.read_more, color: Colors.black54),
                        title: Text(
                          'Explore Safety Articles',
                          style: TextStyle(
                            color: Colors.white,
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
                      color: Theme.of(context).colorScheme.secondary,
                      margin: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: const ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
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
                          color: Colors.black54,
                        ),
                        title: Text(

                          'Invite a Friend',
                          style: TextStyle(
                              color: Colors.white,
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
                      color: Theme.of(context).colorScheme.secondary,
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
                              color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
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
    Share.share(linkToShare);
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
