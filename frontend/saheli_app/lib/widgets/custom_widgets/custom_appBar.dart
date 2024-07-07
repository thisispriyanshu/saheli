import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Saheli/common/utils/quotes.dart';

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
          borderRadius: BorderRadius.circular(18).copyWith(
            topLeft: Radius.zero,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Tip of the Day',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(


              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  sweetSayings[quoteIndex!],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
          // child: Container(
          //   child: Text(
          //     sweetSayings[quoteIndex!],
          //     textAlign: TextAlign.left,
          //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.secondary),
          //   ),
          // ),
        ),),);
  }
}