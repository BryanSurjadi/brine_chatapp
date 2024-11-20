import 'package:brine_chatapp/components/bri_textfield.dart';
import 'package:brine_chatapp/components/chat_bubble.dart';
import 'package:brine_chatapp/services/auth/auth_service.dart';
import 'package:brine_chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  PersonalChatPage(
      {super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMsg(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Theme.of(context).colorScheme.primary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: 1.0,
          ),
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 22.0,
            fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          //display messges
          Expanded(child: _buildMessageList()),
          //textbox  & send msg
          _userInput()
        ],
      ),
    );
  }

  //widget buildmessagelist

  Widget _buildMessageList() {
    String senderID = _authService.getCurr()!.uid;
    return StreamBuilder(
        stream: _chatService.getMsg(senderID, receiverID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //listview
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //widget buildmessageitem
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //check user
    bool isCurrentUser = data["senderID"] == _authService.getCurr()!.uid;

    //align
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [ChatBubble(message: data["message"], isMe: isCurrentUser)],
      ),
    );
  }

  Widget _userInput() {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle),
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Expanded(
              child: BriTextField(
            controller: _messageController,
            hintText: "Enter a message",
            obscureText: false,
          )),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.shade500),
            margin: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: sendMessage,
              color: Colors.white,
              icon: const Icon(FontAwesomeIcons.arrowRight),
            ),
          )
        ],
      ),
    );
  }
}
