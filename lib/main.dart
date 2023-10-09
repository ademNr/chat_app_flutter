import 'package:chat_app_flutter/providers/chat_provider.dart';
import 'package:chat_app_flutter/screens/choose_room_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(), // Create your HomeProvider here
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat room',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, 
      ),
      home: ChatRoom()
    );
  }
}
