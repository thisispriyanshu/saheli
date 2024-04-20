import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import 'package:audioplayers/audioplayers.dart';

class AudioListFirstScreen extends StatefulWidget {
  @override
  _AudioListFirstScreenState createState() => _AudioListFirstScreenState();
}

class _AudioListFirstScreenState extends State<AudioListFirstScreen> {
  late Future<Map<String, List<String>>> _audioListFuture;
  late Future<Map<String, String>> _audioUrls;

  @override
  void initState() {
    super.initState();
    _audioListFuture = fetchAudioList();
    _audioUrls=fetchUrls();
    // _audioUrls=fetchAudioUrls();

  }

  Future<Map<String, List<String>>> fetchAudioList() async {
    Map<String, List<String>> audioMap = {};

    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference ref = storage.ref().child('audio');

    try {
      ListResult result = await ref.listAll();
      for (Reference item in result.items) {
        final metadata = await item.getMetadata();
        final dateString = metadata.timeCreated!.toLocal().toString().split(' ')[0];
        final url=item.getDownloadURL();
        audioMap.putIfAbsent(dateString, () => []);
        String audioName = 'Audio ${audioMap[dateString]!.length + 1}';
        audioMap[dateString]!.add(audioName);
      }
      return audioMap;
    } catch (error) {
      print('Error fetching audio URLs: $error');
      // Handle error
      return {};
    }
  }

  Future<Map<String, String>> fetchUrls() async {
    Map<String, String> audioMap = {};

    // Access Firebase Cloud Storage
    final FirebaseStorage storage = FirebaseStorage.instance;
    // Reference to the 'audio' folder
    final Reference ref = storage.ref().child('audio');

    try {
      // List all items (audio files) in the 'audio' folder
      ListResult result = await ref.listAll();

      for (Reference item in result.items) {
        final metadata = await item.getMetadata();
        final dateString = metadata.timeCreated!.toLocal().toString().split(' ')[0];
        final url=item.getDownloadURL();

        audioMap.putIfAbsent(dateString, () => "");

        String audioName = 'Audio ${audioMap[dateString]!.length + 1}';
        // audioMap[dateString]!.(audioName);
        audioMap[audioName]=url.toString();
      }
      return audioMap;
    } catch (error) {
      print('Error fetching audio URLs: $error');
      // Handle error
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio List'),
      ),
      body: FutureBuilder<Map<String, List<String>>>(
        future: _audioListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerList();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String date = snapshot.data!.keys.elementAt(index);
                List<String> audioNames = snapshot.data![date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        date,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...audioNames.map((audioName) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color.fromARGB(255, 235, 236, 240),
                          child: ListTile(
                            title: Text(audioName),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                      return FutureBuilder<Map<String, String>>(
                                        future: _audioUrls,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // Future is still loading, return a loading indicator or handle accordingly
                                            return CircularProgressIndicator(); // Or any other loading indicator
                                          } else if (snapshot.hasError) {
                                            // Future has error, handle error state
                                            return Text('Error: ${snapshot
                                                .error}');
                                          } else {
                                            // Future has completed, navigate to DetailedScreen with the resolved URL
                                            Map<String,
                                                String> audioUrls = snapshot
                                                .data!;
                                            String? audioUrl = audioUrls[audioName];
                                            return DetailedScreen(
                                              'Audio ${index + 1}',
                                              'Artist ${index + 1}',
                                              'Image URL ${index + 1}',
                                              audioUrl,
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height,
                                            );
                                          }
                                        },
                                      );

                                  }
                              ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                    Divider(), // Add a divider between each group
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5, // Placeholder for shimmer effect
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListTile(
                title: Container(
                  width: 200,
                  height: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Divider(), // Add a divider between each group
          ],
        );
      },
    );
  }

  // Future<Map<String, String>> fetchAudioUrls () {}
}



var bgColor = Color(0xFF090e42);
var pinkColor = Color(0xFFff6b80);

class DetailedScreen extends StatefulWidget {
  final title, artist, image, url, height;

  const DetailedScreen(
      this.title, this.artist, this.image, this.url, this.height);

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  static bool firstRender = false;
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";
  double sliderValue = 0.0, completeTimeInMicroseconds = 0.0;

  // String _printDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, "0");
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //   return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  // }

