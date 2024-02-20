import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'incoming_call.dart';

class CallerID extends StatefulWidget {
  static const routeName = '/CallerID';

  @override
  State<CallerID> createState() => _CallerIDState();
}

class _CallerIDState extends State<CallerID> {
  bool isIDBannerLoaded = false;

  String name = "UNKNOWN";
  String number = "(410) 0679 890";


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: false,

      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //         "assets/images/image4.jpeg",
        //       ),
        //       fit: BoxFit.cover),
        // ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 120.0),
          padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 250,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    "Enter Caller ID to send Fake Call",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(
                height: 1.0,
              ),
            ),
            Text(
              "Name",
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 22.0,
              ),
              keyboardType: TextInputType.name,
              textAlign: TextAlign.left,
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                //contentPadding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Number",
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 22, fontWeight: FontWeight.bold),

            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 236, 208),
                fontSize: 22.0,
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              onChanged: (value) {
                number = value;
              },
              decoration: InputDecoration(
                //contentPadding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 1.0,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterRingtonePlayer.playRingtone(asAlarm: true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomingCall(
                      name: name,
                      number: number,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Call Now', style: TextStyle(color: Colors.white, fontSize: 22),),
            ),
          ]),
        ),
      ),
    );
  }
}
