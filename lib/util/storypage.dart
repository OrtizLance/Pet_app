import 'dart:async';
import 'package:flutter/material.dart';
import '../stories/story_1.dart';
import '../stories/story_2.dart';
import '../stories/story_3.dart';
import '../stories/story_bars.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;
  late Timer _timer;

  final List<Widget> myStories = [
    MyStory1(),
    MyStory2(),
    MyStory3(),
  ];

  List<double> percentWatched = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < myStories.length; i++) {
      percentWatched.add(0);
    }

    _startWatching();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startWatching() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        
        if(percentWatched[currentStoryIndex] + 0.01 <1){
          percentWatched[currentStoryIndex] += 0.1;
        }

        else {
          percentWatched[currentStoryIndex] = 1;
          timer.cancel();


          if(currentStoryIndex< myStories.length-1){
            currentStoryIndex++;

            _startWatching();
          }


        else{
          Navigator.pop(context);
        }
        }






      });
      
    });
  }

  void _nextStory() {
    if (currentStoryIndex < myStories.length - 1) {
      setState(() {
        currentStoryIndex++;
      });
      _startWatching(); // Start watching the next story
    } else {
      // All stories have been watched
      print('All stories completed');
    }
  }

  void _onTapDown(TapDownDetails details){
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    
    if(dx < screenWidth / 2){
        setState(() {
          if(currentStoryIndex>0){
            percentWatched[currentStoryIndex-1] = 0;
            percentWatched[currentStoryIndex] = 0;


            currentStoryIndex--;
          }
        });
    }

      else {
        setState(() {
          
          if(currentStoryIndex < myStories.length -1){


            percentWatched[currentStoryIndex] =1;
            currentStoryIndex++;
          }

          else{
            percentWatched[currentStoryIndex] = 1;
          }



        });
      }


  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details)=> _onTapDown(details),
      child: Scaffold(
        body: Stack(
          children: [
            myStories[currentStoryIndex],
            MyStoryBars(
              percentWatched: percentWatched,
            ),
          ],
        ),
      ),
    );
  }
}
