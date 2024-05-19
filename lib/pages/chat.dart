import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/pages/chatting.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'P E T  H A V E N',
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
      backgroundColor: Colors.grey[400], // Set your desired background color here
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to start a new chat
        },
        child: const Icon(Icons.message),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error loading users', style: GoogleFonts.montserrat()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentUserEmail = _auth.currentUser!.email;

        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) {
            Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
            if (data['email'] != currentUserEmail) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: data['photoURL'] != null ? NetworkImage(data['photoURL']) : null,
                        child: data['photoURL'] == null ? const Icon(Icons.person, color: Colors.white, size: 15) : null,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                      title: Text(
                        data['email'],
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receiverUserEmail: data['email'],
                              receiverUserID: data['uid'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }).toList(),
        );
      },
    );
  }
}