  void play() async {
    Fluttertoast.showToast(msg: "Url is "+widget.url);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Url is '+widget.url)));
    await _audioPlayer.play(widget.url);
    int status =1;
    if (status == 1) {
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    play();
  }

  @override
  void didUpdateWidget(covariant DetailedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.title.length != 0) {
      if (oldWidget.title != widget.title) firstRender = false;
      if (!firstRender) play();
      firstRender = true;
      _audioPlayer.onPositionChanged.listen((Duration duration) {
        setState(() {
          currentTime = duration.toString().split(".")[0];
          sliderValue =
              duration.inMicroseconds.toDouble() / completeTimeInMicroseconds;
        });
      });
      _audioPlayer.onDurationChanged.listen((Duration duration) {
        setState(() {
          completeTime = duration.toString().split(".")[0];
          completeTimeInMicroseconds = duration.inMicroseconds.toDouble();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;


    // onWillPop: () {
    //   _audioPlayer.pause();
    //   Navigator.of(context).pop(true);
    //   widget.callback(widget.title, widget.artist, widget.image, widget.url);
    //   return Future.value(true);
    // },

    if (widget.title.length == 0)
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF111111),
            border: Border.all(
              width: 0.0,
            ),
          ),
          child: Container(
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF424242),
                width: 1.0,
              ),
              color: Color(0xFF212121),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0)),
            ),
            child: Center(
              child: Text(
                'Select a song to play!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      );

    if (widget.height <= _screenSize.height * 0.10) {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFF111111),
          border: Border.all(
            width: 0.0,
          ),
        ),
        child: Container(
          padding: new EdgeInsets.fromLTRB(0, 8, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF424242),
              width: 1.0,
            ),
            color: Color(0xFF212121),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0)),
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(widget.image),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                Text(
                  widget.artist,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: isPlaying
                ? IconButton(
              iconSize: 40.0,
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.pause,
                color: Colors.white,
              ),
              onPressed: () {
                _audioPlayer.pause();
                setState(() {
                  isPlaying = false;
                });
              },
            )
                : IconButton(
              iconSize: 40.0,
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                _audioPlayer.resume();
                setState(() {
                  isPlaying = true;
                });
              },
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: Column(
          children: <Widget>[
            Container(
              height: _screenSize.height * 0.65,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [bgColor.withOpacity(0.4), bgColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: _screenSize.height * 0.06848659003831417),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'PLAYLIST',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6)),
                                ),
                                Text('Best Vibes of the Week',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Spacer(),
                        Text(widget.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32.0)),
                        SizedBox(
                          height: _screenSize.height * 0.008,
                        ),
                        Text(
                          widget.artist,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 18.0),
                        ),
                        SizedBox(height: _screenSize.height * 0.021),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: _screenSize.height * 0.055),
            Slider(
              onChanged: (double value) {
                setState(() {
                  sliderValue = value;
                  double currentTimeInMicroseconds =
                      value * completeTimeInMicroseconds;
                  final now =
                  Duration(microseconds: currentTimeInMicroseconds.toInt());
                  _audioPlayer.seek(now);
                });
              },
              value: sliderValue,
              activeColor: pinkColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    currentTime,
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  Text(
                    completeTime,
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.fast_rewind,
                  color: Colors.white54,
                  size: 42.0,
                ),
                SizedBox(width: _screenSize.width * 0.08),
                Container(
                    decoration: BoxDecoration(
                        color: pinkColor,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isPlaying
                          ? IconButton(
                        iconSize: 58.0,
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _audioPlayer.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        },
                      )
                          : IconButton(
                        iconSize: 58.0,
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _audioPlayer.resume();
                          setState(() {
                            isPlaying = true;
                          });
                        },
                      ),
                    )),
                SizedBox(width: _screenSize.width * 0.08),
                Icon(
                  Icons.fast_forward,
                  color: Colors.white54,
                  size: 42.0,
                )
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.bookmark_border,
                  color: pinkColor,
                ),
                Icon(
                  Icons.shuffle,
                  color: pinkColor,
                ),
                Icon(
                  Icons.repeat,
                  color: pinkColor,
                ),
              ],
            ),
            SizedBox(height: _screenSize.height * 0.04),
          ],
        ),
      ),
    );
  }
}

