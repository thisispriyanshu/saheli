import 'dart:async';
import 'dart:io';


import 'package:background_sms/background_sms.dart' as sms;
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:background_sms/background_sms.dart';
import 'package:background_sms/background_sms.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import '../../../db/databases.dart';
import '../../../model/PhoneContact.dart';
import '../../AudioRecorder/screens/home_screen/audioplayer.dart';

class AudioListScreen extends StatefulWidget {
  @override
  AudioPlayerState createState() => AudioPlayerState();
}


class AudioPlayerState extends State<AudioListScreen> {
  final audioPlayer=AudioPlayer();
bool isPlaying=false;
Duration duration=Duration.zero;
Duration position=Duration.zero;

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
      appBar: AppBar(title: Text('SOS Audio Collection'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              ClipRRect(borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/audio_player.jpg',
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,),

              ),
            const SizedBox(height: 32),
            const Text('sos_audio_17_02_2023',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,

            ),
            ),
            const SizedBox(height: 4),
            const Text('Unknown Details',
            ),
            Slider(
              inactiveColor: Theme.of(context).colorScheme.tertiary,
              min: 0,max: 09,value: position.inSeconds.toDouble(), onChanged: (value) async {  },

            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('00:00'),
                  Text('00:09'),

                ],
              ),
            ),
            ),
            CircleAvatar(radius: 35,
            child: IconButton(onPressed: ()async {
              if(isPlaying){

              }
              else{
                // await audioPlayer.play(url);
              }
            }, icon: Icon(isPlaying? Icons.pause:Icons.play_arrow,),
            iconSize: 50,color: Theme.of(context).colorScheme.tertiary,
            ),

            )
          ],

        ),
      ),
    );
  }
}



