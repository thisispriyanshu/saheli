import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/bottom_button.dart';

class IncomingCall extends StatefulWidget {
  final String name;
  final String number;
  IncomingCall({required this.name, required this.number});
  @override
  State<IncomingCall> createState() => _IncomingCallState();
}

class _IncomingCallState extends State<IncomingCall> {
  @override
  void initState(){
    super.initState();
  }
  @override
  void dispose() {
    FlutterRingtonePlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterRingtonePlayer.play();
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.lato(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Mobile: " + widget.number,
                  style: GoogleFonts.outfit(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 1.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.message,
                            color: Colors.blue,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Reply",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Swipe up to answer",
                  style: GoogleFonts.lato(),
                  textAlign: TextAlign.center,
                ),
                BottomButton(
                  name: widget.name,
                  number: widget.number,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Swipe down to decline",
                  style:GoogleFonts.lato(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
