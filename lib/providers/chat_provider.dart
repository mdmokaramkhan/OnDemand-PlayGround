import 'package:flutter/foundation.dart';

class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
    _messages.add(Message(text: 'Response From Server', isSentByMe: false));
  }
}
