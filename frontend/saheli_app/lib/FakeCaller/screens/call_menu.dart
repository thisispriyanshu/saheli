import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saheli/FakeCaller/screens/scheduler.dart';
import 'package:Saheli/FakeCaller/screens/user_manual.dart';
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
        title: Text(
          "Fake Caller",
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
              Text('Use fake caller incase of emergency',
                  style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400, fontSize: 20)),
              const SizedBox(height: 30,),
              Row(
                children: [
                  Expanded(
                    child: CardChild(
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
                        text: 'Call Now',
                        imagePath: 'lib/assets/images/callNow.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CardChild(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CallerID()),
                          );
                        },
                        text: 'Caller ID',
                        imagePath: 'lib/assets/images/callerId.png'),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: CardChild(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Scheduler()),
                          );
                        },
                        text: 'Schedule Call',
                        imagePath: 'lib/assets/images/scheduleCall.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CardChild(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserManual()),
                          );
                        },
                        text: 'How it works',
                        imagePath: 'lib/assets/images/howItWorks.png'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
