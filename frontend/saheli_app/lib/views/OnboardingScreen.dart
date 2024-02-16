import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:saheli_app/views/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SignupPage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.asset('assets/$assetName', width: width));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 20);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.all(10),
    );

    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          infiniteAutoScroll: true,
          globalFooter: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              child: const Text(
                'Signup',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
          pages: [
            PageViewModel(
              title: "Home Screen",
              body:
              "Send SOS message with location",
              image: _buildImage('sos_messages.jpg'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Quick Safety Access",
              body:
              "Quickly access nearby police stations, ambulance, bus stands in one click",
              image: _buildImage('quick_safety.jpg'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Safe Routes",
              body:
              " Safely reach home with Safe routes",
              image: _buildImage('safe_routes.jpg'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Self Awareness",
              body:
              "Read and be informed about self defense, well aware about surroundings",
              image: _buildImage('self_defense.jpg'),
            ),
            PageViewModel(
              title: "Emergency Contacts",
              body: "Add your emergency contacts to get them to know about your situation in one click",
              image: _buildImage('emergency_contacts.jpg'),
              decoration: pageDecoration.copyWith(
                bodyFlex: 6,
                imageFlex: 6,
                safeArea: 80,
              ),
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          back: const Icon(Icons.arrow_back),
          skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.arrow_forward),
          done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
