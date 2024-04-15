import 'package:flutter/material.dart';




class DuringCallBody extends StatefulWidget {
  // static const routeName = '/CallerScreen';
  @override
  _DuringCallBodyState createState() => _DuringCallBodyState();
}

class _DuringCallBodyState extends State<DuringCallBody> {
  String callDuration = "00:00"; // Initial call duration
  bool showDialpad = false; // Track if dialpad is shown or not

  // Function to toggle dialpad visibility
  void toggleDialpad() {
    setState(() {
      showDialpad = !showDialpad;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Call duration display
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            callDuration,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        // Dialpad toggle button
        ElevatedButton(
          onPressed: toggleDialpad,
          child: Text("Toggle Dialpad"),
        ),
        // Dialpad
        if (showDialpad)
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              children: List.generate(
                10,
                    (index) => ElevatedButton(
                  onPressed: () {
                    // Handle dialpad button click
                  },
                  child: Text((index + 1).toString()),
                ),
              )..add(
                ElevatedButton(
                  onPressed: () {
                    // Handle 0 button click
                  },
                  child: Text("0"),
                ),
              ),
            ),
          ),
        // Red call button
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: ElevatedButton(
            onPressed: () {
              // Implement call hang-up functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(
              "End Call",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ],
    );
  }
}
