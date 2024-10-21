// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:user_app/app_export.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/features/features_export.dart';
import 'package:user_app/features/income_statistic_screen/blocs/income_statistic_bloc.dart';
import 'package:user_app/features/notifications_screen/blocs/user_notification_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.userName,
    required this.imageFile,
  }) : super(key: key);
  final String userName;

  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(color: Colors.green.shade700),
              child: Flexible(
                flex: 1,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageFile != null
                        ? Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                image: imageFile != null
                                    ? DecorationImage(
                                        image: FileImage(imageFile ?? File('')),
                                        fit: BoxFit.cover)
                                    : null,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100))),
                          )
                        : ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Image.asset('assets/images/user.png',
                                  fit: BoxFit.cover),
                            ),
                          ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      flex: 3,
                      child: Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white, fontSize: 22),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              onTap: () {
                navigatorKey.currentState!
                    .pushReplacementNamed(HomeScreen.routeName);
              },
              title: const Text('Trang chủ'),
            ),
            ListTile(
              leading: const Icon(
                Icons.add_shopping_cart,
              ),
              onTap: () {
                navigatorKey.currentState!.pushNamed(AddOrderScreen.routeName);
              },
              title: const Text('Tạo đơn hàng'),
            ),
            BlocBuilder<IncomeStatisticBloc, IncomeStatisticState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(
                    Icons.bar_chart,
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    context.read<IncomeStatisticBloc>().add(GetIncomeStatisitc(
                        type: 'month', id: prefs.getInt('id')!.toString()));

                    Navigator.pushNamed(
                        context, IncomeStatisticScreen.routeName);
                  },
                  title: const Text('Thống kê'),
                );
              },
            ),
            BlocBuilder<UserNotificationBloc, UserNotificationState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(
                    Icons.notifications,
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    context.read<UserNotificationBloc>().add(
                        GetNotificationList(
                            guard: 'user', id: prefs.getInt('id')!.toString()));

                    Navigator.pushNamed(context, NotificationScreen.routeName);
                  },
                  title: const Text('Thông báo'),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              onTap: () {
                navigatorKey.currentState!.pushNamed(ProfileScreen.routeName);
              },
              title: const Text('Thông tin cá nhân'),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    context
                        .read<HomeBloc>()
                        .add(Logout(token: prefs.getString('token')!));
                  },
                  title: const Text('Đăng xuất'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
