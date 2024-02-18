import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/app_colors.dart';
import '../../constants/recorder_constants.dart';

import 'widgets/audio_visualizer.dart';
import 'widgets/mic.dart';
import '../recordings_list/cubit/files/files_cubit.dart';
import '../recordings_list/view/recordings_list_screen.dart';
import '../../constants/concave_decoration.dart';
import 'cubit/record/record_cubit.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  static const routeName = '/homescreen';

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  bool hasPermission = false;

  @override
  void initState() {
    //_requestRecordAudioPermission(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text("Audio Recorder", style: TextStyle(color: Colors.white),),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      backgroundColor: AppColors.mainColor,
      body: BlocBuilder<RecordCubit, RecordState>(
        builder: (context, state) {
          if (state is RecordStopped || state is RecordInitial) {
            return SafeArea(
                child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                appTitle(),
                Spacer(),
                NeumorphicMic(onTap: () async {
                  try {
                    await _requestRecordAudioPermission(context);
                  } catch (e, stackTrace) {
                    print('Error: $e');
                    print('Stack Trace: $stackTrace');
                  }
                }),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, _customRoute());
                  },
                  child: myNotes(),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ));
          } else if (state is RecordOn) {
            return SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                appTitle(),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    StreamBuilder<double>(
                        initialData: RecorderConstants.decibleLimit,
                        stream: context.read<RecordCubit>().aplitudeStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AudioVisualizer(amplitude: snapshot.data);
                          }
                          if (snapshot.hasError) {
                            return Text(
                              'Visualizer failed to load',
                              style: TextStyle(color: AppColors.accentColor),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                    Spacer(),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.read<RecordCubit>().stopRecording();

                    ///We need to refresh [FilesState] after recording is stopped
                    context.read<FilesCubit>().getFiles();
                  },
                  child: Container(
                    decoration: ConcaveDecoration(
                      shape: CircleBorder(),
                      depression: 10,
                      colors: [
                        AppColors.highlightColor,
                        AppColors.shadowColor,
                      ],
                    ),
                    child: Icon(
                      Icons.stop,
                      color: AppColors.accentColor,
                      size: 50,
                    ),
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ));
          } else {
            return Center(
                child: Text(
              'An Error occured',
              style: TextStyle(color: AppColors.accentColor),
            ));
          }
        },
      ),
    );
  }

  Future<void> _requestRecordAudioPermission(BuildContext context) async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      // Permission already granted
      print("Permission already granted");
      context.read<RecordCubit>().startRecording();
    } else {
      // Request permission
      var result = await Permission.microphone.request();
      if (result.isGranted) {
        // Permission granted
        print("Permission granted");
        context.read<RecordCubit>().startRecording();
      } else {
        // Permission denied
        print("Permission not granted");
        // Handle accordingly (you may want to show an error message to the user)
      }
    }
  }

  Text myNotes() {
    return Text(
      'MY NOTES',
      style: TextStyle(
          color: AppColors.accentColor,
          fontSize: 20,
          letterSpacing: 5,
          shadows: [
            Shadow(
                offset: Offset(3, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2)),
          ]
          //decoration: TextDecoration.underline,
          ),
    );
  }

  Widget appTitle() {
    return Text(
      'RAPID NOTE',
      style: TextStyle(
          color: AppColors.accentColor,
          fontSize: 50,
          letterSpacing: 5,
          fontWeight: FontWeight.w200,
          shadows: [
            Shadow(
                offset: Offset(3, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2)),
          ]),
    );
  }

  Route _customRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) =>
          RecordingsListScreen(),
    );
  }
}
