import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/chat/message.dart';
import 'bubble.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Messages>(
      builder: (context, messages, child) {
        return ListView.builder(
          itemCount: messages.messages.length,
          itemBuilder: (context, index) {
            final message = messages.messages[index];
            return ChatBubble(
              title: message,
              isBlue: index % 2 == 0,
            );
          },
        );
      },
    );
  }
}