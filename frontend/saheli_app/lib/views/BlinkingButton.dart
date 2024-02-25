import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBlinkingButton extends StatefulWidget {
  final String buttonText;

  const MyBlinkingButton({Key? key, required this.buttonText}) : super(key: key);

  State<MyBlinkingButton> createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late String buttonText;

  @override
  void initState() {
    buttonText = widget.buttonText;
    Timer(Duration(seconds: 10), () {
      setState(() {
        buttonText = "Capturing Image";
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location Sent Successfully')));
      // _captureAndSaveImage(); // Call the function to open the camera after 3 seconds
    });

    Timer(Duration(seconds: 20), () {
      setState(() {
        buttonText = "Recording Audio";
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Captured')));
      // record(); // Call the function to start recording after 6 seconds
    });
    Timer(Duration(seconds: 30), () {
      setState(() {
        buttonText = "Sent";
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recorded Audio')));
      // record(); // Call the function to start recording after 6 seconds
    });
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: ClipOval(

        child: Container(
          height: 200,
          width: 200,
          color: Colors.red,
          alignment: Alignment.center,
          // padding: EdgeInsets.all(40.0),

          child:Text(buttonText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
          // MaterialButton(
          //
          //   onPressed: () => null,
          //   child:
          //   color: Colors.red,
          // ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}