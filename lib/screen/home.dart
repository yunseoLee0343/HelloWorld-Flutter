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
  bool _isLoading = false;

  void _sendMessage() async {
    final message = _messageController.text;

    if (message.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _focusNode.unfocus();
      });

      await Provider.of<Messages>(context, listen: false).addMessage(message);

      setState(() {
        _isLoading = false;
        _messageController.clear();
      });
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
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: 80),
                children: const [
                  ChatList(),
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
