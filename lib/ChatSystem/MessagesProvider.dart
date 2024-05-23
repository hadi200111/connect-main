import 'package:flutter/foundation.dart';

class MessageProvider with ChangeNotifier {
  List<String> _messages = [];

  List<String> get messages => _messages;

  void addMessage(String message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}