import 'package:flutter/material.dart';
import 'package:talk/colors.dart';

class OnBoardingBackground extends StatelessWidget {
  final String heading;
  final String image;

  const OnBoardingBackground({
    super.key,
    required this.heading,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 60.0),
            Image.asset(image),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
