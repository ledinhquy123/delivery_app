// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:user_app/models/models_export.dart';

class LoginModel {
  final UserModel user;
  final String token;
  LoginModel({
    required this.user,
    required this.token,
  });
  

  LoginModel copyWith({
    UserModel? user,
    String? token,
  }) {
    return LoginModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      user: UserModel.fromMap(map['user'] as Map<String,dynamic>),
      token: map['token'] as String,
    );
  }
}
