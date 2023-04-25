import 'package:flutter/material.dart';
import 'package:talk/theme.dart';
import 'package:talk/ui/pages/login/login.dart';
import 'package:talk/ui/pages/onboarding/onboarding.dart';

import 'ui/pages/profile/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talk',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      // home: const OnBoarding(),
      home: const Login(),
    );
  }
}
