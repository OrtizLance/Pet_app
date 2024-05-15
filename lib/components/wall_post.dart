import 'package:flutter/material.dart';
import 'package:pet_app/components/like_button.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
         Column(children: [

          LikeButton(isLiked: true, onTap: (){})
         ],),

          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(user), const SizedBox(height: 10), Text(message)],
          ),
        ],
      ),
    );
  }
}
