import 'package:flutter/material.dart';
import 'package:talk/ui/screens/login/login.dart';
import 'package:talk/ui/screens/signup/signup.dart';
import 'package:talk/ui/widgets/onboarding/onboarding_background.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: controller,
              children: const [
                OnBoardingBackground(
                  heading: "Earn for every Referal",
                  image: "assets/images/1.png",
                ),
                OnBoardingBackground(
                  heading: "Send Money Fast",
                  image: 'assets/images/2.png',
                ),
                OnBoardingBackground(
                  heading: 'Over 50 Countries',
                  image: 'assets/images/3.png',
                ),
                OnBoardingBackground(
                  heading: 'Over 50 Countries',
                  image: 'assets/images/4.png',
                ),
              ],
            ),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: 4,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        fixedSize: const Size(250.0, 40.0),
                      ),
                      child: const Text(
                        "Log In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        fixedSize: const Size(250.0, 40.0),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
