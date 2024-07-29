import 'package:flutter/material.dart';

// Chat 위젯 정의
class ChatBubble extends StatelessWidget {
  final String title;
  final bool isBlue;

  const ChatBubble({
    required this.title,
    required this.isBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isBlue ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isBlue ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
