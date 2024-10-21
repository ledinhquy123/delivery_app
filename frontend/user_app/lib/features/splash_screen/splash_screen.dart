import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/features/features_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NotificationSetup _noti = NotificationSetup();
  final ConnectToPusher pusher = ConnectToPusher();

  @override
  void initState() {
    super.initState();

    _noti.configurePushNotifications(context);
    _noti.eventListenerCallback(context);
    pusher.connecToPusher();
  }

  

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/lotties/Animation - 1718709960582.json')
        ],
      ),
      splashIconSize: MediaQuery.of(context).size.height,
      backgroundColor: Colors.green.shade100,
      nextScreen: const AuthScreen(),
    );
  }
}
