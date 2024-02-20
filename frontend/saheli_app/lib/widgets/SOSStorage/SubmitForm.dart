import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'NavigationScreen.dart';

class SafeRoutesForm extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _situationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 208),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Suspicious locations form', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(

              controller: _nameController,

              decoration: InputDecoration(labelText: 'Name',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),),

            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description/Situation of place',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),),
              maxLines: 3,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _situationController,
              decoration: InputDecoration(labelText: 'Any problems faced, if any',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),),

              maxLines: 3,
            ),
            SizedBox(height: 20.0),
            Text('Select Location from Map', style: TextStyle(color: Colors.black, fontSize: 16),),
            SizedBox(height: 5.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPicker(),
                  ),
                );
              },
              icon: Icon(Icons.place),
              label: Text(
                'Select Location',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
            ),
            SizedBox(height: 240.0),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),),
              onPressed: () {
                _submitForm(context);
              },
              child: Text('Submit', style: TextStyle(color: Colors.white),),),

          ],
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    // Implement submission logic here
    // You can access the form data using _nameController.text, _descriptionController.text, _situationController.text

    // For demonstration purposes, let's just show an alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Submitted'),
          content: Text('Suspicous location details have been submitted successfully. Thank you for helping Saheli make women stronger and safer!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}



class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit suspicous locations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Enter your location',
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: latController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'latitude',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: lngController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'longitude',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapPicker()));
                },
                child: Text('Get Directions')),
          ),
        ]),
      ),
    );
  }
}