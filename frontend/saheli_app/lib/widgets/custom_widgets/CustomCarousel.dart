import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Saheli/common/utils/quotes.dart';
import 'package:Saheli/widgets/custom_widgets/safewebview.dart';

class CustomCarouel extends StatelessWidget {
  const CustomCarouel({Key? key}) : super(key: key);

  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: List.generate(
        imageSliders.length,
            (index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: () {
              if (index == 0) {
                navigateToRoute(
                    context,
                    SafeWebView(
                        url:
                        "https://www.workflowmax.com/blog/18-inspiring-articles-by-empowering-women-that-will-change-your-life"));
              } else if (index == 1) {
                navigateToRoute(
                    context,
                    SafeWebView(
                        url:
                        "https://plan-international.org/ending-violence/16-ways-end-violence-girls"));
              } else if (index == 2) {
                navigateToRoute(
                    context,
                    SafeWebView(
                        url:
                        "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
              } else {
                navigateToRoute(
                    context,
                    SafeWebView(
                        url:
                        "https://amritmahotsav.nic.in/blogdetail.htm?75"));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        imageSliders[index],
                      ))),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ]),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      articleTitle[index],
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
