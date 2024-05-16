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

    // Debugging: Print the user information
    if (user != null) {
      print('User photoURL: ${user.photoURL}');
      print('User displayName: ${user.displayName}');
      print('User email: ${user.email}');
    } else {
      print('User is not logged in.');
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 140,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              user?.photoURL ?? 'https://example.com/placeholder.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Image.network(
                                  'https://example.com/placeholder.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 12),
              child: Text(
                user != null ? user.displayName ?? 'Unknown' : 'User not logged in.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Text(
              user != null ? user.email ?? '' : '',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 18,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 32),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.work_outline,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                        Text(
                          'Passenger Documents',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                          Text(
                            'Tracker Notifications',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.help_outline_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                        Text(
                          'Help Center',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, -1),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'Settings',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.work_outline,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              title: Text('Phone Number'),
                              trailing: Text(
                                'Add Number',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.language_rounded,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              title: Text('Language'),
                              trailing: Text(
                                'English (eng)',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.money_rounded,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              title: Text('Currency'),
                              trailing: Text(
                                'US Dollar (\$)',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              title: Text('Profile Settings'),
                              trailing: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.notifications_active,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              title: Text('Notification Settings'),
                              trailing: Icon(
                                Icons.chevron_right_rounded,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.login_rounded,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              title: Text('Log out of account'),
                              trailing: TextButton(
                                onPressed: () {
                                  authService.signOut();
                                },
                                child: Text(
                                  'Log Out?',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

