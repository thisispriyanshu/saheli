import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:saheli_app/widgets/Contacts/new_contacts.dart';
import '../AudioRecorder/screens/home_screen/home_screen.dart';
import '../views/article_screen.dart';
import '../views/home_screen.dart';
import 'Chatbot/chatbot.dart';
import 'Profile.dart';
import 'SafeRoutes/SafeRoutes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactsPage(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Chat', style: TextStyle( color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold),),
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          // if (isLogin) HomePage() else LoginPage(),
          HomePage(),
          AudioScreen(),
          AddContactsPage(),
          SafeRoutes(),
          Profile(),
        ],
      ) ,
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        color: const Color.fromARGB(226, 243, 243, 243),
        controller: _pageController,
        flat: true,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.home,
              label: 'Home', activeColor: Colors.orangeAccent),
          RollingBottomBarItem(Icons.record_voice_over,
              label: 'Record', activeColor: Colors.purpleAccent),
          RollingBottomBarItem(Icons.crisis_alert,
              label: 'Contacts', activeColor: Colors.redAccent),
          RollingBottomBarItem(Icons.map,
              label: 'Routes', activeColor: Colors.blueAccent),
          RollingBottomBarItem(Icons.person,
              label: 'Profile', activeColor: Colors.green),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
