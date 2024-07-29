import 'package:flutter/material.dart';
import 'package:hello_world_newest/widget/appbar/bottombar.dart';
import 'package:provider/provider.dart';

import '../model/chat/message.dart';
import '../widget/appbar/appbar.dart';
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

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      Provider.of<Messages>(context, listen: false).addMessage(message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 5, bottom: 29),
          child: Column(
            children: [
              const Expanded(
                child: ChatList(),
              ),
              MessageInputField(
                controller: _messageController,
                onSend: _sendMessage,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}