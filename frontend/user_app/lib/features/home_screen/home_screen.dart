import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/constants/constants_export.dart';
import 'package:user_app/features/features_export.dart';
import 'package:user_app/features/home_screen/components/components_export.dart';
import 'package:user_app/services/services_export.dart';
import 'package:user_app/ultis/ultis_export.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectToPusher pusher = ConnectToPusher();
  final RequestLocation requestLocation = RequestLocation();
  File? _imageFile;

  final List<Map<String, dynamic>> _pageDetails = [
    {'page': const PendingOrderScreen(), 'title': 'Đang giao'},
    {'page': const OrderHistoryScreen(), 'title': 'Lịch sử'}
  ];

  int _currentIndex = 0;
  String userName = '';

  @override
  void initState() {
    super.initState();
    getAvatar();
    prepareHome();
    Vietmap.getInstance(MAP_KEY);
  }

  void prepareHome() async {
    pusher.connecToPusher();
    Position location = await requestLocation.getCurrentLocation();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('lat', location.latitude);
    prefs.setDouble('lng', location.longitude);

    String token = prefs.getString('token')!;
    String tokenDevice = prefs.getString('tokenDevice')!;
    int id = prefs.getInt('id')!;

    setState(() {
      userName = prefs.getString('userName')!;
    });

    Map<String, dynamic> data = {
      "address": '{"lat":"${location.latitude}","lng":"${location.longitude}"}',
      "fcm_token": tokenDevice
    };
    UserService.activeUser(token, data, id.toString());
  }

  void getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('avatar') != '') {
      File ans =
          await downloadAndSaveImage(prefs.getString('avatar').toString());
      setState(() {
        _imageFile = ans;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageDetails[_currentIndex]['title'],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                navigatorKey.currentState!.pushNamed(AddOrderScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
        elevation: 0,
      ),
      drawer: HomeDrawer(userName: userName, imageFile: _imageFile),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LogoutPeding) {
            showDialog(
                context: context,
                builder: (context) => Center(
                      child: CircularProgressIndicator(
                        color: Colors.green.shade800,
                      ),
                    ));
          } else if (state is LogoutSuccess) {
            navigatorKey.currentState!
                .pushReplacementNamed(AuthScreen.routeName);
          }
        },
        child: _pageDetails[_currentIndex]['page'],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.delivery_dining,
                ),
                label: 'Đang giao'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                label: 'Lịch sử')
          ]),
    );
  }
}
