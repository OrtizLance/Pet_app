import 'package:flutter/material.dart';
import 'package:pet_app/pages/chat.dart';
import 'package:pet_app/pages/home.dart';
import 'package:pet_app/pages/info.dart';
import 'package:pet_app/pages/user.dart';
import 'package:pet_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ChatScreen(),
    PetsHomeScreen(),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _signOut(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.grey[900], // Set background color to grey
        selectedItemColor: Colors.indigo[300],
        unselectedItemColor: Colors.grey, // Grey color for unselected items
        selectedFontSize: 14,
        unselectedFontSize: 12,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey[900], // Match background color
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Colors.grey[900], // Match background color
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Trivia',
            backgroundColor: Colors.grey[900], // Match background color
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
            backgroundColor: Colors.grey[900], // Match background color
          ),
        ],
      ),
    );
  }
}
