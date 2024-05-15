import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyProgressBar extends StatelessWidget {
  final double percentWatched;

  MyProgressBar({required this.percentWatched});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: LinearPercentIndicator(
        lineHeight: 15.0,
        percent: percentWatched,
        progressColor: Colors.blue, // Customize as needed
        backgroundColor: Colors.grey[300], // Customize as needed
        barRadius: Radius.circular(8.0), // Adds rounded corners
    
      ),
    );
  }
}
