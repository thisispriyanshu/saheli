
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
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';
import 'package:volume_watcher/volume_watcher.dart';

import '../db/databases.dart';
import '../model/PhoneContact.dart';
import '../widgets/NearbyLocations/nearby_places.dart';
import '../widgets/emergency.dart';


class HomePage extends StatefulWidget {
  int qIndex = 0;

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
  void initState(){
    super.initState();
    getRandomQuote();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
          child: Column(
            children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: CustomAppBar(
                  quoteIndex: qIndex,
                  onTap: getRandomQuote(),
                ),
            ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 10),
                    //SafeHome(),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Incase of Emergency",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Emergency(),
                    const SizedBox(height: 5),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Find on Map",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                        child: const LiveSafe()),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Explore Inspiring Stories",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const CustomCarouel(),
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }


}
