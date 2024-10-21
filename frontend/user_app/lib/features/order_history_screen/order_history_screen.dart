import 'package:flutter/material.dart';
import 'package:user_app/features/order_history_screen/components/components_export.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});
  static const routeName = 'orderHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            color: Colors.white,
            child: const Column(
              children: [SizedBox(height: 16.0), DateTimeHistory()],
            )),
      )),
    );
  }
}
