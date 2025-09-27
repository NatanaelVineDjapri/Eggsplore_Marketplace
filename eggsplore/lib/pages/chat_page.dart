import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/widget/chat/chat_item.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const backBar(title: "Chat"),
      body: ListView(
        children: const [
          ChatItem(name: "Frayz94", date: "Yesterday"),
          ChatItem(name: "de(mon)vin", date: "19 Apr"),
          ChatItem(name: "dihyo", date: "17 Apr"),
        ],
      ),
    );
  }
}
