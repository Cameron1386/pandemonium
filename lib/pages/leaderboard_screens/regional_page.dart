import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegionalPage extends StatefulWidget {
  const RegionalPage({Key? key}) : super(key: key);

  @override
  _RegionalPageState createState() => _RegionalPageState();
}

class _RegionalPageState extends State<RegionalPage> {
  Map<String, String?> _usernames = {}; // Store usernames

  Future<void> _fetchUsernames(List<String> userIds) async {
    try {
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          for (var userId in userIds) {
            _usernames[userId] ??= 'Anonymous';
          }
        });
      });

      List<DocumentSnapshot> userDocs = await Future.wait(
        userIds.map((userId) => FirebaseFirestore.instance.collection('users').doc(userId).get()),
      );

      setState(() {
        for (var i = 0; i < userDocs.length; i++) {
          final userData = userDocs[i].data() as Map<String, dynamic>?;
          _usernames[userIds[i]] = userData?['username'] ?? 'Anonymous';
        }
      });
    } catch (e) {
      print('Error fetching usernames: $e');
    }
  }

  Widget _buildTop3(List<QueryDocumentSnapshot> users) {
    final top3Users = users.take(3).toList();
    final List<Color> crownColors = [Colors.amber, Colors.grey, Colors.brown];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: top3Users.asMap().entries.map((entry) {
        final index = entry.key;
        final user = entry.value;
        final score = (user['score'] as num?)?.toInt() ?? 0;
        final userId = user.id;
        final username = _usernames[userId] ?? 'Loading...';

        return Column(
          children: [
            Icon(
              index == 0 ? Icons.emoji_events : Icons.star_border,
              color: crownColors[index],
              size: 50,
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text(
                username[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            SizedBox(height: 8),
            Text(
              username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              score.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildLeaderboardList(List<QueryDocumentSnapshot> users) {
    final otherUsers = users.skip(3).toList();
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: otherUsers.length,
      itemBuilder: (context, index) {
        final user = otherUsers[index];
        final userId = user.id;
        final score = (user['score'] as num?)?.toInt() ?? 0;
        final isCurrentUser = userId == currentUserId;
        final username = _usernames[userId] ?? 'Loading...';

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              (index + 4).toString(), // +4 since we skipped 3 users
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            username,
            style: TextStyle(
              fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: Text(
            score.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          tileColor: isCurrentUser ? Colors.blue.withOpacity(0.1) : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('score', descending: true)
            .limit(100)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final userDocs = snapshot.data!.docs;
          final userIds = userDocs.map((doc) => doc.id).toList();

          if (_usernames.isEmpty) {
            _fetchUsernames(userIds);
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              SizedBox(height: 20),
              _buildTop3(userDocs), // Top 3 users displayed differently
              Divider(),
              Expanded(child: _buildLeaderboardList(userDocs)), // Rest of the users
            ],
          );
        },
      ),
    );
  }
}
