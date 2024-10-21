// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_notification_bloc.dart';

abstract class UserNotificationState extends Equatable {
  const UserNotificationState();
  
  @override
  List<Object> get props => [];
}

class UserNotificationInitial extends UserNotificationState {}

class GetNotificationListPeding extends UserNotificationState {}

class GetNotificationListFailed extends UserNotificationState {
  final String message;

  const GetNotificationListFailed({
    required this.message,
  });
  
  @override
  List<Object> get props => [ message ];
}

class GetNotificationListSuccess extends UserNotificationState {
  final ApiResponse apiResponse;

  const GetNotificationListSuccess({
    required this.apiResponse,
  });

  @override
  List<Object> get props => [ apiResponse ];
}
