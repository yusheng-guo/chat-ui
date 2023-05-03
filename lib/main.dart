import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talk/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talk/ui/screens/home/home.dart';

// 字体
// const SmileySans = TextStyle(
//   fontFamily: 'SmileySans',
//   fontSize: 16,
//   fontWeight: FontWeight.normal,
//   color: Colors.black,
// );

// Future<void> loadMyFont() async {
//   final fontdata = rootBundle.load('fonts/SmileySans-Oblique.ttf');
//   final fontLoader = FontLoader('SmileySans');
//   fontLoader.addFont(fontdata);
//   await fontLoader.load();
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // loadMyFont(); // 加载字体
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Talk',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      // home: const OnBoarding(),
      home: const HomePage(),
      // home: Expanded(child: ChatViewWidget()),
    );
  }
}
