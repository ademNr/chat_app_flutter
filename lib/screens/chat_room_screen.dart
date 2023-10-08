import 'dart:io';


import 'package:chat_app_flutter/models/message_model.dart';
import 'package:chat_app_flutter/providers/chat_provider.dart';
import 'package:chat_app_flutter/socket_service/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String roomname ; 
  const HomeScreen({Key? key, required this.username, required this.roomname}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _messageInputController = TextEditingController();

  
  final SocketService socketService = SocketService();
  
              void _sendMessage() async{
                          if (widget.roomname.isNotEmpty && widget.username.isNotEmpty) {
                            String message =_messageInputController.text;
                            socketService.sendMessage(widget.roomname, message, widget.username);
                            print(message);
                                              Provider.of<ChatProvider>(context, listen: false).addNewMessage(
                                   Message(message: _messageInputController.text, senderName: widget.username, sentAt: DateTime.now().toString(), room: widget.roomname)
    );
                            _messageInputController.clear();
                    
                          }
                        }
  @override
  void initState() {

    socketService.initSocket(context);
  
    super.initState();


  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 23, 31)  ,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){},),
        backgroundColor: const Color.fromARGB(255, 20, 23, 31),
        title:  Text('${widget.roomname}', style:  TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (_, provider, __) => provider.messages.length==0 ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset("assets/asset1.png", scale: 2.5,)),
                  SizedBox(height: 20,),
                   Text("empty space, no messages yet", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize:20),)],):  ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = provider.messages[index];
                
             // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(message.sentAt);

  // Format the DateTime to display only time in "hh:mm a" format
  String formattedTime = DateFormat('hh:mm a').format(dateTime);
                  return  Column(
                    crossAxisAlignment: message.senderName == widget.username ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
                    children:[  
                   message.senderName == widget.username ?   Padding(
                     padding: const EdgeInsets.only(right: 8),
                     child: Text("you",  style: TextStyle(color: Colors.white) ),
                   ) :     Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: Text(message.senderName,  style: TextStyle(color: Colors.white) ),
                   ),
                       Wrap(
                      alignment: message.senderName == widget.username
                          ? WrapAlignment.end
                          : WrapAlignment.start,
                      children: [
                        Card(
                          color: message.senderName == widget.username
                              ? Colors.blue
                              :  Color(0xFF262A35),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                                  message.senderName == widget.username
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(message.message, style: TextStyle(color: Colors.white, fontSize: 15),),
                                Text(
                                formattedTime,
                                  style: TextStyle(color: Colors.white, fontSize: 12 ),
                                  
                                  
                                ),
                              ],
                            ),
                          ),
                        ), 
                        
                      ],
                    ),
                   
                    ]
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: provider.messages.length,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.grey),
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        
                        hintStyle: TextStyle(
                          color:  Colors.grey, 
                    
                      ),

                      )
                    ),
                  ),
                  IconButton(
                    onPressed: () async{
                      if (_messageInputController.text.isNotEmpty) {
                      _sendMessage(); 
               
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}