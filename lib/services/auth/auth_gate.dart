import 'package:brine_chatapp/services/auth/login_or_regis.dart';
import 'package:brine_chatapp/components/navbar.dart';
// import 'package:brine_chatapp/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const NavBar();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
