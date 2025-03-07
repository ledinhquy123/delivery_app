// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/features/features_export.dart';
import 'package:user_app/features/order_history_screen/components/components_export.dart';
import 'package:user_app/models/models_export.dart';

class DateTimeHistory extends StatefulWidget {
  const DateTimeHistory({
    super.key,
  });

  @override
  State<DateTimeHistory> createState() => _DateTimeHistoryState();
}

class _DateTimeHistoryState extends State<DateTimeHistory> {
  DateTime currentDate = DateTime.now();
  List<OrderModel> orders = [];
  double totalIncome = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        if (state is GetOrdersListSuccess) {
          List<dynamic> response = state.apiResponse.data as List<dynamic>;
          orders = response.map((order) => OrderModel.fromMap(order)).toList();

          totalIncome = 0;
          if (orders.isNotEmpty) {
            for (var order in orders) {
              totalIncome += order.shippingCost;
            }
          }
        }

        return Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 31,
                  itemBuilder: (context, index) {
                    DateTime date =
                        DateTime.now().subtract(Duration(days: 30 - index));
                    String dateE = DateFormat('E').format(date);
                    return GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        int id = prefs.getInt('id')!;
                        setState(() {
                          currentDate = date;
                        });
                        context.read<OrderHistoryBloc>().add(GetOrdersList(
                            date: DateFormat('yyyy-MM-dd').format(currentDate),
                            id: id.toString(),
                            guard: 'user'));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color:
                                DateFormat('dd MMM yyyy').format(currentDate) ==
                                        DateFormat('dd MMM yyyy').format(date)
                                    ? Colors.green.shade500
                                    : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dateE,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              DateFormat('dd/MMM').format(date),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.cartShopping,
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số đơn',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            orders.length.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState!
                        .pushNamed(IncomeStatisticScreen.routeName);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.coins,
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tổng tiền',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              totalIncome.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            orders.isNotEmpty
                ? (state is GetOrdersListPending
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 3 -
                            AppBar().preferredSize.height,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        ),
                      )
                    : OrderHistoryData(orders: orders))
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 3 -
                        AppBar().preferredSize.height,
                    child: const OrderHistoryEmpty())
          ],
        );
      },
    );
  }
}
