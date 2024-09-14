import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Groups {
  final String name;
  final int chats;

  Groups({
    required this.name,
    required this.chats,
  });
}

// class Chat {
//   final String userMessage;
//   final String botMessage;

//   Chat({required this.userMessage, required this.botMessage});

//   // Factory method to create Chat instance from JSON
//   factory Chat.fromJson(Map<String, dynamic> json) {
//     return Chat(
//       userMessage: json['user']?['msg'] ?? 'No user message',
//       botMessage: json['bot']?['msg'] ?? 'No bot message',
//     );
//   }
// }

class HomeProvider with ChangeNotifier {
  final List<Groups> _groups = [];

  List<Groups> get groups => _groups;

  void addGroup(Groups group) {
    _groups.add(group);
    notifyListeners();
  }

  void removeLast() {
    _groups.removeLast();
    notifyListeners();
  }

  void clearGroup() {
    _groups.clear();
    notifyListeners();
  }

  final List<String> _chatHistory = []; // Store only user messages

  List<String> get chatHistory => _chatHistory;

  // Add chat history (user messages only)
  void addChatHistory(List<String> chatHistory) {
    _chatHistory.clear();
    _chatHistory.addAll(chatHistory);
    notifyListeners();
  }

  void clearChatHistory() {
    _chatHistory.clear();
    notifyListeners();
  }
}

class ChatService {
  final Dio _dio = Dio();

  Future<List<String>> fetchChatHistory(String chatId) async {
    const String url = 'https://api-demo-bice.vercel.app/api/history';

    try {
      Response response = await _dio.post(url, data: {"chatid": chatId});

      if (response.statusCode == 200) {
        print(response.data);
        Map<String, dynamic> parsedJson = jsonDecode(response.data);
        List<dynamic> data = parsedJson.values.toList();
        return data
            .map((chatJson) => chatJson['user']['msg'] as String)
            .toList();
      } else {
        throw Exception('Failed to load chat history');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching chat history');
    }
  }
}
