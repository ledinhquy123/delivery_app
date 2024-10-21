import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_app/features/features_export.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = 'authScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [LoginScreen(), RegisterScreen()],
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const SwapEffect(
                  activeDotColor: Colors.green,
                  dotColor: Colors.grey,
                  dotWidth: 14,
                  dotHeight: 14,
                  type: SwapType.yRotation),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
