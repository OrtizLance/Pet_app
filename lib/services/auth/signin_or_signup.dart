import 'package:flutter/material.dart';
import 'package:pet_app/signin_screen.dart';
import 'package:pet_app/signup_screen.dart';

class SigninOrSignup extends StatefulWidget {
  const SigninOrSignup({super.key});

  @override
  State<SigninOrSignup> createState() => _SigninOrSignupState();
}

class _SigninOrSignupState extends State<SigninOrSignup> {

  bool showSigninPage = true;

  void togglePages(){
    setState(() {
      showSigninPage = !showSigninPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSigninPage){
      return SignInScreen(onTap: togglePages);
    } else{
      return SignUpScreen(onTap: togglePages);
    }
    
  }
}