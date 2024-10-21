// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:user_app/models/models_export.dart';

class NotificationModel extends Equatable {
  final int id;
  final String title;
  final String body;
  final String createdAt;
  final UserModel user;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.user,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    String? body,
    String? createdAt,
    UserModel? user,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt,
      'driver': user.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      createdAt: map['created_at'] as String,
      user: UserModel.fromMap(map['user'] as Map<String,dynamic>),
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    title,
    body,
    createdAt,
    user
  ];

}
