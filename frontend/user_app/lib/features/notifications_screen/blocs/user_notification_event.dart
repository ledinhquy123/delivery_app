// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_notification_bloc.dart';

abstract class UserNotificationEvent extends Equatable {
  const UserNotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationList extends UserNotificationEvent {
  final String id;
  final String guard;

  const GetNotificationList({
    required this.id,
    required this.guard,
  });

  @override
  List<Object> get props => [
    id, 
    guard
  ];
}
