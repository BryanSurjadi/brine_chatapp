import 'package:brine_chatapp/components/curr_user.dart';
import 'package:brine_chatapp/components/user_tile.dart';
import 'package:brine_chatapp/pages/personalChat.dart';
import 'package:brine_chatapp/services/auth/auth_service.dart';
import 'package:brine_chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 254, 254, 254),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 166, 196, 211)!,
              Color.fromARGB(255, 236, 238, 239)!
            ],
          ),
        ),
        child: _userList(),
      ),
    );
  }

  Widget _userList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          // Handle error
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error loading users",
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
            );
          }
          // Show loading indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Check if there is data
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No users found",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }

          // Build user list
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList(),
            ),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // Display all users except current user
    if (userData["email"] != _authService.getCurr()!.email) {
      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: Text(
            userData["email"],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () {
            // Navigate to chat page with the selected user
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalChatPage(
                          receiverEmail: userData["email"],
                          receiverID: userData["uid"],
                        )));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
