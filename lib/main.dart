import 'package:flutter/material.dart';
import 'package:talk/theme.dart';
import 'package:talk/ui/composition_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
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
      // home: const Onboarding(),
      home: CompositionRoot.composeOnboardingUI(),
    );
  }
}
