import 'package:flutter/material.dart';

class SOSCard extends StatelessWidget {
  SOSCard({required this.cardChild, required this.onPress});
  final Widget cardChild;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(

        child: cardChild,
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0, bottom: 50.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 57, 116),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
