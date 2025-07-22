import 'package:flutter/material.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
            'Welcome to',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF161616),
              fontSize: 32,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              height: 1.25,
              letterSpacing: -0.64,
            ),
          ),
        ],
      ),
    );
  }
}
