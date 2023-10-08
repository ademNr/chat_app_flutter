import 'package:chat_app_flutter/models/message_model.dart';
import 'package:chat_app_flutter/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  final String serverUrl = 'http://10.0.2.2:3000'; // Replace with your server URL

  io.Socket? socket;

  SocketService._internal();

  void initSocket(BuildContext context) {
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket?.onConnect((_) {
      print('Connected to server');
    });

    socket?.onDisconnect((_) {
      print('Disconnected from server');
    });

   socket!.on('message', (data) {
  final senderName = data['senderName'];
  final message = data['message'];
  final room = data['room'];
  final sentAt = data['sentAt'];
         Provider.of<ChatProvider>(context, listen: false).addNewMessage(
          Message(message: message, senderName:senderName, sentAt: sentAt, room:room)
    );
  // Handle the received message data here, e.g., update your UI or state
  print('Received message in room $room from $senderName: $message at $sentAt');
  
  // You can use this data to update your UI or state as needed.
  // For example, if you're using a Flutter StatefulWidget, you can call setState to update the UI.
  // setState(() {
  //   // Update your UI or state variables here
  // });
});
  }

  void joinRoom(String roomName, String joinerName) {
    socket?.emit('join_room', {'room' : roomName, 'joinerName': joinerName} );
  }

  void sendMessage(String roomName, String message, String senderName) {
    socket?.emit('send_message', {'room': roomName, 'message': message, 'senderName': senderName , 'sentAt': DateTime.now().toString()});
  }
}