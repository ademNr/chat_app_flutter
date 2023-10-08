import 'package:chat_app_flutter/models/message_model.dart';
import 'package:flutter/foundation.dart';


class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.add(message);
    print(_messages.length);
    print(message.room);
    notifyListeners();
  }
}