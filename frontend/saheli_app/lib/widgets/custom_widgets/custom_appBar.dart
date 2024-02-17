import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  // const CustomAppBar({super.key});
  Function? onTap;
  int? quoteIndex;
  CustomAppBar({this.onTap, this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20).copyWith(
            topLeft: Radius.zero,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            sweetSayings[quoteIndex!],
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      // child: Container(
      //   child: Text(
      //     sweetSayings[quoteIndex!],
      //     textAlign: TextAlign.left,
      //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.secondary),
      //   ),
      // ),
    );
  }
}
