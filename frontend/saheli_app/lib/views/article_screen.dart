import 'package:flutter/material.dart';
import 'package:saheli_app/widgets/article/cards.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<ArticleCard> articles = [
      ArticleCard(icon: Icons.remove_red_eye, title: "Cyberstalking", desc: "Take note if someone constantly follows"),
      ArticleCard(icon: Icons.message, title: "Unwanted messages", desc: "Take note if someone constantly follows"),
      ArticleCard(icon: Icons.image, title: "Sharing of sexual content", desc: "Take note if someone constantly follows"),
      ArticleCard(icon: Icons.remove_red_eye, title: "Cyberstalking", desc: "Take note if someone constantly follows"),
      ArticleCard(icon: Icons.remove_red_eye, title: "Cyberstalking", desc: "Take note if someone constantly follows"),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 236, 208),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Identifying Sexual harassment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return articles[index];
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
