import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pandemonium/components/my_button.dart';
import 'package:pandemonium/components/my_textfield.dart';
import 'package:pandemonium/components/square_tile.dart';
import 'package:pandemonium/pages/main_screens/home_content.dart';
import '../../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // sign user in method
  void signUserIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage('User not found. Please register.');
      } else if (e.code == 'wrong-password') {
        showErrorMessage('Incorrect password. Try again.');
      } else if (e.code == 'network-request-failed') {
        showErrorMessage('Network error. Check your connection.');
      } else {
        showErrorMessage('Error: ${e.code}. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // show error message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Authentication Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            // User is signed in, load the HomeContent
            return HomeContent();
          } else {
            // Show login form if user is not authenticated
            return SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Image.asset('lib/images/panda.png', height: 200),
                      const SizedBox(height: 25),
                      Text(
                        'Welcome back, you\'ve been missed!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      isLoading
                          ? CircularProgressIndicator()
                          : MyButton(
                              text: 'Sign In',
                              onTap: signUserIn,
                            ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTile(
                            onTap: () => AuthService().signInWithGoogle(),
                            imagePath: 'lib/images/google.png',
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Register now',
                              style: TextStyle(
                                color: Colors.blue,
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
            );
          }
        },
      ),
    );
  }
}
