import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app/pages/center.dart';
import 'signin_or_signup.dart'; // Import your SigninOrSignup widget

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking authentication state
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // User is signed in, navigate to HomeScreen
          return HomeScreen();
        } else {
          // User is not signed in, navigate to sign-in or sign-up screen
          return SigninOrSignup();
        }
      },
    );
  }
}
