import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Request Action Button
class RequestActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isAccepted;
  final bool isDeclined;

  const RequestActionButton({
    required this.text,
    required this.onPressed,
    this.isAccepted = false,
    this.isDeclined = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color borderColor = const Color(0xFF002180);
    Color textColor = const Color(0xFF002180);

    if (isAccepted) {
      backgroundColor = Colors.green.shade50;
      borderColor = Colors.green;
      textColor = Colors.green;
    } else if (isDeclined) {
      backgroundColor = Colors.red.shade50;
      borderColor = Colors.red;
      textColor = Colors.red;
    }

    return SizedBox(
      width: 100,
      height: 36,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.zero,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'NotoSans',
            ),
          ),
        ),
      ),
    );
  }
}
