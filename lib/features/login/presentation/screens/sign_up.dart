import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const Text(
          "Connect With: ",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Handle Facebook avatar click
              },
              child: CircleAvatar(
                  // backgroundImage: AssetImage('assets/facebook.png'),
                  ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                // Handle Google+ avatar click
              },
              child: CircleAvatar(
                  // backgroundImage: AssetImage('assets/google+.png'),
                  ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Align children to the start and end of the row
            children: [
              Flexible(
                child: Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF22BA8E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
