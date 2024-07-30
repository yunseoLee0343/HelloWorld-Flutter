import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Messages extends ChangeNotifier {
  final List<String> _messages = [
    'Hello, how can I help you?',
    'I need help with my visa application',
    'Sure, I can help you with that',
  ];

  List<String> get messages => _messages;

  Future<List<String>> addMessage(String message) async {
    _messages.add(message);
    notifyListeners();

    await sendMessageToServer(message);
    print('Message added: $message');
    return _messages;
  }

  Future<void> sendMessageToServer(String message) async {
    const url = 'https://your-server-endpoint.com/api/messages';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
