import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/widgets/custom_widgets/safewebview.dart';

class ArticleCard extends StatefulWidget {
  ArticleCard(
      {super.key, required this.icon, required this.title, required this.desc});

  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  IconData icon;
  String title;
  String desc;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(widget.icon, color: Theme.of(context).colorScheme.secondary,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).colorScheme.secondary),),
              Text(widget.desc, style: TextStyle(color: Colors.black),)
            ],
          ),
          InkWell(
            child: Icon(Icons.arrow_right_alt_rounded, color: Theme.of(context).colorScheme.secondary,),
            onTap: () {
              navigateToRoute(context, SafeWebView(url: "https://www.techtarget.com/searchsecurity/definition/cyberstalking",));
            },
            mouseCursor: MouseCursor.uncontrolled,
          )
        ],
      ),
    );
  }
}

void navigateToRoute(BuildContext context, Widget route) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
}