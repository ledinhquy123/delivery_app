// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Logout extends HomeEvent {
  final String token;

  const Logout({
    required this.token,
  });

  @override
  List<Object> get props => [
    token
  ];
}
