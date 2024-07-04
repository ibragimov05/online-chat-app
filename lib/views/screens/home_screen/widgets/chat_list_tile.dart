import 'dart:math';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/views/screens/chat_screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final CurrentUser user;

  const ChatListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ChatScreen(email: user.email),
        ),
      ),
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: _generateRandomColor(), radius: 28),
            Text(user.email),
          ],
        ),
      ),
    );
  }

  Color _generateRandomColor() {
    final Random r = Random();
    return Color.fromARGB(
      255,
      r.nextInt(256),
      r.nextInt(256),
      r.nextInt(256),
    );
  }
}
