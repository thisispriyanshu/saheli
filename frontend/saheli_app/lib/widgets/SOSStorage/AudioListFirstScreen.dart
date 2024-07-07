import 'package:flutter/material.dart';
import 'package:Saheli/widgets/SOSStorage/AudioStore.dart';

class AudioListFirstScreen extends StatelessWidget {
  final List<String> audioList = [
    'Audio 1',
    'Audio 2',
    'Audio 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio List'),
      ),
      body: ListView.builder(
        itemCount: audioList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(audioList[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioListScreen()),

              );
            },
          );
        },
      ),
    );
  }
}

class AudioPlayerScreen extends StatelessWidget {
  final String audioName;

  AudioPlayerScreen({required this.audioName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Playing $audioName',
              style: TextStyle(fontSize: 20),
            ),
            // Add audio player widget here
          ],
        ),
      ),
    );
  }
}
