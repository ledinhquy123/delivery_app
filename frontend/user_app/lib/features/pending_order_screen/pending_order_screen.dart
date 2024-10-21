import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/features/features_export.dart';
import 'package:user_app/features/pending_order_screen/components/components_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:user_app/services/services_export.dart';

class PendingOrderScreen extends StatefulWidget {
  const PendingOrderScreen({super.key});
  static const routeName = 'pendingOrderScreen';

  @override
  State<PendingOrderScreen> createState() => _PendingOrderScreenState();
}

class _PendingOrderScreenState extends State<PendingOrderScreen> {
  OrderModel? order;

  @override
  void initState() {
    super.initState();
    prepareOrder();
  }

  Future<void> prepareOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('order') != null) {
      OrderModel local =
          OrderModel.fromMap(jsonDecode(prefs.getString('order')!));
      ApiResponse apiResponse = await OrderService.getSingleOrder(
          local.id.toString(), prefs.getString('token')!);
      setState(() {
        order = OrderModel.fromMap(apiResponse.data);
      });
      if (order!.orderStatus.id == 5 ||
          order!.orderStatus.id == 6 ||
          order!.orderStatus.id == 7) {
        prefs.remove('order');
        setState(() {
          order = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: prepareOrder,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  order == null
                      ? const PedingOrderEmpty()
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(4.0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    offset: Offset(2.0, 2.0))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd/MMM/yyyy hh:mm').format(
                                        DateTime.parse(order!.createdAt)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ParticipationBloc>().add(
                                          GetMessageList(
                                              orderId: order!.id.toString()));
                                      navigatorKey.currentState!.push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ParticipationScreen(
                                                    order: order!,
                                                  )));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green.shade700,
                                      child: const Icon(
                                        Icons.messenger,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                width: MediaQuery.of(context).size.width - 24,
                                height: 1,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Khoảng cách:',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                      '${order!.distance.toStringAsFixed(2)} km')
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.dollarSign,
                                  ),
                                  Text(
                                      '${order!.shippingCost.toStringAsFixed(2)} vnđ')
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                width: MediaQuery.of(context).size.width - 24,
                                height: 1,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order!.orderStatus.id == 5
                                        ? 'Hoàn thành'
                                        : 'Chưa hoàn thành',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: order!.orderStatus.id == 5
                                                ? Colors.green
                                                : Colors.red),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      navigatorKey.currentState!.push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrackingDriverScreen(
                                                      order: order!)));
                                    },
                                    child: const Icon(
                                      Icons.arrow_right_sharp,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
