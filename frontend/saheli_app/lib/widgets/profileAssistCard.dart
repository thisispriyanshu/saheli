import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileAssistCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ProfileAssistCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  State<ProfileAssistCard> createState() => _ProfileAssistCardState();
}

class _ProfileAssistCardState extends State<ProfileAssistCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            //color: Theme.of(context).colorScheme.secondary,
          color: Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.icon,
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: Text(
                widget.title,
                style: GoogleFonts.outfit(
                    color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 8,),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
