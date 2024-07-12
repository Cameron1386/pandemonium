import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pandemonium/pages/dashboard/daily_level.dart';
import 'package:pandemonium/pages/dashboard/easy_level.dart';
import 'package:pandemonium/pages/dashboard/hard_level.dart';
import 'package:pandemonium/pages/profile_page.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // sliver app bar
        SliverAppBar(
          backgroundColor: Colors.deepPurple,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Icon(Icons.person),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
                ),
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailyLevel()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Center(child: Text('Daily Level')),
                  height: 400,
                  color: Colors.deepPurple[300],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EasyLevel()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Center(child: Text('Easy Level')),
                  height: 400,
                  color: Colors.deepPurple[300],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HardLevel()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Center(child: Text('Hard Level')),
                  height: 400,
                  color: Colors.deepPurple[300],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}