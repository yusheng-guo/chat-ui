import 'package:flutter/material.dart';
import 'package:talk/theme.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLightTheme(context)
          ? Image.asset(
              'assets/logo-light.png',
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            )
          : Image.asset(
              'assets/logo-dark.png',
              width: 64,
              height: 64,
              fit: BoxFit.fill,
            ),
    );
  }
}
