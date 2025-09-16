import 'package:flutter/material.dart';

// Chat Button
class ChatButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ChatButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 28,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF1BF2C9), width: 1),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_rounded, color: Color(0xFF1BF2C9), size: 16),
            SizedBox(width: 4),
            Text(
              'Chat',
              style: TextStyle(
                color: Color(0xFF1BF2C9),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}