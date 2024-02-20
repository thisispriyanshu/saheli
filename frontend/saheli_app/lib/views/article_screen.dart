import 'package:flutter/material.dart';
import 'package:saheli_app/widgets/article/cards.dart';
import 'package:saheli_app/widgets/custom_widgets/safewebview.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToRoute(BuildContext context, Widget route) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => route));
    }

    final List<String> url = [
      "https://www.techtarget.com/searchsecurity/definition/cyberstalking",
      "https://www.forbesindia.com/article/brand-connect/legal-provisions-and-steps-to-report-online-harassment-against-women/79393/1",
      "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1070813/",
      "https://www.springworks.in/blog/how-to-create-a-women-friendly-workplace/",
      "https://womenagainstcrime.com/awareness-and-assertiveness-the-front-lines-of-self-defense/",
      "https://timesofindia.indiatimes.com/life-style/relationships/love-sex/10-legal-rights-women-should-be-aware-of/photostory/105721412.cms?from=md",
    ];

    final List<ArticleCard> articles = [
      ArticleCard(
          icon: Icons.remove_red_eye,
          title: "Cyberstalking",
          desc: "Take note if someone constantly follows"),
      ArticleCard(
          icon: Icons.message,
          title: "Unwanted messages",
          desc:
          "Be aware of unsolicited sexually explicit messages, images or videos"),
      ArticleCard(
          icon: Icons.image,
          title: "Sharing of sexual content",
          desc: "If someone shares your intimate photos or videos"),
      ArticleCard(
          icon: Icons.work,
          title: "Workplace policies",
          desc: "How to create a women-friendly workplace"),
      ArticleCard(
          icon: Icons.sports_martial_arts,
          title: "Assertiveness and self-defense",
          desc: "Awareness and assertiveness: The front lines of self-defense"),
      ArticleCard(
          icon: Icons.woman,
          title: "Legal rights",
          desc: "Women should be aware of legal rights"),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text("Safety Articles", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                  //scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: articles[index],
                      onTap: () {
                        navigateToRoute(
                            context,
                            SafeWebView(
                              url: url[index],
                            ));
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
