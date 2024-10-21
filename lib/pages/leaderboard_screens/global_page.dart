import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlobalPage extends StatefulWidget {
  const GlobalPage({Key? key}) : super(key: key);

  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  Map<String, String?> _userEmails = {};

  Future<void> _fetchUserEmails(List<String> userIds) async {
    try {
      // Start a timer to set to "Anonymous" after 5 seconds if still loading
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          for (var userId in userIds) {
            _userEmails[userId] ??= 'Anonymous'; // Assign "Anonymous" if still not fetched
          }
        });
      });

      // Fetch user emails in batch
      List<User?> users = await Future.wait(
        userIds.map((userId) => FirebaseAuth.instance.userChanges().firstWhere(
              (user) => user?.uid == userId,
              orElse: () => null,
            )),
      );

      // Update the state if emails were fetched successfully
      setState(() {
        for (var i = 0; i < users.length; i++) {
          _userEmails[userIds[i]] = users[i]?.email ?? 'Anonymous';
        }
      });
    } catch (e) {
      print('Error fetching user emails: $e');
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

          // If we haven't fetched emails yet, trigger it
          if (_userEmails.isEmpty) {
            _fetchUserEmails(userIds);
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView.builder(
            itemCount: userDocs.length,
            itemBuilder: (context, index) {
              final user = userDocs[index];
              final userId = user.id;
              final score = (user['score'] as num?)?.toInt() ?? 0;
              final isCurrentUser = userId == currentUserId;

              // Get the email from preloaded map or show "Loading..." if not yet fetched
              final email = _userEmails[userId] ?? 'Loading...';

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
                    email,
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
