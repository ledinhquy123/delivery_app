import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/models/models_export.dart';
import 'package:user_app/services/services_export.dart';

part 'user_notification_event.dart';
part 'user_notification_state.dart';

class UserNotificationBloc
    extends Bloc<UserNotificationEvent, UserNotificationState> {
  UserNotificationBloc() : super(UserNotificationInitial()) {
    on<GetNotificationList>(_onGetNotificationList);
  }

  void _onGetNotificationList(
      GetNotificationList event, Emitter<UserNotificationState> emit) async {
    emit(GetNotificationListPeding());

    ApiResponse response =
        await UserService.getUserNotifications(event.guard, event.id);
    if (response.success == true) {
      emit(GetNotificationListSuccess(apiResponse: response));
    } else {
      emit(GetNotificationListFailed(message: response.message));
    }
  }
}
