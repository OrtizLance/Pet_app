import 'package:flutter/material.dart';
import 'package:pet_app/pages/chat.dart';
import 'package:pet_app/pages/home1.dart';
import 'package:pet_app/pages/user.dart';
import 'package:pet_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';
import 'community.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  

  int myIndex = 0;

  List<Widget> widgetList = const [
    HomePage(),
    CommunityPage(),
    ChatScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void signOut() {
      final authService = Provider.of<AuthService>(context, listen: false);
      authService.signOut();
    }

    return Scaffold(
      body: Center(
        child: widgetList[myIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
