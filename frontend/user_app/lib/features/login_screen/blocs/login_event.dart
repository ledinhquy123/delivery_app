// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final String phoneNumber;
  final String password;
  final String tokenDevice;
  final String serverKey;
  final String guard;

  const Login({
    required this.phoneNumber,
    required this.password,
    required this.tokenDevice,
    required this.serverKey,
    required this.guard,
  });

  @override
  List<Object> get props => [
    phoneNumber,
    password,
    tokenDevice,
    serverKey,
    guard
  ];
}
