import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlobalPage extends StatefulWidget {
  const GlobalPage({Key? key}) : super(key: key);

  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  Map<String, String?> _usernames = {}; // Store usernames

  Future<void> _fetchUsernames(List<String> userIds) async {
    try {
      // Start a timer to set to "Anonymous" after 5 seconds if still loading
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          for (var userId in userIds) {
            _usernames[userId] ??= 'Anonymous'; // Assign "Anonymous" if still not fetched
          }
        });
      });

      // Fetch usernames in batch from Firestore collection
      List<DocumentSnapshot> userDocs = await Future.wait(
        userIds.map((userId) => FirebaseFirestore.instance.collection('users').doc(userId).get()),
      );

      // Update the state with the fetched usernames
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('score', descending: true)
            .limit(100) // Limit to top 100 users for performance
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final currentUserId = FirebaseAuth.instance.currentUser?.uid;
          final userDocs = snapshot.data!.docs;

          // Extract all userIds from the fetched documents
          final userIds = userDocs.map((doc) => doc.id).toList();

          // If we haven't fetched usernames yet, trigger it
          if (_usernames.isEmpty) {
            _fetchUsernames(userIds);
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: userDocs.length,
            itemBuilder: (context, index) {
              final user = userDocs[index];
              final userId = user.id;
              final score = (user['score'] as num?)?.toInt() ?? 0;
              final isCurrentUser = userId == currentUserId;

              // Get the username from preloaded map or show "Loading..." if not yet fetched
              final username = _usernames[userId] ?? 'Loading...';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      (index + 1).toString(),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
