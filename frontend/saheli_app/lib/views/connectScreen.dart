// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class BluetoothScreen extends StatefulWidget {
//   @override
//   _BluetoothScreenState createState() => _BluetoothScreenState();
//   final List<BluetoothDevice> devicesList = [];
// }
//
//
//
// class _BluetoothScreenState extends State<BluetoothScreen> {
//   // FlutterBluePlus flutterBlue=FlutterBluePlus();
//   List<BluetoothDevice> devices = [];
//   BluetoothDevice? selectedDevice;
//   bool isConnecting = false;
//   bool isConnected = false;
//

//   _addDeviceTolist(final BluetoothDevice device) {
//     if (!widget.devicesList.contains(device)) {
//       setState(() {
//         widget.devicesList.add(device);
//       });
//     }
//   }
//   Future<void> _startScan() async {
//     @override
//     void initState() {
//       () async {
//         var status = await Permission.location.status;
//         if (status.isDenied) {
//           final status = await Permission.location.request();
//           if (status.isGranted || status.isLimited) {
//             _initBluetooth();
//           }
//         } else if (status.isGranted || status.isLimited) {
//           _initBluetooth();
//         }
//
//         if (await Permission.location.status.isPermanentlyDenied) {
//           openAppSettings();
//         }
//       }();
//       super.initState();
//     }
//   }
//   ListView _buildListViewOfDevices() {
//     List<Container> containers = [];
//     for (BluetoothDevice device in widget.devicesList) {
//       containers.add(
//         Container(
//           height: 50,
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   children: <Widget>[
//                     Text(device.name == '' ? '(unknown device)' : device.name),
//                     Text(device.id.toString()),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 child: Text(
//                   'Connect',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         ...containers,
//       ],
//     );
//   }
//   _initBluetooth() async {
//     var subscription = FlutterBluePlus.onScanResults.listen(
//           (results) {
//         if (results.isNotEmpty) {
//           for (ScanResult result in results) {
//             _addDeviceTolist(result.device);
//           }
//         }
//       },
//       onError: (e) => ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.toString()),
//         ),
//       ),
//     );
//
//     FlutterBluePlus.cancelWhenScanComplete(subscription);
//
//     await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;
//
//     await FlutterBluePlus.startScan();
//
//     await FlutterBluePlus.isScanning.where((val) => val == false).first;
//     FlutterBluePlus.connectedDevices.map((device) {
//       _addDeviceTolist(device);
//     });
//   }
//   Future<void> _connectToDevice(BluetoothDevice device) async {
//     setState(() {
//       isConnecting = true;
//     });
//     try {
//       await device.connect();
//       setState(() {
//         isConnecting = false;
//         isConnected = true;
//         selectedDevice = device;
//       });
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         isConnecting = false;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: Text('Add smart device'),
//     ),
//     body:Center(
//   child: LoadingAnimationWidget.flickr(
//     leftDotColor: Theme.of(context).primaryColor,// LoadingAnimationwidget that call the
//   rightDotColor: Colors.green,                          // staggereddotwave animation
//     size: 50,
//   ),
//     // _buildListViewOfDevices(),
//   ));
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Bluetooth Devices'),
//   //     ),
//   //     body: Column(
//   //       children: [
//   //         isConnecting
//   //             ? _buildConnectingDialog()
//   //             : SizedBox(),
//   //         Expanded(
//   //           child: ListView.builder(
//   //             itemCount: devices.length,
//   //             itemBuilder: (context, index) {
//   //               return Card(
//   //                 elevation: 4,
//   //                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//   //                 child: ListTile(
//   //                   title: Text(devices[index].name ?? 'Unknown Device'),
//   //                   onTap: () => _connectToDevice(devices[index]),
//   //                 ),
//   //               );
//   //             },
//   //           ),
//   //         ),
//   //         if (isConnected)
//   //           Lottie.asset('assets/success_animation.json',
//   //               width: 150, height: 150),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildConnectingDialog() {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(20),
//             child: Lottie.asset(
//               'assets/connecting_animation.json',
//               width: 150,
//               height: 150,
//               fit: BoxFit.fill,
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Connecting to SOS Sender Device',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             'For the safety features of Saheli - Women Safety App',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BluetoothDevice {
  final String name;
  final String id;
  bool connected;

  BluetoothDevice(
      {required this.name, required this.id, this.connected = false});
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothDeviceListWidgetState createState() =>
      _BluetoothDeviceListWidgetState();
}

class _BluetoothDeviceListWidgetState extends State<BluetoothScreen> {
  List<BluetoothDevice> devices = [
    BluetoothDevice(name: "Samsung smart glass", id: "1"),
    BluetoothDevice(name: "Saheli smart glass", id: "2"),
    BluetoothDevice(name: "Airdopes 141", id: "3"),
  ];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
  }

  bool connecting = false;
  bool loading = true;
  String? connectingToDevice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Devices"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 8,
            // ),
            Container(
              //height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'lib/assets/images/smart_connect2.jpg',
                      //width: 350,
                      color: Colors.black.withOpacity(0.4),
                      colorBlendMode: BlendMode.multiply,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect smart device to Saheli',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Connect your smart device with the app and unlock the real power of Saheli with built-in state-of-the-art artificial intelligence features!',
                          style: GoogleFonts.outfit(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Available Devices",
                textAlign: TextAlign.left,
                style: GoogleFonts.outfit(
                    fontSize: 24, fontWeight: FontWeight.w400),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return loading
                    ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                    )
                    : SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: devices.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            BluetoothDevice device = devices[index];
                            return Container(
                              //padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2)),
                              child: Card(
                                elevation: 0,
                                child: ListTile(
                                  tileColor:
                                      Theme.of(context).colorScheme.secondary,
                                  title: Text(device.name),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          device.connected
                                              ? 'Connected'
                                              : 'Disconnected',
                                          style: TextStyle(
                                              color: device.connected
                                                  ? Colors.green
                                                  : Colors.grey)),
                                      SizedBox(width: 10),
                                      IconButton(
                                        icon: Icon(Icons.bluetooth),
                                        onPressed: connecting
                                            ? null
                                            : () {
                                                setState(() {
                                                  connecting = true;
                                                  connectingToDevice =
                                                      device.name;
                                                });
                                                _connectedToDevice(device);
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _connectedToDevice(BluetoothDevice device) {
    // Simulating connecting to the device
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          _connectToDevice(device);
          setState(() {
            device.connected = true;
            connecting = false;
          });
        });
        return AlertDialog(
          title: Text("Connecting"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.pinkAccent, size: 20),
              SizedBox(height: 10),
              Text("Connecting to ${connectingToDevice}..."),
            ],
          ),
        );
      },
    );
  }

  void _connectToDevice(BluetoothDevice device) {
    // Simulating connecting to the device

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        connecting = false;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Connected"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Successfully connected to $connectingToDevice!"),
                    ],
                  ),
                ],
              ),
            );
          },
        );

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            device.connected = true;
          });
        });
      });
    });
  }
}
