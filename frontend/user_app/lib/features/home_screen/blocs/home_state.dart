part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LogoutPeding extends HomeState {}

class LogoutFailed extends HomeState {
  final String message;

  const LogoutFailed({
    required this.message,
  });

  @override
  List<Object> get props => [
    message
  ];
}

class LogoutSuccess extends HomeState {}
