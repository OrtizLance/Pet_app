import 'package:flutter/material.dart';

class StoryCircles extends StatelessWidget {

  final function;
  
  
   StoryCircles({this.function});




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container( 
          height: 80,
          width: 80,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        ),
      ),
    );
  }
}
