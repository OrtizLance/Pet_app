import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_app/signin_screen.dart';
import 'package:pet_app/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:pet_app/pages/center.dart';
import 'package:pet_app/services/auth/auth_gate.dart';
import 'package:pet_app/services/auth/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MyApp(), // Wrap MyApp with ChangeNotifierProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthGate(), // Use AuthGate as the initial screen
      routes: {
        '/signin': (context) => SignInScreen(onTap: () {}), // Route for SignInScreen
        '/signup': (context) => SignUpScreen(onTap: () {}), // Route for SignUpScreen
        '/home': (context) => HomeScreen(), // Route for HomeScreen
      },
    );
  }
}
