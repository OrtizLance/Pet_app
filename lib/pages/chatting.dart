import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_app/components/chat_bubble.dart';
import 'package:pet_app/components/text_field.dart';
import 'package:pet_app/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        
        children: [
          SizedBox(
  height: 1.0, // Adjust the height to the desired value
  child: Center(
    child: Container(
      height: 1.0,
      color: Colors.grey[300], // Adjust the color as needed
    ),
  ),
),

          // messages
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
   
          _buildMessageInput(),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading ...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            ChatBubble(message: data['message'],),
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
   
    return Column(
      children: [
        SizedBox(
  width: 2000, // Adjust the height to the desired value
  child: Center(
    child: Container(
      
      height: 1,
      color: Colors.grey[300], // Adjust the color as needed
    ),
  ),
),
        Padding(
          
          
          padding: const EdgeInsets.symmetric(horizontal: 25),
          
          child: Column(
            children: [
              
        const SizedBox(height: 8),
              Row(
                
                children: [
                  
                  
                  
                  
                  Expanded(
                    child: MyTextField(
                      controller: _messageController,
                      hintText: "Enter Message",
                      obscureText: false,
                      icon: Icons.message,
                    ),
                  ),
              
                    const SizedBox(width: 15),
                  
                    IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send,
                        size: 25, 
                        color: Colors.blue,
                      ),
                    ),
                
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
