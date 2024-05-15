import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService extends ChangeNotifier {

  // instance ka auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance ka firestore
  final FirebaseFirestore _fireStrore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(


      String email, String password) async {



    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);


            // user collection
        _fireStrore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
       }, SetOptions(merge: true));



          // ga salo error 
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


ImageProvider getProfileImage() {
  User? user = FirebaseAuth.instance.currentUser;
  
  if (user != null) {
    // Check if the user is signed in with Google
    if (user.providerData.any((info) => info.providerId == 'google.com')) {
      // User is signed in with Google, return Google profile image
      return NetworkImage(user.photoURL!);
    } else {
      // User is signed in with email/password, return default profile image
      return const AssetImage('assets/default_profile.png');
    }
  } else {
    // User is not signed in, return default profile image
    return  const AssetImage('assets/default_profile.png');
  }
}








            // NEW USER
  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);


       // user collection
       _fireStrore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
       });


      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
