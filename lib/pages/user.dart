import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    AuthService authService = Provider.of<AuthService>(context);

    return Scaffold(
   
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: authService.getProfileImage(),
            ),
            SizedBox(height: 10),
            Text(
              user != null ? user.displayName ?? 'Unknown' : 'User not logged in.',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              user != null ? user.email ?? '' : '',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20), // Space between user info and sign-out button
            ElevatedButton(
              onPressed: () {
                authService.signOut();
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
