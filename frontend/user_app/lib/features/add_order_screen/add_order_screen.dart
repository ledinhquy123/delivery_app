import 'package:flutter/material.dart';
import 'package:user_app/constants/app_const.dart';
import 'package:user_app/features/add_order_screen/components/components_export.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});
  static const routeName = 'addOrderScreen';

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  void initState() {
    super.initState();
    Vietmap.getInstance(MAP_KEY);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tạo đơn hàng',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(12.0),
                child: const AddOrderBody()),
          ),
        ));
  }
}
