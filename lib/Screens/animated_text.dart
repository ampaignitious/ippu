import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedLoadingText extends StatelessWidget {
  const AnimatedLoadingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250.0,
          child: TypewriterAnimatedTextKit(
            isRepeatingAnimation: true,
            speed: Duration(milliseconds: 200),
            onTap: () {
              print("Typewriter Animated Text Kit onTap");
            },
            text: [
              "Fetching account types...",
              "Please wait...",
            ],
            textStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20.0),
        CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
