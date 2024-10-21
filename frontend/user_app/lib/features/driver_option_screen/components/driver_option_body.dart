// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class DriverOptionBody extends StatefulWidget {
  const DriverOptionBody({super.key, required this.drivers});

  final List<Map<String, dynamic>> drivers;

  @override
  State<DriverOptionBody> createState() => _DriverOptionBodyState();
}

class _DriverOptionBodyState extends State<DriverOptionBody> {
  late List<Map<String, dynamic>> drivers;

  @override
  void initState() {
    drivers = widget.drivers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          DriverModel driver = drivers[index]['driver'];
          double distance = drivers[index]['distance'];
          return GestureDetector(
            onTap: () {
              selectDriver(distance, context, driver);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
                  ]),
              child: Row(
                children: [
                  ClipRRect(
                    // borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: CircleAvatar(
                      radius: 30,
                      child: Image.asset('assets/images/logo.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Đánh giá:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey, fontSize: 16),
                          ),
                          Text(
                            driver.reviewRate!.toStringAsFixed(2),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Khoảng cách:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey, fontSize: 16),
                          ),
                          Text(
                            '${distance.toStringAsFixed(2)} km',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void selectDriver(
      double distance, BuildContext context, DriverModel driver) async {
    {
      double totalDistance = 0;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('id')!;
      String items = prefs.getString('items')!;
      String fromAddress = prefs.getString('fromAddress')!;
      String toAddress = prefs.getString('toAddress')!;
      String receiver = prefs.getString('receiver')!;
      String userNote = prefs.getString('userNote')!;
      String serverKey = prefs.getString('serverKey')!;
      double totalPrice = prefs.getDouble('totalPrice')!;

      LatLng from = LatLng(double.parse(jsonDecode(fromAddress)['lat']),
          double.parse(jsonDecode(fromAddress)['lng']));
      LatLng to = LatLng(double.parse(jsonDecode(toAddress)['lat']),
          double.parse(jsonDecode(toAddress)['lng']));
      Either<Failure, VietMapRoutingModel> routes =
          await Vietmap.routing(VietMapRoutingParams(points: [from, to]));
      routes.fold((l) => null, (r) {
        setState(() {
          totalDistance = distance +
              double.parse(r.paths!.first.distance.toString()) / 1000;
          totalPrice += 5 * totalDistance;
        });
      });

      context.read<DriverOptionBloc>().add(PlaceAnOrder(
          userId: userId.toString(),
          items: items,
          fromAddress: fromAddress,
          toAddress: toAddress,
          shippingCost: totalPrice.toString(),
          orderStatusId: "1",
          receiver: jsonDecode(receiver),
          userNote: userNote,
          driverRate: "0",
          distance: totalDistance.toString(),
          driverId: driver.id.toString(),
          serverKey: serverKey));
    }
  }
}
