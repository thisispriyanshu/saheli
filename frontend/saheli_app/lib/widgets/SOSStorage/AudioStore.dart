import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sound/flutter_sound.dart';



class AudioListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Audio Storage'),
      ),
      body: AudioList(),
    );
  }
}

class AudioList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('audios').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ListView(
          children: documents.map((doc) {
            final String audioUrl = doc['audioUrl'];
            final String audioName = doc['audioName'];
            return ListTile(
              title: Text(audioName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioPlayerScreen(audioUrl: audioUrl),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl;

  AudioPlayerScreen({required this.audioUrl});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.openPlayer().then((value) {
      _player.startPlayer(
        fromURI: widget.audioUrl,
        codec: Codec.aacADTS,
      );
      // _player.onProgress.listen((event) {
      //   if (event == FlutterSoundPlayerState.PLAYING) {
      //     setState(() {
      //       _isPlaying = true;
      //     });
      //   } else {
      //     setState(() {
      //       _isPlaying = false;
      //     });
      //   }
      // });
    });
  }

  @override
  void dispose() {
    _player.stopPlayer();
    // _player.closeAudioSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: IconButton(
          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (_isPlaying) {
              _player.pausePlayer();
            } else {
              _player.resumePlayer();
            }
          },
        ),
      ),
    );
  }
}
