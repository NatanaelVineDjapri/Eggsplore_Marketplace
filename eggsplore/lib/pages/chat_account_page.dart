import 'package:flutter/material.dart';
import 'package:eggsplore/model/message.dart';
import 'package:eggsplore/service/message_service.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/chat/chat_input.dart';
import 'package:eggsplore/constants/images.dart';   // 🔹 background chat
import 'package:eggsplore/constants/text_string.dart'; // 🔹 string error

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
  late Future<Map<String, dynamic>> _chatFuture;
  int? myId;

  @override
  void initState() {
    super.initState();
    _chatFuture = _loadChat();
  }

  Future<Map<String, dynamic>> _loadChat() async {
    final user = await UserService.getCurrentUser();
    myId = user?.id;

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
        messages.insert(0, sent);
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.username),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.chat_bg), // 🔹 background chat
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _chatFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("${AppStrings.failget} ${snapshot.error}"),
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
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.orange.shade200.withOpacity(0.9)
                                : Colors.grey.shade300.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            msg.message,
                            style: TextStyle(
                              color: isMe ? Colors.black : Colors.black87,
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
      ),
    );
  }
}
