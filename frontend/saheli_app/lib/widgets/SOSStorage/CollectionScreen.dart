import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saheli/FakeCaller/screens/scheduler.dart';
import 'package:Saheli/FakeCaller/screens/user_manual.dart';
import 'package:Saheli/widgets/SOSStorage/AudioListScreen.dart';
import 'package:Saheli/widgets/SOSStorage/AudioStore.dart';
import 'package:Saheli/widgets/SOSStorage/CameraStore.dart';
import 'package:Saheli/widgets/SOSStorage/sosCardChild.dart';
import '../../FakeCaller/utilities/card_child.dart';
import '../../FakeCaller/utilities/icon_content.dart';

class CollectionScreen extends StatefulWidget {
  @override
  State<CollectionScreen> createState() => _CallMenuState();
}

class _CallMenuState extends State<CollectionScreen> {
  bool isFullTimerLoaded = false;

  bool isFullIDLoaded = false;

//"5D48E512E9EB0246C16EDCFE865C0E7D"
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SOS Storage Collection",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'lib/assets/images/audioStorage.jpg',
                        color: Colors.black.withOpacity(0.4),
                        colorBlendMode: BlendMode.multiply,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage your Audios',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'All your sos audios are stored here. Audio recordings can be a great help in collecting evidences',
                            style: GoogleFonts.outfit(
                                fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AudioListFirstScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Open Storage',
                                style: GoogleFonts.outfit(
                                    fontSize: 16, color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                //height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'lib/assets/images/cameraStorage.png',
                        color: Colors.black.withOpacity(0.4),
                        colorBlendMode: BlendMode.multiply,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage your Images',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'All your sos camera captures are stored here. Images captured by camera can be a great help in collecting evidences',
                            style: GoogleFonts.outfit(
                                fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageListScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Open Storage',
                                style: GoogleFonts.outfit(
                                    fontSize: 16, color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Row(
// children: [
// Expanded(
// child: SOSCard(
// cardChild: IconContent(
// icon: const IconData(0xf05bf,
// fontFamily: 'MaterialIcons'),
// text: "Audio Storage",
// ),
// onPress: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => AudioListFirstScreen(),
// ),
// );
// },
// ),
// ),
// Expanded(
// child: SOSCard(
// cardChild: IconContent(
// icon: const IconData(0xef21,
// fontFamily: 'MaterialIcons'),
// text: 'Camera Storage',
// ),
// onPress: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => ImageListScreen()),
// );
// },
// ),
// ),
// ],
// ),
