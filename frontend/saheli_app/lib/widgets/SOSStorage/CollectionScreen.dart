import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saheli_app/FakeCaller/screens/scheduler.dart';
import 'package:saheli_app/FakeCaller/screens/user_manual.dart';
import 'package:saheli_app/widgets/SOSStorage/AudioStore.dart';
import 'package:saheli_app/widgets/SOSStorage/CameraStore.dart';
import 'package:saheli_app/widgets/SOSStorage/sosCardChild.dart';
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
      appBar: AppBar(title: Text('SOS storage collection',)),
      backgroundColor: Color.fromARGB(255, 255, 236, 208),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/image4.jpeg",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 60.0, right: 30.0, bottom: 30.0),
              child: Column(children: [

                const SizedBox(
                  height: 10.0,
                ),


              ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 236, 208),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(

                            child: SOSCard(

                              cardChild: IconContent(
                                icon: const IconData(0xf05bf,
                                    fontFamily: 'MaterialIcons'),
                                text: "Audio Storage",

                              ),
                              onPress: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AudioListScreen(

                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: SOSCard(
                              cardChild: IconContent(
                                icon: const IconData(0xef21,
                                    fontFamily: 'MaterialIcons'),
                                text: 'Camera Storage',
                              ),
                              onPress: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageListScreen()),
                                );

                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],

                ),
              ),
            ),
            const SizedBox(
              height: 200.0,
            ),
          ],

        ),
      ),
    );
  }
}
