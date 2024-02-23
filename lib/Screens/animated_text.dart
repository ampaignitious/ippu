import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedLoadingText extends StatelessWidget {
  final List<String> loadingTexts;

  const AnimatedLoadingText({
    Key? key,
    required this.loadingTexts,
  }) : super(key: key);

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
            },
            text: loadingTexts,
            textStyle: TextStyle(
              fontSize: 25.0,
              color: Colors.blue,
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
