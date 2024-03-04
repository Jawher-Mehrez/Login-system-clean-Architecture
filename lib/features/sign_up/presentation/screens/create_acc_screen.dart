import 'package:flutter/material.dart';
import 'package:trafic_gesture/features/sign_up/presentation/screens/header_login.dart';
import 'package:trafic_gesture/features/sign_up/presentation/screens/input_field.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(),
                SizedBox(height: 5), // Add some space between widgets if needed
                InputFieldWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
