import 'package:flutter/material.dart';

import 'package:trafic_gesture/features/sign_up/presentation/screens/create_acc_screen.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key}); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateAccountScreen(),
      
    );
  }
}
