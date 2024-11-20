import 'package:brine_chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //create instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send msg
  Future<void> sendMsg(String receiver, msg) async {
    //get curr user
    final String currUser = _auth.currentUser!.uid;
    final String currEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create new msg
    Message newMsg = Message(
        senderID: currUser,
        senderEmail: currEmail,
        receiverID: receiver,
        message: msg,
        timestamp: timestamp);

    //create new chatroom id if blm ada
    List<String> ids = [currUser, receiver];
    ids.sort();
    String roomID = ids.join('_');

    //add new msg to db
    await _firestore
        .collection("chat_rooms")
        .doc(roomID)
        .collection("messages")
        .add(newMsg.toMap());
  }

  //get msg
  Stream<QuerySnapshot> getMsg(String userID, other) {
    //get chat room id
    List<String> ids = [userID, other];
    ids.sort();
    String roomID = ids.join('_');
    //return collection  of the chat room
    return _firestore
        .collection("chat_rooms")
        .doc(roomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  //get last msg
  Future<Message?> getLastMessage(String userID, String other) async {
    List<String> ids = [userID, other];
    ids.sort();
    String roomID = ids.join('_');

    final lastMessageSnapshot = await _firestore
        .collection('chat_rooms')
        .doc(roomID)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (lastMessageSnapshot.docs.isNotEmpty) {
      final lastDoc = lastMessageSnapshot.docs.first;
      return Message.fromMap(lastDoc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  //get users recent chats

  Stream<List<Map<String, dynamic>>> getRecentChats(String userID) {
    return _firestore
        .collection('chat_rooms')
        .snapshots()
        .asyncMap((snapshot) async {
      final recentChats = <Map<String, dynamic>>[];

      for (final doc in snapshot.docs) {
        final roomID = doc.id;
        final List<String> userIds = roomID.split('_');

        if (userIds.contains(userID)) {
          // Get the other user's ID
          final String otherUserId = userIds.firstWhere((id) => id != userID);

          // Fetch the other user's email
          final userSnapshot =
              await _firestore.collection('Users').doc(otherUserId).get();
          final userEmail = userSnapshot.data()?['email'] ?? 'Unknown';

          // Fetch the last message for the current chat room
          final lastMessageSnapshot = await _firestore
              .collection('chat_rooms')
              .doc(roomID)
              .collection('messages')
              .orderBy('timestamp', descending: true)
              .limit(1)
              .get();

          if (lastMessageSnapshot.docs.isNotEmpty) {
            final lastMessageDoc = lastMessageSnapshot.docs.first;
            final messageData = lastMessageDoc.data();

            recentChats.add({
              'roomID': roomID,
              'receiverID': otherUserId,
              'email': userEmail,
              'lastMessage': messageData['message'],
              'timestamp': messageData['timestamp'],
            });
          }
        }
      }

      print("Recent Chats: ${recentChats.length}");
      return recentChats;
    });
  }
}
