import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pandemonium/pages/dashboard/daily_level.dart';
import 'package:pandemonium/pages/dashboard/easy_level.dart';
import 'package:pandemonium/pages/dashboard/hard_level.dart';
import 'package:pandemonium/pages/profile_page.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.deepPurple,
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Pandemonium!", style: TextStyle(color: Colors.white)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'lib/images/panda.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.deepPurple.withOpacity(0.7)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildLevelCard(
                  context,
                  'Daily Level',
                  Icons.calendar_today,
                  Colors.blue,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyLevel())),
                ),
                const SizedBox(height: 20),
                _buildLevelCard(
                  context,
                  'Easy Level',
                  Icons.star,
                  Colors.green,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EasyLevel())),
                ),
                const SizedBox(height: 20),
                _buildLevelCard(
                  context,
                  'Hard Level',
                  Icons.whatshot,
                  Colors.red,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HardLevel())),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}