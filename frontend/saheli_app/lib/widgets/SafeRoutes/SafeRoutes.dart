import 'package:flutter/material.dart';

class SafeRoutes extends StatelessWidget {
  const SafeRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.blue),
        child: const Icon(
          Icons.map,
          size: 70,
        ),
      ),
    );
  }
}