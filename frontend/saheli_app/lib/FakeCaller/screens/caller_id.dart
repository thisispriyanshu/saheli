import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  String dialCode = '+91';

  final countryPicker = const  FlCountryCodePicker();

  FlCountryCodePicker countryPickerWithParams = const FlCountryCodePicker(
    localize: true,
    showDialCode: true,
    showSearchBar: true,
  );

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
      appBar: AppBar(
        title: Text(
          "Caller ID",
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
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 1)),
          child: Column(children: [
            Text(
              "Enter Caller ID to send Fake Call",
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Name",
              style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18.0,
              ),
              keyboardType: TextInputType.name,
              textAlign: TextAlign.left,
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(30),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "Mobile Number",
              style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final picked= await countryPicker.showPicker(context: context);
                    dialCode = picked!.dialCode;
                    setState(() {
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1)
                    ),
                    child: Text(
                      dialCode,
                      style: GoogleFonts.outfit(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: TextField(
                    style: GoogleFonts.outfit(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18.0,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      number = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                FlutterRingtonePlayer.playRingtone(asAlarm: true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomingCall(
                      name: name,
                      number: dialCode + number,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Call Now',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
