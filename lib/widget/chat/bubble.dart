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
      padding: EdgeInsets.all(16),
      width: 270,
      decoration: BoxDecoration(
        color: isBlue ? Color.fromRGBO(51, 105, 255, 1): Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(isBlue ? 16 : 0),
          bottomRight: Radius.circular(isBlue ? 0 : 16),
        ),
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
