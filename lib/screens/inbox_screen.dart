import 'package:flutter/material.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final List<ChatItem> chats = [
    ChatItem(
      name: "Akash.Desai",
      message: "Complete your work by tomorrow.",
      time: "12:30 PM",
      image: NetworkImage("https://randomuser.me/api/portraits/men/1.jpg"),
    ),
    ChatItem(
      name: "RRU",
      message: "Comeback trainee",
      time: "11:15 AM",
      image: AssetImage("assets/Logo copy.png"),
    ),
    // Add more ChatItem instances here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Image(image: AssetImage('assets/Logo copy.png')),
        ),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: chat.image,
            ),
            title: Text(chat.name),
            subtitle: Text(chat.message),
            trailing: Text(chat.time),
            onTap: () {
              // Navigate to chat details screen
            },
          );
        },
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final ImageProvider? image;


  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.image

  });
}


