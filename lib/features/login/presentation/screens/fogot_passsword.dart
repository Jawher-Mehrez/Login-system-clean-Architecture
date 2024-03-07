import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/UserProfilePage');
        },
        child: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot password?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              // color: Color(0xFFFDB338),
              color: Color(0xFF22BA8E),
            ),
          ),
        ),
      ),
    );
  }
}
