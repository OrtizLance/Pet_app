import 'package:flutter/material.dart';


import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  final void Function()? onChat;
  // final void Function()? onCommunity;
  const MyDrawer({super.key, required this.onProfileTap, required this.onSignOut, required this.onChat});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          //header

          const DrawerHeader(
            child: Icon(
              Icons.pets,
              size: 100,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15,),

          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),


          MyListTile(
            icon: Icons.person,
            text: 'P R O F I L E',
            onTap: onProfileTap,
          ),


           MyListTile(
            icon: Icons.chat,
            text: 'C H A T',
            onTap: onChat,
          ),

      

           MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: onSignOut,
          ),

        ],
      ),
    );
  }
}
