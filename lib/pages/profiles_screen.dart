import 'package:flutter/material.dart';
import '../util/story_circles.dart';
import '../util/storypage.dart';



class ProfileScreen extends StatefulWidget {

  

  
  
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  
  void _openStory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StoryPage(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('S T O R I E S'),
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
              ))
        ],
      ),
    );
  }
}
