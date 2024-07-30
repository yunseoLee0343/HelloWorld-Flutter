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
        return Container(
          height: 540,
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: messages.messages.length,
            itemBuilder: (context, index) {
              final messageData = messages.messages[index];
              final message = messageData['message'];
              final isBlue = messageData['isBlue'];
              final isLastMessage = index == messages.messages.length - 1;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                alignment: isBlue ? Alignment.centerRight : Alignment.centerLeft,
                child: ChatBubble(
                  title: message,
                  isBlue: isBlue,
                  isLastMessage: isLastMessage,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
