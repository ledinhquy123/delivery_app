import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/notifications_screen/blocs/user_notification_bloc.dart';
import 'package:user_app/features/notifications_screen/components/components_export.dart';
import 'package:user_app/models/models_export.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const routeName = 'notificationScreen';
  @override
  State<NotificationScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thông báo',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
          child: BlocBuilder<UserNotificationBloc, UserNotificationState>(
            builder: (context, state) {
              if(state is GetNotificationListSuccess) {
                List<dynamic> dataResponse = state.apiResponse.data as List<dynamic>;
                notifications = dataResponse.map((notification) => NotificationModel.fromMap(notification)).toList();
              }
              return state is GetNotificationListSuccess
                ? (
                  notifications.isNotEmpty
                    ? NotificationBody(notifications: notifications)
                    : const NotificationEmpty()
                )
                : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.green.shade700,
                    ),
                  ),
                )
                ;
            },
          )
        ),
    );
  }
}