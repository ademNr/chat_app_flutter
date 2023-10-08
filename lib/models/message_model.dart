class Message {
  final String message;
  final String senderName;
  final String sentAt;
  final String room ; 
  Message({
    required this.message,
    required this.senderName,
    required this.sentAt,
    required this.room
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      message: message['message'],
      senderName: message['senderName'],
      sentAt: message['sentAt'],
      room : message['room']
    );
  }
}