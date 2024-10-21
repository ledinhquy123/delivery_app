// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginPeding extends LoginState {}

class LoginFailed extends LoginState {
  final String message;

  const LoginFailed({
    required this.message,
  });
  
  @override
  List<Object> get props => [message];
}

class LoginSuccess extends LoginState {}