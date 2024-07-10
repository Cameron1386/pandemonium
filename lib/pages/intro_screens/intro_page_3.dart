import 'package:flutter/material.dart';
import 'package:pandemonium/pages/login_pages/auth_page.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
          children: [
            const Text(
              "Its time to suit up!",
              style: TextStyle(fontSize: 20),
              ),
        
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
              child: const Text('Start Your Journey!'),
            ),
            Lottie.asset('lib/animations/micduppanda.json'),
          ],
        ),
      ),
    );
  }
}