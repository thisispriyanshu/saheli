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
      appBar: AppBar(
        title: Text(
          "Schedule Call",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 1),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Center(
                      child: TextField(
                        cursorColor: Theme.of(context).colorScheme.primary,
                        decoration: InputDecoration(
                          hintText: "Min",
                          hintStyle: GoogleFonts.outfit(fontSize: 16.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: GoogleFonts.outfit(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                        controller: hourController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ":",
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Center(
                      child: TextField(
                        cursorColor: Theme.of(context).colorScheme.primary,
                        decoration: InputDecoration(
                          hintText: "sec",
                          hintStyle: GoogleFonts.outfit(fontSize: 16.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: GoogleFonts.outfit(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                        controller: minuteController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Name",
                style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                style: GoogleFonts.outfit(
                  fontSize: 16.0,
                ),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Number",
                style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                style: GoogleFonts.outfit(
                  fontSize: 16.0,
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  number = value;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
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
                            title: Text(
                              'Note',
                              style: GoogleFonts.outfit(
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
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text("OK"),
                              ),
                            ]);
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Set Timer',
                    style: GoogleFonts.outfit(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              //scheduleCall(sec),
            ],
          ),
        ),
      ),
    );
  }
}
