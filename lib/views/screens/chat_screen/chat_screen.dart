import 'package:chat_app/models/message.dart';
import 'package:chat_app/utils/custom_functions.dart';
import 'package:chat_app/view_model/chat_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String email;

  const ChatScreen({super.key, required this.email});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final String _currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
  final ChatViewModel _chatViewModel = ChatViewModel();
  late final String _chatRoomId;

  @override
  void initState() {
    super.initState();
    _chatRoomId = CustomFunctions.generateChatRoomId(
      user1Email: widget.email,
      user2Email: _currentUserEmail,
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _chatViewModel.sendMessage(
        text: _messageController.text,
        senderId: _currentUserEmail,
        timeStamp: FieldValue.serverTimestamp(),
        chatRoomId: _chatRoomId,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with ${widget.email}')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _chatViewModel.getMessages(_chatRoomId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      Message message =
                          Message.fromQuerySnapshot(messages[index]);

                      return Row(
                        mainAxisAlignment: _currentUserEmail == message.senderId
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(message.text),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
