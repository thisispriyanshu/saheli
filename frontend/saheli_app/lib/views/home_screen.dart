import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saheli_app/common/widgets/customBtn.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/widgets/Chatbot/chatbot.dart';
import 'package:saheli_app/widgets/SafeRoutes/SafeHome.dart';
import 'package:saheli_app/widgets/custom_widgets/CustomCarousel.dart';
import 'package:saheli_app/widgets/custom_widgets/custom_appBar.dart';
import 'package:saheli_app/widgets/emergencies/AmbulanceEmergency.dart';
import 'package:saheli_app/widgets/emergencies/PoliceEmergency.dart';
import 'package:saheli_app/widgets/emergencies/WomenHelpline.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import '../db/databases.dart';
import '../model/PhoneContact.dart';
import '../widgets/NearbyLocations/nearby_places.dart';
import '../widgets/emergency.dart';
import 'community.dart';
import 'connectScreen.dart';

class HomePage extends StatefulWidget {
  int qIndex = 0;

  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  int qIndex = 0;
  @override
  void initState() {
    super.initState();
    getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: CustomAppBar(
                  quoteIndex: qIndex,
                  onTap: getRandomQuote(),
                ),
              ),
              const SizedBox(height: 10),
              //SafeHome(),
        Column(

          children: [
            Text(
              "Smart connect",
              style: GoogleFonts.outfit(
                  fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'lib/assets/images/hardware_iot.jpg',
                          width: 350,
                          color: Colors.black.withOpacity(0.4),
                          colorBlendMode: BlendMode.multiply,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Connect smart device to Saheli',
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
                              'Connect your smart device with the app and unlock the real power of Saheli with built-in state-of-the-art artificial intelligence features!',
                              style: GoogleFonts.outfit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  bool result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BluetoothScreen(),
                                    ),
                                  );

                                },
                                child: Text(
                                  'Connect',
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
              const SizedBox(height: 10),
              Text(
                "Quick Emergency Services",
                style: GoogleFonts.outfit(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              //const Emergency(),
              Row(
                children: [
                  Expanded(child: PoliceEmergency()),
                  Expanded(child: AmbulanceEmergency()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ArmyEmergency(),
              const SizedBox(height: 30),
              Text(
                "Find on Map",
                style: GoogleFonts.outfit(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Container(alignment: Alignment.center, child: const LiveSafe()),
              const SizedBox(height: 10),
              Text(
                "Join Community",
                style: GoogleFonts.outfit(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommunitySection()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group,
                        size: 50,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Community',
                        style: GoogleFonts.outfit(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Join the women community and share your thoughts!',
                        style: GoogleFonts.outfit(
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Explore Inspiring Stories",
                style: GoogleFonts.outfit(
                    fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              const CustomCarouel(),
            ],
          ),
        ],
        ),
      ),
    ));
  }
}

class ConnectScreen {
  const ConnectScreen();
}
