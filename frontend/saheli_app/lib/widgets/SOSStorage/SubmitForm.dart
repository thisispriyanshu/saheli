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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Suspicious locations form', style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(

              controller: _nameController,

              decoration: const InputDecoration(labelText: 'Name',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),),

            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description/Situation of place',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),),
              maxLines: 3,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _situationController,
              decoration: const InputDecoration(labelText: 'Any problems faced, if any',labelStyle: TextStyle(color: Colors.black),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),),

              maxLines: 3,
            ),
            const SizedBox(height: 20.0),
            const Text('Select Location from Map', style: TextStyle(color: Colors.black, fontSize: 16),),
            const SizedBox(height: 5.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPicker(),
                  ),
                );
              },
              icon: const Icon(Icons.place),
              label: const Text(
                'Select Location',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 240.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _submitForm(context);
              },
              child: const Text('Submit', style: TextStyle(color: Colors.white),),),

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
          title: const Text('Form Submitted'),
          content: const Text('Suspicous location details have been submitted successfully. Thank you for helping Saheli make women stronger and safer!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
        title: const Text('Submit suspicous locations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Enter your location',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: latController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'latitude',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: lngController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'longitude',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapPicker()));
                },
                child: const Text('Get Directions')),
          ),
        ]),
      ),
    );
  }
}