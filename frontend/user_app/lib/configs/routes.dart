import 'package:flutter/material.dart';
import 'package:user_app/features/features_export.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (context) => const AuthScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case OtpVerifyScreen.routeName:
        return MaterialPageRoute(builder: (context) => const OtpVerifyScreen());
      case PendingOrderScreen.routeName:
        return MaterialPageRoute(builder: (context) => const PendingOrderScreen());
      case OrderHistoryScreen.routeName:
        return MaterialPageRoute(builder: (context) => const OrderHistoryScreen());
      case AddOrderScreen.routeName:
        return MaterialPageRoute(builder: (context) => const AddOrderScreen());
      case DriverOptionScreen.routeName:
        return MaterialPageRoute(builder: (context) => const DriverOptionScreen());
      case NotificationScreen.routeName:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());
      case IncomeStatisticScreen.routeName:
        return MaterialPageRoute(builder: (context) => const IncomeStatisticScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      default:
        return null;
    }
  }
}