import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final FocusNode focusNode;
  final bool isSendEnabled;

  const MessageInputField({
    required this.controller,
    required this.onSend,
    required this.focusNode,
    this.isSendEnabled = false,
  });

  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final _textFieldKey = GlobalKey();
  double _textFieldHeight = 56.0;

  get isSendEnabled => widget.isSendEnabled;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateHeight);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateHeight);
    super.dispose();
  }

  void _updateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textFieldRenderBox = _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
      if (textFieldRenderBox != null) {
        setState(() {
          _textFieldHeight = textFieldRenderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: _textFieldHeight,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            offset: Offset(5, 4),
            blurRadius: 20,
          ),
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              key: _textFieldKey,
              controller: widget.controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                hintText: 'Send any message to chatbot',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(51, 105, 255, 1),
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: const TextStyle(
                color: Color.fromRGBO(51, 105, 255, 1),
                fontFamily: 'Nunito',
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
              maxLines: null,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.send, size: 24),
                onPressed: isSendEnabled ? widget.onSend : null,
                color: const Color.fromRGBO(51, 105, 255, 1),
              ),
              IconButton(
                icon: const Icon(Icons.mic, size: 24),
                onPressed: () {},
                color: const Color.fromRGBO(84, 84, 84, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}