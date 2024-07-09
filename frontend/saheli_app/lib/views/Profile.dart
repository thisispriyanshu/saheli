import 'package:Saheli/common/utils/colors.dart';
import 'package:Saheli/views/edit_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Saheli/FakeCaller/screens/call_menu.dart';
import 'package:Saheli/services/auth/googleAuth.dart';
import 'package:Saheli/services/localDb/localDb.dart';
import 'package:Saheli/views/OnboardingScreen.dart';
import 'package:Saheli/views/googleSignIn.dart';
import 'package:Saheli/widgets/PrivacyPolicy.dart';
import 'package:Saheli/widgets/profileAssistCard.dart';
import 'package:share/share.dart';

import '../common/utils/utils.dart';
import 'article_screen.dart';
import 'login.dart';
import '../widgets/SOSStorage/CollectionScreen.dart';
import '../widgets/SOSStorage/SubmitForm.dart';

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
  String contactNumber = '1234567890';
  String gender = 'gender';
  String age = 'age';
  bool _edit = false;
  bool updatingLogo = false;
  XFile? profileImage;
  String? imageUrl;

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

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          userName = user.displayName;
          userEmail = user.email!;
          photoUrl = user.photoURL!;
        });
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          contactNumber = data['phone_number'];
          gender = data['gender'];
          age = data['age'];
        });
        print('User Display Name: $userName');
        print('User Email: $userEmail');
        print('User Photo URL: $photoUrl');
        print('User number: $contactNumber');
        print('User gender: $gender');
        print('User age: $age');
      } else {
        print('User is not signed in.');
      }
    } catch (e) {
      print('Error while fetching user data: $e');
    }
  }

  pickAndUploadImage() async {
    profileImage = await captureImage(ImageSource.gallery);
    if (profileImage != null) {
      setState(() {
        updatingLogo = true;
      });
      imageUrl = await uploadFileToStorage("image", profileImage);
      if (imageUrl == null || imageUrl!.isEmpty) {
        debugPrint('Image upload failed \nReason: Image url is null');
        showSnackBar(
          context,
          "Image upload failed \nReason: Image url is null",
          Colors.red,
        );
      } else {
        debugPrint("image url: $imageUrl");
        showSnackBar(
          context,
          "Profile photo updated",
          Colors.red,
        );
        setState(() {
          photoUrl = imageUrl!;
          updatingLogo = false;
        });
      }
    }
  }

  @override
  void initState() {
    //_loadUserDetails();
    fetchUserData();
    super.initState();
  }

  toggleEdit() {
    setState(() {
      _edit = !_edit;
    });
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
              fontWeight: FontWeight.w600, fontSize: 32),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                },
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: photoUrl.isNotEmpty
                                ? photoUrl
                                : 'https://coenterprises.com.au/wp-content/uploads/2018/02/male-placeholder-image.jpeg',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )),
                      const SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName!,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          // const SizedBox(height: 5,),
                          // Text(
                          //   userEmail,
                          //   style: GoogleFonts.outfit(
                          //     fontWeight: FontWeight.w300,
                          //     fontSize: 16,
                          //   ),
                          // ),
                          // const SizedBox(height: 5,),
                          // Text(
                          //   contactNumber,
                          //   style: GoogleFonts.outfit(
                          //     fontWeight: FontWeight.w300,
                          //     fontSize: 16,
                          //   ),
                          // ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                age,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                gender,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
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
            const SizedBox(height: 50,)
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
