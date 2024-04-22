import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserManual extends StatelessWidget {
  const UserManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'How Fake Caller Works',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Shake to Make a Fake Call",
                    style: GoogleFonts.outfit(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  )),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                  child: Image.asset("lib/assets/images/fakeCall.jpg")),
              const SizedBox(
                height: 20,
              ),
              Text(
                "How to Use:",
                style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Step1:- Shake your phone to get a fake call.",
                style: GoogleFonts.outfit(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Step2:- Receive the call.",
                style: GoogleFonts.outfit(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Step3:- Allow your current location to be sent to your saved contacts.",
                style: GoogleFonts.outfit(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Container(
    //         //color: const Color(0xFF00001A),
    //         padding:
    //             const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //               colorFilter: ColorFilter.mode(
    //                   Colors.black.withOpacity(0.2), BlendMode.dstATop),
    //               image: const AssetImage(
    //                 "assets/images/image5.jpeg",
    //               ),
    //               fit: BoxFit.cover),
    //         ),
    //         child: const Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //
    //             Text(
    //               '➋ For how long the call be active?',
    //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //             SizedBox(
    //               height: 5.0,
    //             ),
    //             Text(
    //               'As long as you want unless and until you press the cancel button.',
    //                 style: TextStyle(fontSize: 18)
    //             ),
    //             SizedBox(
    //               height: 15.0,
    //             ),
    //             Text(
    //               '➌ Can I lock the screen after setting the timer?',
    //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
    //             SizedBox(
    //               height: 5.0,
    //             ),
    //             Text(
    //               'Yes, you can do that. As soon as the time is up, you '
    //               'will hear your caller tune, but no calling screen will be visible.'
    //               'The calling screen will only be visible after you unlock the phone.\n'
    //               'PS: You have to be on the timer screen.',
    //                 style: TextStyle(fontSize: 18)
    //             ),
    //             SizedBox(
    //               height: 15.0,
    //             ),
    //             Text(
    //               '➍ Will I receive a call if I set the timer and let the app run in the background?',
    //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
    //             ),
    //             SizedBox(
    //               height: 5.0,
    //             ),
    //             Text(
    //               'Yes, you will receive the call. You will only hear the caller'
    //               'tune first, and then on clicking the app in the background you will be able to see the calling screen.',
    //                 style: TextStyle(fontSize: 18)
    //             ),
    //             SizedBox(
    //               height: 15.0,
    //             ),
    //             Text(
    //               '➎ Can I make a gesture to receive fake calls?',
    //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //             SizedBox(
    //               height: 5.0,
    //             ),
    //             Text(
    //               'No. Currently your android operating system won\'t allow that. But maybe in the future'
    //               ' we will add that functionality.',
    //                 style: TextStyle(fontSize: 18)
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
