import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Messages extends ChangeNotifier {
  final List<Map<String, dynamic>> _messages = [
    {'message': 'Hello, how can I help you?', 'isBlue': false},
    {'message': 'I need help with my visa application', 'isBlue': true},
    {'message': 'Sure, I can help you with that', 'isBlue': false},
  ];

  List<Map<String, dynamic>> get messages => _messages;

  Future<void> addMessage(String message) async {
    _messages.add({'message': message, 'isBlue': true});
    notifyListeners();

    final serverResponse = await sendMessageToServer(message);

    if (serverResponse != null) {
      _messages.add({'message': serverResponse, 'isBlue': false});
      notifyListeners();
    }

    print('Message added: $message');
  }

  Future<String?> sendMessageToServer(String message) async {
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
        final responseData = jsonDecode(response.body);
        return responseData['response'] as String?;
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error sending message: $e');
      return null;
    }
  }
}