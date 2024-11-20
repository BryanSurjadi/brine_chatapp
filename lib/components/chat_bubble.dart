import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        shape: BoxShape.rectangle,
        color: isMe
            ? Colors.grey.shade500
            : Colors.green.shade500.withOpacity(
                0.8,
              ),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Text(
        message,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: isMe ? Colors.black : Colors.black),
      ),
    );
  }
}
