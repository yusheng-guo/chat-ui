import 'package:flutter/material.dart';
import 'package:talk/theme.dart';
import 'package:talk/ui/pages/onboarding/onboarding.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talk',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: const Onboarding(),
    );
  }
}
