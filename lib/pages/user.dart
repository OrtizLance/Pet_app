import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/components/text_box.dart';
import 'package:provider/provider.dart';
import 'package:pet_app/services/auth/auth_services.dart';


class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    AuthService authService = Provider.of<AuthService>(context);
    final usersCollection = FirebaseFirestore.instance.collection("Users");

    Future<void> editField(String field) async {
      String newValue = "";
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Edit $field",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(newValue),
            ),
          ],
        ),
      );

      if (newValue.trim().isNotEmpty) {
        await usersCollection.doc(user?.email).update({field: newValue});
      }
    }

    String getUsername(User? user, Map<String, dynamic>? userData) {
      if (user != null) {
        if (user.providerData.any((info) => info.providerId == 'google.com')) {
          // User signed in with Google
          return user.displayName ?? 'No username available';
        } else {
          // User signed in with email/password
          return userData?['username'] ??
              user.email?.split('@')[0] ??
              'No username available';
        }
      }
      return 'No username available';
    }


   



    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
      ),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    child: CircleAvatar(
                      radius: 43,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : AssetImage('assets/default_profile.png')
                              as ImageProvider,
                      onBackgroundImageError: (_, __) {
                        setState(() {
                          user = null;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 0, 0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: usersCollection.doc(user?.email).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data?.data() == null) {
                    return Text(
                      getUsername(user, null),
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }

                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    getUsername(user, userData),
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 0, 16),
              child: Text(
                user?.email ?? 'andrew@domainname.com',
                style: GoogleFonts.montserrat(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 0, 0),
              child: Text(
                'Your Account',
                style: GoogleFonts.montserrat(),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: usersCollection.doc(user?.email).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return Center(
                    child: Text('No user data found.'),
                  );
                }

                final userData = snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    MyTextBox(
                      sectionName: getUsername(user, userData),
                      text: 'Username',
                      icon: Icons.person,
                      onPressed: () => editField('username'),
                    ),
                    MyTextBox(
                      sectionName: userData['bio'] ?? 'No bio available',
                      text: 'Bio',
                      icon: Icons.person,
                      onPressed: () => editField('bio'),
                    ),
                  ],
                );
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: OutlinedButton(
                  onPressed: () {
                    authService.signOut();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ),
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.montserrat(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
