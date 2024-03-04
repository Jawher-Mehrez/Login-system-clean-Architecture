import 'package:flutter/material.dart';
import 'package:trafic_gesture/features/login/presentation/screens/LoginForm.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key}); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginForm(),
    );
  }
}
