import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 2,
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width *
                    0.07, // Responsive font size
                fontFamily: 'Bobbers',
                // color:   Color(0xFFFDB338),
                color: Color(0xFF22BA8E),
                fontWeight: FontWeight.bold,
              ),
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Welcome Back'),
                    TyperAnimatedText('Welcome Back'),
                    TyperAnimatedText('Welcome Back'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
          ),
        ),
        // SizedBox(height: 15),
        // Uncomment the following to add an image
        // Image(
        //   image: AssetImage('assets/sign.png'),
        //   width: 200,
        //   height: 200,
        // ),
      ],
    );
  }
}
