import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat/message.dart';
import '../widget/appbar/appbar.dart';
import '../widget/appbar/bottombar.dart';
import '../widget/chat/list.dart';
import '../widget/chat/input.dart';
import 'map.dart';

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

  int _currentIndex = 0;

  final List<Widget> _pages = [
    ChatPage(), // ChatPage를 별도로 정의합니다.
    MyMapPage(title: 'map'), // 기존 MyMapPage를 사용합니다.
    // ProfilePage(), // 필요시 추가
  ];

  void _onBottomNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
      print("arguments: " + arguments.toString());
      if (arguments != null && arguments['question'] != null) {
        _sendMessage(arguments['question']);
      }
    });
  }

  void _sendMessage([String? initialMessage]) async {
    final message = initialMessage ?? _messageController.text;

    if (message.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _focusNode.unfocus();
      });

      await Provider.of<Messages>(context, listen: false).addMessage(message, 'room1', 'user1');

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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: MyBottomBar(onTap: _onBottomNavBarTapped),
    );
  }
}

// 별도로 정의한 ChatPage
class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void _sendMessage([String? initialMessage]) async {
    final message = initialMessage ?? _messageController.text;

    if (message.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _focusNode.unfocus();
      });

      await Provider.of<Messages>(context, listen: false).addMessage(message, 'room1', 'user1');

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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                onSend: () => _sendMessage(),
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