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
              final message = messages.messages[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: ChatBubble(
                  title: message,
                  isBlue: index % 2 == 1,
                ),
              );
            },
          ),
        );
      },
    );
  }
}