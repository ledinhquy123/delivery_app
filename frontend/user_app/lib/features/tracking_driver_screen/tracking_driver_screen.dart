// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

import 'package:user_app/constants/app_const.dart';
import 'package:user_app/models/models_export.dart';

class TrackingDriverScreen extends StatefulWidget {
  const TrackingDriverScreen({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel order;

  @override
  State<TrackingDriverScreen> createState() => _TrackingDriverScreenState();
}

class _TrackingDriverScreenState extends State<TrackingDriverScreen> {
  LatLng? driverPosition;
  LatLng? userPosition;
  OrderModel? order;
  ConnectToPusher pusher = ConnectToPusher();
  VietmapController? mapController;

  @override
  void initState() {
    super.initState();
    Vietmap.getInstance(MAP_KEY);
    prepare();
  }

  void prepare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      order = widget.order;
      driverPosition = LatLng(order!.driver.currentLocation!.lat,
          order!.driver.currentLocation!.lng);
      userPosition = LatLng(prefs.getDouble('lat')!, prefs.getDouble('lng')!);
      _moveLocation();
    });
    pusher.connecToPusher();
    pusher.pusher.subscribe(
        channelName: 'private-update-driver-location.${prefs.getInt('id')}',
        onEvent: (event) {
          var ans = jsonDecode(event.data);

          log(ans.toString());
          setState(() {
            driverPosition = LatLng(double.parse(ans['lat'].toString()),
                double.parse(ans['lng'].toString()));
          });
        });
  }

  void _moveLocation() {
    mapController?.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: userPosition!, zoom: 16)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theo dõi đơn hàng',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
          child: Stack(
        children: [
          VietmapGL(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.order.user.address!.lat,
                    widget.order.user.address!.lng),
                zoom: 16),
            styleString: Vietmap.getVietmapStyleUrl(),
            onMapCreated: (VietmapController controller) {
              setState(() {
                mapController = controller;
              });
            },
          ),
          Positioned(
              bottom: 8.0,
              right: 8.0,
              child: GestureDetector(
                onTap: _moveLocation,
                child: const Icon(
                  Icons.my_location,
                  size: 30,
                ),
              )),
          mapController != null && driverPosition != null
              ? MarkerLayer(markers: [
                  Marker(
                      alignment: Alignment.bottomCenter,
                      width: 30,
                      height: 30,
                      child: const Icon(
                        FontAwesomeIcons.circleUser,
                        color: Colors.blue,
                        size: 20,
                      ),
                      latLng:
                          LatLng(order!.toAddress.lat, order!.toAddress.lng)),
                  Marker(
                      alignment: Alignment.bottomCenter,
                      width: 30,
                      height: 30,
                      child: const Icon(
                        FontAwesomeIcons.truck,
                        color: Colors.green,
                        size: 20,
                      ),
                      latLng: driverPosition!)
                ], mapController: mapController!)
              : const SizedBox.shrink()
        ],
      )),
    );
  }
}
