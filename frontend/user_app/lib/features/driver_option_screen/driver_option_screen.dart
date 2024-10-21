// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/features/driver_option_screen/components/components_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class DriverOptionScreen extends StatefulWidget {
  const DriverOptionScreen({super.key});
  static const routeName = 'driverOptionScreen';

  @override
  State<DriverOptionScreen> createState() => _DriverOptionScreenState();
}

class _DriverOptionScreenState extends State<DriverOptionScreen> {
  List<Map<String, dynamic>> drivers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tài xế',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                if (drivers.isNotEmpty) {
                  drivers
                      .sort((a, b) => a['distance'].compareTo(b['distance']));
                  DriverModel driver = drivers[0]['driver'];
                    double distance = drivers[0]['distance'];
                    double totalDistance = 0;

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int userId = prefs.getInt('id')!;
                    String items = prefs.getString('items')!;
                    String fromAddress = prefs.getString('fromAddress')!;
                    String toAddress = prefs.getString('toAddress')!;
                    String receiver = prefs.getString('receiver')!;
                    String userNote = prefs.getString('userNote')!;
                    String serverKey = prefs.getString('serverKey')!;
                    double totalPrice = prefs.getDouble('totalPrice')!;

                    LatLng from = LatLng(
                        double.parse(jsonDecode(fromAddress)['lat']),
                        double.parse(jsonDecode(fromAddress)['lng']));
                    LatLng to = LatLng(
                        double.parse(jsonDecode(toAddress)['lat']),
                        double.parse(jsonDecode(toAddress)['lng']));
                    Either<Failure, VietMapRoutingModel> routes =
                        await Vietmap.routing(
                            VietMapRoutingParams(points: [from, to]));
                    routes.fold((l) => null, (r) {
                      setState(() {
                        totalDistance = distance +
                            double.parse(r.paths!.first.distance.toString()) /
                                1000;
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
              },
              child: Text(
                'Ngẫu nhiên',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.green),
              ))
        ],
      ),
      body: SafeArea(
        child: BlocListener<DriverOptionBloc, DriverOptionState>(
          listener: (context, state) async {
            if (state is GetDriverListSuccess) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<DriverModel> data = state.drivers;

              LatLng userPosition =
                  LatLng(prefs.getDouble('lat')!, prefs.getDouble('lng')!);

              for (var i = 0; i < data.length; i++) {
                double distance = 0;
                Either<Failure, VietMapRoutingModel> routes =
                    await Vietmap.routing(VietMapRoutingParams(points: [
                  userPosition,
                  LatLng(data[i].currentLocation!.lat,
                      data[i].currentLocation!.lng)
                ]));
                routes.fold((l) => null, (r) {
                  setState(() {
                    distance =
                        double.parse(r.paths!.first.distance.toString()) / 1000;
                  });
                });

                drivers.add({'driver': data[i], 'distance': distance});
              }
            }

            if (state is PlaceAnOrderPeding) {
              showDialog(
                  context: context,
                  builder: (context) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.green.shade800,
                        ),
                      ));
            } else if (state is PlaceAnOrderSuccess) {
              log('SUCCESS');
              // navigatorKey.currentState!
              //     .pushReplacementNamed(HomeScreen.routeName);
            }
          },
          child: BlocBuilder<DriverOptionBloc, DriverOptionState>(
            builder: (context, state) {
              return state is GetDriverListPeding
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    )
                  : (drivers.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: DriverOptionBody(drivers: drivers),
                          ))
                      : const DriverOptionEmpty());
            },
          ),
        ),
      ),
    );
  }
}
