import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'incoming_call.dart';

class Scheduler extends StatefulWidget {
  static const routeName = '/Scheduler';
  const Scheduler({Key? key}) : super(key: key);

  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  int mins = 0;
  int sec = 0;
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

  scheduleCall(int sec, String name, String number) {
    Duration schedule = Duration(seconds: sec);
    Future.delayed(schedule, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IncomingCall(
            name: name,
            number: number,
          ),
        ),
      );
      FlutterRingtonePlayer.playRingtone(asAlarm: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 208),
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
          margin: const EdgeInsets.fromLTRB(30.0, 140.0, 30.0, 120.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 255, 57, 116),
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "min",
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                          textAlign: TextAlign.center,
                          controller: hourController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(":", style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10),
                    Container(
                      height: 80,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 255, 57, 116),
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: Color.fromARGB(255, 255, 57, 116),
                          decoration: InputDecoration(
                            hintText: "sec",
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                          textAlign: TextAlign.center,
                          controller: minuteController,
                          keyboardType: TextInputType.number,
                        ),
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
                  style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 236, 208),
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
                  style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
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
                  child: const Text(
                    'Set Timer',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (hourController.text.isEmpty) {
                      hourController.text = '0';
                    }
                    mins = int.parse(hourController.text);
                    sec = int.parse(minuteController.text);
                    sec = mins * 60 + sec;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                'Note',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              content: const Text(
                                  'You have to be on this screen to receive the call or'
                                  ' you can press the home button and let the app run in the background. '
                                  'When the time is up you will hear the caller tune, after clicking the '
                                  'app in the background you will be able to see the calling screen.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    scheduleCall(sec, name, number);
                                  },
                                  child: const Text("OK"),
                                  style: TextButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                ),
                              ]);
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                //scheduleCall(sec),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
