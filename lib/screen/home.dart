import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat/message.dart';
import '../widget/appbar/appbar.dart';
import '../widget/appbar/bottombar.dart';
import '../widget/chat/list.dart';
import '../widget/chat/input.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void _sendMessage() async {
    final message = _messageController.text;

    if (message.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _focusNode.unfocus();
      });

      await Provider.of<Messages>(context, listen: false).addMessage(message, '123', '456');

      setState(() {
        _isLoading = false;
        _messageController.clear();
      });

      // Smooth scroll to the bottom after adding a message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300), // Adjust the duration as needed
      curve: Curves.easeOut, // Smooth scrolling
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Hide the keyboard
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              ListView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 80),
                children: const [
                  ChatList(userId: 'user1', roomId: 'room1'),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MessageInputField(
                  controller: _messageController,
                  onSend: _sendMessage,
                  focusNode: _focusNode,
                  isSendEnabled: !_isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}