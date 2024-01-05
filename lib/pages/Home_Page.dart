// home_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage({Key? key, required this.user}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    // After signing out, redirect the user to the login screen
    Navigator.pushReplacementNamed(context, '/chooseOption');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Fitness Challenge'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Daily Fitness Challenge!',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('Hello, ${user.email}',
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

