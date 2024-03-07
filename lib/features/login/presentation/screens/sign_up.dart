import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          "Connect With: ",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle Facebook avatar click
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.1,
                  // backgroundImage: AssetImage('assets/facebook.png'),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              GestureDetector(
                onTap: () {
                  // Handle Google+ avatar click
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.1,
                  // backgroundImage: AssetImage('assets/google+.png'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
