import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;
  int leaderboardPosition = 0; // User's leaderboard position

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data on page load
    _fetchLeaderboardStanding(); // Fetch leaderboard standing
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        userData = doc.data() as Map<String, dynamic>?;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _fetchLeaderboardStanding() async {
    try {
      QuerySnapshot leaderboardSnapshot = await _firestore
          .collection('users')
          .orderBy('score', descending: true)
          .get();

      final userRank = leaderboardSnapshot.docs.indexWhere((doc) => doc.id == user.uid);
      setState(() {
        leaderboardPosition = userRank + 1; // Rank starts from 1
      });
    } catch (e) {
      print('Error fetching leaderboard position: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner while fetching data
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileHeader(context),
                    const SizedBox(height: 30),
                    _buildProfileDetail("Username", userData!['username'], Icons.person),
                    const SizedBox(height: 20),
                    _buildProfileDetail("Email", user.email ?? 'No email', Icons.email),
                    const SizedBox(height: 20),
                    _buildProfileDetail("Score", userData!['score'].toString(), Icons.star),
                    const SizedBox(height: 20),
                    _buildProfileDetail("Total Streaks", userData!['totalStreaks'].toString(), Icons.whatshot),
                    const SizedBox(height: 20),
                    _buildProfileDetail("Leaderboard Position", leaderboardPosition.toString(), Icons.leaderboard),
                    const SizedBox(height: 40),
                    _buildSignOutButton(context),
                  ],
                ),
              ),
            ),
    );
  }

  // Profile header with avatar
  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.person, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Text(
          userData!['username'] ?? 'User', // Fallback if no username is found
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          user.email ?? 'No email',
          style: const TextStyle(fontSize: 18, color: Colors.white70),
        ),
      ],
    );
  }

  // Profile detail section with icons and enhanced aesthetics
  Widget _buildProfileDetail(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.teal.withOpacity(0.8),
            Colors.greenAccent.withOpacity(0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Custom styled Sign Out button
  Widget _buildSignOutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => FirebaseAuth.instance.signOut(), // Sign out button
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
      icon: const Icon(Icons.exit_to_app, color: Colors.white),
      label: const Text(
        "Sign Out",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
