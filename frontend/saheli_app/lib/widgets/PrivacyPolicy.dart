import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Last Updated: January 30, 2024',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text(
              'Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our women\'s safety app.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may collect the following types of information:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text('1. Personal Information:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '   - Name, email address, phone number, and other contact information.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text('2. Location Information:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '   - We may collect your location data to provide safety features.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'How We Use Your Information',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We use the information we collect for various purposes, including:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text('- To enhance user experience and personalize content.',
                style: TextStyle(fontSize: 16.0)),
            Text('- To provide and maintain our women\'s safety features.',
                style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16.0),
            Text(
              'Security',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We prioritize the security of your information and take appropriate measures to protect it. However, no method of transmission over the internet or electronic storage is 100% secure.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
