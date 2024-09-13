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

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> addMessage(Message message) async {
    _messages.add(message);
    _messages.add(Message(text: '...', isSentByMe: false)); // Placeholder for loading state
    notifyListeners();

    // Prepare the request data
    final requestData = {
      "plugid": ["plugin-1712327325", "plugin-1713962163"],
      "query": message.text
    };

    try {
      _isLoading = true;

      // Make a POST request to the server
      final response = await _dio.post(
        'https://api-demo-bice.vercel.app/api/home',
        data: requestData,
      );

      // Check if the response is successful and contains data
      if (response.statusCode == 200 && response.data != null) {
        var data = jsonDecode(response.data);
        String serverResponse = data['data']['answer'].toString(); // Modify based on actual response structure

        // Remove the loading message and add the server response
        print(serverResponse);
        _messages.removeLast();
        _messages.add(Message(text: serverResponse, isSentByMe: false));
      } else {
        // Remove the loading message and add an error message
        _messages.removeLast();
        _messages.add(Message(text: 'Failed to get response from server', isSentByMe: false));
      }
    } catch (e) {
      // Remove the loading message and add an error message
      _messages.removeLast();
      _messages.add(Message(text: 'Error: ${e.toString()}', isSentByMe: false));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
