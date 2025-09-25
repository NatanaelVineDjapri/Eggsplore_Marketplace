import 'package:flutter/material.dart';
import 'package:eggsplore/widget/chat/chat_input.dart';

class ChatDetailPage extends StatefulWidget {
  final String username;

  const ChatDetailPage({super.key, required this.username});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_controller.text.trim());
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.username),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, 
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(message),
                  ),
                );
              },
            ),
          ),
          ChatInput(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
