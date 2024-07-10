import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // sliver app bar
        SliverAppBar(
          backgroundColor: Colors.deepPurple,
          leading: Icon(Icons.person),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/panda.png'),
                  fit: BoxFit.contain,
                ),
                color: Colors.pink,
              ),
            ),
            centerTitle: true,
            title: const Text("Pandemonium!"),
          ),
        ),

        // sliver items
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                color: Colors.deepPurple[300],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                color: Colors.deepPurple[300],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                color: Colors.deepPurple[300],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
