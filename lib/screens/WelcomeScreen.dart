import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'InitialSetUpAreaSelectionScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home_work, size: 200, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                'Welcome to HomeCare!',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.pink),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Keep track of important tasks around your home.',
                style: TextStyle(fontSize: 17, color: Colors.pinkAccent),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => InitialSetupAreaSelectionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Get Started', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
