import 'package:flutter/material.dart';
import 'package:pet_app/util/progress_bar.dart';

class MyStoryBars extends StatelessWidget {

  List<double> percentWatched = [];

  MyStoryBars({required this.percentWatched});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
        child: Row(
          children: [
            Expanded(
              child: MyProgressBar(percentWatched: percentWatched[0]),
            ),
            Expanded(
              child: MyProgressBar(percentWatched: percentWatched[1]),
            ),
            Expanded(
              child: MyProgressBar(percentWatched: percentWatched[2]),
            ),
          ],
        ),
      ),
    );
  }
}
