import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/components/button.dart';
import 'package:pet_app/components/text_field.dart';
import 'package:pet_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  final void Function()? onTap;
  const SignInScreen({Key? key, required this.onTap});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '541896515032-ahq95e4ecb8dbq8n659a4pbevgo5e7q6.apps.googleusercontent.com',
  );

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: GoogleFonts.montserrat(),
          ),
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google sign in aborted';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // User signed in successfully
      } else {
        // Failed to sign in
        throw 'Failed to sign in with Google';
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error signing in with Google: $e',
            style: GoogleFonts.montserrat(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo[300], // Set the background color to brown
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                
                  Lottie.network(
                    'https://lottie.host/807a4823-3d13-4823-ae87-5c2e374b28c1/VnlXCaSy7c.json',
                    height: 400,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'PET HAVEN',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: MyTextField(
                        controller: emailController,
                        hintText: ' Email',
                        obscureText: false,
                        icon: Icons.email,
                        borderRadius: 10.0, // Adjust the radius here
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: MyTextField(
                        controller: passwordController,
                        hintText: ' Password',
                        obscureText: true,
                        icon: Icons.password,
                        borderRadius: 10.0, // Adjust the radius here
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: MyButton(onTap: signIn, text: 'Sign in'),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Or',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 100, right: 100),
                    child: GestureDetector(
                      onTap: signInWithGoogle,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google_logo.png',
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Sign in with Google',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member yet?',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Sign up Here',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
