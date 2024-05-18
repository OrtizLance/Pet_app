import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/components/drawer.dart';
import 'package:pet_app/components/text_field.dart';
import 'package:pet_app/components/wall_post.dart';
import 'package:pet_app/pages/user.dart';
import '../util/story_circles.dart';
import '../util/storypage.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  void _openStory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StoryPage(),
      ),
    );
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add(
        {
          'UserEmail': currentUser.email,
          'Message': textController.text,
          'TimeStamp': Timestamp.now(),
          'Likes': [],
        },
      );
    }

    setState(() {
      textController.clear();
    });
  }

  void goToProfilePage(){

    Navigator.pop(context);

    Navigator.push(context, MaterialPageRoute(builder: (context)=> UserScreen(),),);

  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
  
  




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'S T O R I E S',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.brown,
      ),  
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return StoryCircles(
                    function: _openStory,
                    // open story
                  );
                },
              )),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy("TimeStamp", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.docs[index];
                          return WallPost(
                              message: post['Message'],
                              user: post['UserEmail'],
                              postId: post.id,
                              likes: List<String>.from(post['Likes']) ?? []);
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: textController,
                    hintText: "Write Something",
                    obscureText: false,
                  ),
                ),
                IconButton(
                  onPressed: postMessage,
                  icon: Icon(Icons.arrow_circle_up),
                ),
              ],
            ),
          ),
          Text(
            "logged in as: " + currentUser.email!,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
