import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pandemonium/components/my_button.dart';
import 'package:pandemonium/components/my_textfield.dart';
import 'package:pandemonium/components/square_tile.dart';
import '../../services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confimPasswordController = TextEditingController();
  


  // sign user up method
  void signUserUp() async {

    //show loading circle
    


    // try creating the user
    try {
      // check if password is confirmed
      if (passwordController.text == confimPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle
      } else {
        //pop the loading circle
        // show error message, passwords don't match
        showErrorMessage('Passwords do not match!');
      }
      // pop the loading circle
    } on FirebaseAuthException catch (e){
      //pop the loading circle
      showErrorMessage(e.code);
    }
  }

  // wrong email message popup
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

  // wrong password message popup
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                Image.asset('lib/images/panda.png', height: 200),

                // Lets create an account for you!
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
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

                // password textfield
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

                // confirm password textfield
                MyTextField(
                  controller: confimPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey[500],
                  ),
                ),



               

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(height: 25),

                // or continue with
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

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png',
                      ),

                    
                  ],
                ),

                const SizedBox(height: 25),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
