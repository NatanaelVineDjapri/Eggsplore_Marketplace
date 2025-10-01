import 'package:eggsplore/pages/chat_account_page.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/service/message_service.dart';
import 'package:eggsplore/model/message.dart'; // UserChat ada di sini

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isLoading = true;
  List<UserChat> contacts = []; // ⬅️ langsung pakai UserChat

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      final response = await MessageService.getInbox(); // ini List<UserChat>
      setState(() {
        contacts = response; 
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        contacts = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : contacts.isEmpty
              ? const Center(
                  child: Text(
                    "💬 Belum ada chat.\nMulai percakapan dengan mencari user!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              :ListView.builder(
  itemCount: contacts.length,
  itemBuilder: (context, index) {
    final user = contacts[index]; // udah UserChat object
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange,
        child: Text(
          user.name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              userId: user.id,       // pakai id lawan chat
              username: user.name,   // buat judul appbar
            ),
          ),
        );
      },
    );
  },
)

    );
  }
}
