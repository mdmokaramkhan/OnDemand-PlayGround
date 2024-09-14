import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  final Dio _dio = Dio();
  bool _isLoading = false;
  List<String> _suggestions = [];

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
  List<String> get suggestions => _suggestions;

  Future<void> addMessage(Message message, List<String>? agentIds) async {
    _messages.add(message);
    _messages.add(Message(text: '...', isSentByMe: false));
    notifyListeners();

    // Prepare the request data
    final requestData = {
      "plugid": agentIds,
      "query": message.text
    };

    try {
      _isLoading = true;

      final response = await _dio.post(
        'https://api-demo-bice.vercel.app/api/home',
        data: requestData,
      );

      if (response.statusCode == 200 && response.data != null) {
        var data = jsonDecode(response.data);
        String serverResponse = data['data']['answer'].toString();
        _suggestions = List<String>.from(data['suggestion'] ?? []);

        _messages.removeLast();
        _messages.add(Message(text: serverResponse, isSentByMe: false));
      } else {
        _messages.removeLast();
        _messages.add(Message(text: 'Failed to get response from server', isSentByMe: false));
      }
    } catch (e) {
      _messages.removeLast();
      _messages.add(Message(text: 'Error: ${e.toString()}', isSentByMe: false));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _messages.clear();
    _suggestions.clear();
    notifyListeners();
  }
}
