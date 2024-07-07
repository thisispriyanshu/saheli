import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Saheli/views/googleSignIn.dart';
import 'package:Saheli/views/login.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoOnboarding(
      bottomButtonColor: Theme.of(context).colorScheme.primary,
      onPressedOnLastPage: () => Navigator.pushReplacement(context,

          PageTransition(child: GoogleSignIn(), type: PageTransitionType.rightToLeftWithFade)),
      pages: [
        WhatsNewPage(
          title: const Text("Welcome To Saheli").animate().fade(duration: 500.milliseconds).shimmer(duration: 2.seconds),
          features: [
            WhatsNewFeature(
              icon: Icon(
                CupertinoIcons.location,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text(
                'Send SOS',
                style: TextStyle(fontSize: 25),
              ).animate().fadeIn(),
              description: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Send SOS messages with your current location to your selected contacts, so they can track you in emergency situations.',
                  style: TextStyle(fontSize: 15),
                ).animate().fadeIn(),
              ),
            ),
            WhatsNewFeature(
              icon: Icon(
                CupertinoIcons.map,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text(
                'Quick Access',
                style: TextStyle(fontSize: 25),
              ).animate().fadeIn(),
              description: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Quickly access police stations, hospitals and bus stands that are nearby your current location on google maps.",
                  style: TextStyle(fontSize: 15),
                ).animate().fadeIn(),
              ),
            ),
            WhatsNewFeature(
              icon: Icon(
                CupertinoIcons.phone,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text(
                'Incase Of Emergency',
                style: TextStyle(fontSize: 25),
              ).animate().fadeIn(),
              description: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Call women helpline, ambulance or state police authority in case of any emergency on a single click of a button.',
                  style: TextStyle(fontSize: 15),
                ).animate().fadeIn(),
              ),
            ),
          ],
        ),
        CupertinoOnboardingPage(
            title: const Text('Safely Reach Home with Safe Routes').animate().fadeIn().shimmer(),
            body: Image.asset("lib/assets/images/safe_route.jpg")),
        CupertinoOnboardingPage(
            title: const Text('Self Awareness about Self Defense').animate().fadeIn().shimmer(),
            body: Image.asset(
              "lib/assets/images/selfdefense.jpg",
            )),
      ],
    );
  }
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:saheli_app/views/signup.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final introKey = GlobalKey<IntroductionScreenState>();
//
//   void _onIntroEnd(context) {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => const SignupPage()),
//     );
//   }
//
//   Widget _buildImage(String assetName, [double width = 350]) {
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(40),
//         child: Image.asset('assets/$assetName', width: width));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 20);
//
//     const pageDecoration = PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       pageColor: Colors.white,
//       imagePadding: EdgeInsets.all(10),
//     );
//
//     return Scaffold(
//       body: SafeArea(
//         child: IntroductionScreen(
//           key: introKey,
//           globalBackgroundColor: Colors.white,
//           allowImplicitScrolling: true,
//           autoScrollDuration: 3000,
//           infiniteAutoScroll: true,
//           globalFooter: SizedBox(
//             width: double.infinity,
//             height: 60,
//             child: ElevatedButton(
//               child: const Text(
//                 'Signup',
//                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//               onPressed: () => _onIntroEnd(context),
//             ),
//           ),
//           pages: [
//             PageViewModel(
//               title: "Home Screen",
//               body:
//               "Send SOS message with location",
//               image: _buildImage('sos_messages.jpg'),
//               decoration: pageDecoration,
//             ),
//             PageViewModel(
//               title: "Quick Safety Access",
//               body:
//               "Quickly access nearby police stations, ambulance, bus stands in one click",
//               image: _buildImage('quick_safety.jpg'),
//               decoration: pageDecoration,
//             ),
//             PageViewModel(
//               title: "Safe Routes",
//               body:
//               " Safely reach home with Safe routes",
//               image: _buildImage('safe_routes.jpg'),
//               decoration: pageDecoration,
//             ),
//             PageViewModel(
//               title: "Self Awareness",
//               body:
//               "Read and be informed about self defense, well aware about surroundings",
//               image: _buildImage('self_defense.jpg'),
//             ),
//             PageViewModel(
//               title: "Emergency Contacts",
//               body: "Add your emergency contacts to get them to know about your situation in one click",
//               image: _buildImage('emergency_contacts.jpg'),
//               decoration: pageDecoration.copyWith(
//                 bodyFlex: 6,
//                 imageFlex: 6,
//                 safeArea: 80,
//               ),
//             ),
//           ],
//           onDone: () => _onIntroEnd(context),
//           onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//           showSkipButton: true,
//           skipOrBackFlex: 0,
//           nextFlex: 0,
//           showBackButton: false,
//           back: const Icon(Icons.arrow_back),
//           skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
//           next: const Icon(Icons.arrow_forward),
//           done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//           curve: Curves.fastLinearToSlowEaseIn,
//           controlsMargin: const EdgeInsets.all(16),
//           controlsPadding: kIsWeb
//               ? const EdgeInsets.all(12.0)
//               : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//           dotsDecorator: const DotsDecorator(
//             size: Size(10.0, 10.0),
//             color: Color(0xFFBDBDBD),
//             activeSize: Size(22.0, 10.0),
//             activeShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(25.0)),
//             ),
//           ),
//           dotsContainerDecorator: const ShapeDecoration(
//             color: Colors.black87,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8.0)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
