import 'package:chat_app_flutter/providers/chat_provider.dart';
import 'package:chat_app_flutter/screens/chat_room_screen.dart';
import 'package:chat_app_flutter/socket_service/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final List<String> messages = [];
  final ScrollController _scrollController = ScrollController();
  final SocketService socketService = SocketService();

  @override
  void initState() {
    super.initState();
    socketService.initSocket(context);
  }

  void _joinRoom() {
    final roomName = roomNameController.text;
    final userName = userNameController.text;

    if (roomName.isNotEmpty && userName.isNotEmpty) {
      socketService.joinRoom( roomName , userName );
                                          Provider.of<ChatProvider>(context, listen: false).messages.clear(); 
       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(username: '${userName}', roomname: '${roomName}')),
                );

    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            backgroundColor:const Color.fromARGB(255, 20, 23, 31), 
            title: Text('Missing Information', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w900),),
            content: Text('Please enter both room name and your name.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, ),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK',style: TextStyle(color: Colors.blueAccent)),
              ),
            ],
          );
        },
      );
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 23, 31),
    
      body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Stack(
          children:[ 
            Align(
        alignment: Alignment.bottomRight,
        child: Opacity(
          opacity: 0.5, 
          child: Image.asset("assets/asset1.png", scale: 1.5,))),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const        SizedBox(height: 60,),
                const      Text(
          'Join a chat room or add one ! ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w800,
          ),
          ),
          SizedBox(height: 60,),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
          'Room name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          ),
          SizedBox(height: 5,),
              TextFormField(
                      controller: roomNameController,
                     
                
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                       
                        hintStyle: TextStyle(
                          color: Color(0xffF7F9F9).withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                    
                        fillColor: Color(0xFF1A2836),
                       
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
              ],
             ),
                    SizedBox(height: 50,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
          Text(
          'Your name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          ),
          SizedBox(height: 5,),    TextFormField(
                      controller: userNameController,
                       
                  
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                       
                        hintStyle: TextStyle(
                          color: Color(0xffF7F9F9).withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                    
                       
                       
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
            
                  ],
                ),
                SizedBox(height: 60,),
              GestureDetector(
                onTap: (){_joinRoom();},
                child: Container(
                          height: 50,
                          width: 700,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20) ),
                          child: TextButton(
                
                onPressed:(){
                     _joinRoom();
                        },
                child:  
                 Text(
                        'join room',
                        style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        fontSize: 18,
                        color: Colors.white,
                        ),
                ),
                style: TextButton.styleFrom(
                        
                        backgroundColor:  Colors.blue,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                        ),
                ),
                          ),
                        ),
              ),
              SizedBox(height: 20),
           
             
            ],
          ),
          ]
        ),
      ),
      )
    );
  }
}