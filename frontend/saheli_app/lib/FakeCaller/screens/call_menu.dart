import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saheli_app/FakeCaller/screens/scheduler.dart';
import 'package:saheli_app/FakeCaller/screens/user_manual.dart';
import '../utilities/card_child.dart';
import '../utilities/icon_content.dart';
import 'caller_id.dart';
import 'incoming_call.dart';

class CallMenu extends StatefulWidget {
  @override
  State<CallMenu> createState() => _CallMenuState();
}

class _CallMenuState extends State<CallMenu> {
  bool isFullTimerLoaded = false;

  bool isFullIDLoaded = false;

//"5D48E512E9EB0246C16EDCFE865C0E7D"
  @override
  void initState() {
    super.initState();
  }

  void playRingtone() {
    FlutterRingtonePlayer.playRingtone(asAlarm: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: const Text(
          "Fake Caller",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
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
                  height: 5.0,
                ),
                Text(
                  'Use fake caller incase of emergency',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            const SizedBox(
              height: 50.0,
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
                            child: CardChild(
                              cardChild: IconContent(
                                icon: const IconData(0xf06e4,
                                    fontFamily: 'MaterialIcons'),
                                text: "Call Now",
                              ),
                              onPress: () {
                                playRingtone();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IncomingCall(
                                      name: "Unknown",
                                      number: "(410) 0679 890",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: CardChild(
                              cardChild: IconContent(
                                icon: const IconData(0xe18c,
                                    fontFamily: 'MaterialIcons'),
                                text: 'Caller ID',
                              ),
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CallerID()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: CardChild(
                            cardChild: IconContent(
                              icon: const IconData(0xe0c2,
                                  fontFamily: 'MaterialIcons'),
                              text: "Schedule",
                            ),
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scheduler()),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: CardChild(
                            cardChild: IconContent(
                              icon: const IconData(0xf0555,
                                  fontFamily: 'MaterialIcons'),
                              text: "How it works",
                            ),
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserManual()),
                              );
                            },
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}
