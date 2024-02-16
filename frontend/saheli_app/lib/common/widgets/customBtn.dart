import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomBtn extends StatelessWidget {
  final String msg;
  final VoidCallback onTap;
  final bool loading;

  const CustomBtn({super.key, required this.msg, required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(2, 2),
                  blurRadius: 4)
            ],
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: loading
                  ? const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              )
                  : Text(msg)
            )
          ],
        ),
      ),
    );
  }
}
