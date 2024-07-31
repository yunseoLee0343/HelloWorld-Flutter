// lib/utils/navigation_utils.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat/message.dart';
import '../screen/home.dart';
import '../screen/map.dart';
import '../screen/profile.dart';
import '../widget/chat/input.dart';
import '../widget/chat/list.dart';

int currentIndex = 0;

final List<Widget> pages = [
  const MyHomePage(question: ''),
  const MyMapPage(title: 'map'),
  const MyProfilePage(title: 'profile'),
];

void onBottomNavBarTapped(BuildContext context, int index) {
  currentIndex = index;
}

class NavigationHandler extends StatelessWidget {
  const NavigationHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: pages,
    );
  }
}

class ChatWidget extends StatefulWidget {
  final String userId;
  final String roomId;

  const ChatWidget({
    Key? key,
    required this.userId,
    required this.roomId,
  }) : super(key: key);

  @override
  ChatWidgetState createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void sendMessage([String? initialMessage]) async {
    final message = initialMessage ?? _messageController.text;

    if (message.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _focusNode.unfocus();
      });

      await Provider.of<Messages>(context, listen: false)
          .addMessage(message, widget.userId, widget.roomId);

      setState(() {
        _isLoading = false;
        _messageController.clear();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 80),
              children: [
                ChatList(userId: widget.userId, roomId: widget.roomId),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MessageInputField(
                controller: _messageController,
                onSend: () => sendMessage(),
                focusNode: _focusNode,
                isSendEnabled: !_isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
