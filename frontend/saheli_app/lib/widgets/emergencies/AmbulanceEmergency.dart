import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class AmbulanceEmergency extends StatelessWidget {
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 0,
      child: InkWell(
        onTap: () => _callNumber('108'),
        child: Container(
          width: 155,
          height: 250,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFD8080),
                  Color(0xFFFB8580),
                  Color(0xFFFBD079),
                ],
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white.withOpacity(0.5),
                child: Image.asset('lib/assets/images/ambulance.png'),
              ),
              const SizedBox(height: 5,),
              Text(
                ' Call Ambulance',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'In case of medical emergency click below',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    '1 0 8',
                    style: GoogleFonts.outfit(
                      color: Colors.red[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
