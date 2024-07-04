import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/auth/firebase_auth_service.dart';
import 'package:chat_app/utils/app_router.dart';
import 'package:chat_app/view_model/auth_view_model.dart';
import 'package:chat_app/view_model/user_view_model.dart';
import 'package:chat_app/views/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/views/screens/home_screen/widgets/chat_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserViewModel _userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF517DA2),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Telegram',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                AuthController().logoutUser();
                // Handle navigation to home
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Handle navigation to profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle navigation to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _userViewModel.getUsers(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading'));
          } else if (!snapshot.hasData || snapshot.hasError) {
            return Center(child: Text('error: snapshot ${snapshot.error}'));
          } else {
            final List<QueryDocumentSnapshot<Object?>> users =
                snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final CurrentUser user = CurrentUser.fromQuerySnapshot(
                  users[index],
                );
                final data = [
                  FirebaseAuth.instance.currentUser!.email,
                  user.email
                ]..sort();
                return Column(
                  children: [
                    ChatListTile(user: user),
                    SizedBox(
                      height: 10,
                      child: Divider(
                        thickness: 0.3,
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
