import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorController extends GetxController {
  var currentAcceleration = 0.0.obs;
  RxBool isHarshBraking = false.obs;
}

class BrakingDetectorScreen extends StatefulWidget {
  const BrakingDetectorScreen({Key? key}) : super(key: key);

  @override
  State<BrakingDetectorScreen> createState() => _BrakingDetectorScreenState();
}

class _BrakingDetectorScreenState extends State<BrakingDetectorScreen> {
  double previousAcceleration = 0.0;
  double threshold = 10.0; // Adjust this threshold as needed
  final sensorController = Get.put(SensorController());

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      double acceleration = event.y; // You can use other axes as needed
      sensorController.currentAcceleration.value = acceleration;
      if ((previousAcceleration - acceleration) >= threshold) {
        // Harsh braking detected, take action here
        print('Harsh braking detected!');
        print('Please drive slowly!');
        sensorController.isHarshBraking.value = true;
        _showHarshBrakingDialog(); // Show dialog box when harsh braking is detected
      } else {
        sensorController.isHarshBraking.value = false;
      }
      previousAcceleration = acceleration;
    });
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerEvents.drain();
  }

  void _showHarshBrakingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Harsh Braking Detected'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
                size: 48,
              ),
              SizedBox(height: 10),
              Text(
                'Please drive slowly!',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Braking Detector'),
        ),
        body: Obx(
              () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Listening to accelerometer data : ${sensorController.currentAcceleration.toString()}',
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: sensorController.isHarshBraking.value,
                  child: const Text(
                    "Harsh Braking",
                    style: TextStyle(fontSize: 22, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
