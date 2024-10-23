// auth_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pandemonium/pages/main_screens/home_content.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Debug prints
          print('Auth State Connection State: ${snapshot.connectionState}');
          print('Has Error: ${snapshot.hasError}');
          print('Has Data (Authenticated): ${snapshot.hasData}');
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Authentication Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            print('User is authenticated, loading HomeContent...');
            try {
              return HomeContent();
            } catch (error, stackTrace) {
              print('Error loading HomeContent: $error');
              print('Stack trace: $stackTrace');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Error loading home page'),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              );
            }
          } else {
            // If no user is authenticated, show login/register page
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
