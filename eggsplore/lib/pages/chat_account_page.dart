import 'package:eggsplore/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/model/message.dart';
import 'package:eggsplore/service/message_service.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/chat/chat_input.dart';

class ChatDetailPage extends StatefulWidget {
  final int userId;
  final String username;

  const ChatDetailPage({
    super.key,
    required this.userId,
    required this.username,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  late Future<Map<String, dynamic>> _chatFuture; // untuk FutureBuilder
  int? myId;

  @override
  void initState() {
    super.initState();
    _chatFuture = _loadChat();
  }

  Future<Map<String, dynamic>> _loadChat() async {
    // ambil user login
    final user = await UserService.getCurrentUser();
    myId = user?.id;

    // ambil messages lawan chat
    final msgs = await MessageService.getMessages(widget.userId);

    return {
      "myId": myId,
      "messages": msgs,
    };
  }

  Future<void> _sendMessage(List<Message> messages) async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final sent = await MessageService.sendMessage(widget.userId, text);
    if (sent != null) {
      setState(() {
        messages.insert(0, sent); // masuk ke list
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(widget.username),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _chatFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color:AppColors.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Gagal ambil chat: ${snapshot.error}"),
            );
          }

          final myId = snapshot.data!["myId"] as int?;
          final messages = snapshot.data!["messages"] as List<Message>;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == myId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.primary.shade200 : AppColors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          msg.message,
                          style: TextStyle(
                            color: isMe ? AppColors.bleki: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ChatInput(
                controller: _controller,
                onSend: () => _sendMessage(messages),
              ),
            ],
          );
        },
      ),
    );
  }
}
