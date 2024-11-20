// import 'package:brine_chatapp/auth/auth_service.dart';
// import 'package:brine_chatapp/components/appbar.dart';
import 'package:brine_chatapp/components/curr_user.dart';
import 'package:brine_chatapp/components/user_tile.dart';
// import 'package:brine_chatapp/pages/chats.dart';
import 'package:brine_chatapp/pages/personalChat.dart';
import 'package:brine_chatapp/services/auth/auth_service.dart';
import 'package:brine_chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _userList(),
    );
  }

  Widget _userList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //data
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all user except curr
    if (userData["email"] != _authService.getCurr()!.email) {
      return UserTile(
          text: userData["email"],
          ontap: () {
            //ontap go to chat page with each users
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalChatPage(
                          receiverEmail: userData["email"],
                          receiverID: userData["uid"],
                        )));
          });
    } else {
      return Container();
    }
  }
}
