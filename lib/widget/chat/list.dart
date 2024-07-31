import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/chat/message.dart';
import 'bubble.dart';

class ChatList extends StatelessWidget {
  final String userId;
  final String roomId;

  const ChatList({super.key, required this.userId, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Consumer<Messages>(
      builder: (context, messages, child) {
        final chatMessages = messages.getMessages(userId, roomId);

        return Container(
          height: 540,
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: chatMessages.length,
            itemBuilder: (context, index) {
              final messageData = chatMessages[index];
              final message = messageData['message'];
              final isBlue = messageData['isBlue'];
              final isLastMessage = index == chatMessages.length - 1;

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