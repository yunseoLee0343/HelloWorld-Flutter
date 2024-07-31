import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Messages extends ChangeNotifier {
  final Map<String, List<Map<String, dynamic>>> _messagesByRoomAndUser = {
    // room1에서 user1의 메시지
    'room1-user1': [
      {'message': 'Hello, how are you?', 'isBlue': false},
      {'message': 'I am doing well, thank you!', 'isBlue': true},
      {'message': 'What can I help you with today?', 'isBlue': false},
    ],

    // room1에서 user2의 메시지
    'room1-user2': [
      {'message': 'Good morning!', 'isBlue': false},
      {'message': 'Good morning! How can I assist you?', 'isBlue': true},
      {'message': 'I need information on the new policy.', 'isBlue': false},
    ],

    // room2에서 user1의 메시지
    'room2-user1': [
      {'message': 'Hi there, welcome to room2!', 'isBlue': false},
      {'message': 'Thank you! What’s the agenda for today?', 'isBlue': true},
    ],

    // room2에서 user3의 메시지
    'room2-user3': [
      {'message': 'Hello, everyone!', 'isBlue': false},
      {'message': 'Hello! Glad to see you here.', 'isBlue': true},
      {'message': 'Can we start the discussion now?', 'isBlue': false},
    ],

    // room3에서 user1의 메시지
    'room3-user1': [
      {'message': 'Hey! Ready for our meeting?', 'isBlue': false},
      {'message': 'Yes, I am ready.', 'isBlue': true},
      {'message': 'Great! Let’s begin.', 'isBlue': false},
    ],

    // room3에서 user2의 메시지
    'room3-user2': [
      {'message': 'Hello everyone!', 'isBlue': false},
      {'message': 'Hello! We are just about to start.', 'isBlue': true},
      {'message': 'Awesome, I’m excited!', 'isBlue': false},
    ],
  };

  List<Map<String, dynamic>> getMessages(String userId, String roomId) {
    final key = _getRoomUserKey(roomId, userId);
    return _messagesByRoomAndUser[key] ?? [];
  }

  Future<void> addMessage(String message, String roomId, String userId) async {
    final key = _getRoomUserKey(roomId, userId);

    // 사용자 메시지를 리스트에 추가하고 변경 사항 알리기
    _messagesByRoomAndUser.putIfAbsent(key, () => []);
    _messagesByRoomAndUser[key]!.add({'message': message, 'isBlue': true});
    notifyListeners();

    try {
      // 서버로 메시지 전송 및 응답 스트리밍
      final serverResponse = await sendMessageToServer(message, roomId, userId);

      if (serverResponse != null) {
        // 서버 응답을 리스트에 추가하고 변경 사항 알리기
        _messagesByRoomAndUser[key]!.add({'message': serverResponse, 'isBlue': false});
        notifyListeners();
      } else {
        print('서버 응답이 없습니다.');
      }
    } catch (e) {
      print('메시지 추가 오류: $e');
    }

    print('Message added: $message');
  }

  Future<String?> sendMessageToServer(String message, String roomId, String userId) async {
    final url = Uri.parse('http://localhost:8082/chat/ask?roomId=$roomId');

    // 헤더 설정
    Map<String, String> headers = {
      'accept': 'text/event-stream',
      'user_id': userId,
      'Content-Type': 'application/json',
    };

    // 본문 설정
    String body = jsonEncode({'message': message});

    try {
      final request = http.Request('POST', url)
        ..headers.addAll(headers)
        ..body = body;

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        print('Message sent successfully');
        return await _processResponseStream(streamedResponse.stream);
      } else {
        print('Failed to send message. Status code: ${streamedResponse.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error sending message: $e');
      return null;
    }
  }

  Future<String?> _processResponseStream(Stream<List<int>> stream) async {
    final responseCompleter = Completer<String>();
    final stringBuffer = StringBuffer();

    stream.transform(utf8.decoder).listen(
          (String data) {
        // 한 글자씩 반환되는 문자열 처리
        stringBuffer.write(data);
        print('Received data: $data');

        // 대화 종료와 roomId 반환을 체크
        if (data.contains("Room Id:")) {
          final roomId = data.split('Room Id:').last.trim();
          print('Conversation ended. Room ID: $roomId');
          responseCompleter.complete(roomId);
        }
      },
      onDone: () {
        if (!responseCompleter.isCompleted) {
          responseCompleter.complete(stringBuffer.toString());
        }
      },
      onError: (e) {
        print('Error processing response stream: $e');
        if (!responseCompleter.isCompleted) {
          responseCompleter.completeError(e);
        }
      },
      cancelOnError: true,
    );

    return responseCompleter.future;
  }

  String _getRoomUserKey(String roomId, String userId) {
    return '$roomId-$userId';
  }
}