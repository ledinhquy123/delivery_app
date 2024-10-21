import 'package:flutter/material.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/features/income_statistic_screen/blocs/income_statistic_bloc.dart';
import 'package:user_app/features/notifications_screen/blocs/user_notification_bloc.dart';
import 'package:user_app/features/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(DeliveryApp(appRouter: AppRouter()));
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => DriverOptionBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => OrderHistoryBloc()),
        BlocProvider(create: (context) => ParticipationBloc()),
        BlocProvider(create: (context) => UserNotificationBloc()),
        BlocProvider(create: (context) => IncomeStatisticBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
