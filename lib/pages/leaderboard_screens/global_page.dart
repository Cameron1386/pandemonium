import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlobalPage extends StatelessWidget {
  const GlobalPage({Key? key}) : super(key: key);

  Future<String?> _getUserEmail(String userId) async {
    try {
      final userRecord = await FirebaseAuth.instance.userChanges().firstWhere(
            (user) => user?.uid == userId,
            orElse: () => null,
          );
      return userRecord?.email;
    } catch (e) {
      print('Error fetching user email: $e');
      return null;
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final user = snapshot.data!.docs[index];
              final userId = user.id;
              final score = (user['score'] as num?)?.toInt() ?? 0;
              final isCurrentUser = userId == currentUserId;

              return FutureBuilder<String?>(
                future: _getUserEmail(userId),
                builder: (context, emailSnapshot) {
                  final email = emailSnapshot.data ?? 'Loading...';
                  
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
          );
        },
      ),
    );
  }
}