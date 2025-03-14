import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/common/pages/bottomnav/user_bottom_navigation_bar.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/welcome_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return StreamBuilder<UserModel>(
              stream: getUserData(snapshot
                  .data!.uid), // Replace with your method to fetch user data
              builder: (context, AsyncSnapshot<UserModel> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SafeArea(
                      child: Center(
                        child: FadeIn(
                          duration: const Duration(seconds: 2),
                          child: Image.asset(
                            'assets/logo/techHavenLogo.png',
                            scale: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (userSnapshot.hasError) {
                  return const WelcomePage();
                } else if (!userSnapshot.hasData) {
                  return const WelcomePage(); // Handle case where user data is not available
                } else {
                  UserModel user = userSnapshot.data!;
                  if (user.userAllowed) {
                    return const UserBottomNavigationBar(); // Render your main content if user is allowed
                  } else {
                    // Handle case where user is not allowed
                    return Scaffold(
                      backgroundColor: Colors.red[50],
                      body: Center(
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          color: Colors.red[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.block,
                                  color: Colors.red,
                                  size: 50.0,
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  'Access Denied',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800],
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'You are blocked by the Admin and not allowed to access this app.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SafeArea(
              child: Center(
                child: FadeIn(
                  duration: const Duration(
                    seconds: 2,
                  ),
                  child: Image.asset(
                    'assets/logo/techHavenLogo.png',
                    scale: 15,
                  ),
                ),
              ),
            ),
          );
        }
        return const WelcomePage();
      },
    ));
  }
}

// Function to fetch user data from Firestore
Stream<UserModel> getUserData(String uid) {
  // Reference to the Firestore collection where user data is stored
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Return a stream of UserModel based on the document with UID
  return users.doc(uid).snapshots().map((snapshot) {
    // Convert Firestore document snapshot to a UserModel object
    return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
  });
}
