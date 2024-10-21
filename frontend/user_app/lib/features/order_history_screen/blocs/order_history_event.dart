// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersList extends OrderHistoryEvent {
  final String date;
  final String id;
  final String guard;

  const GetOrdersList({
    required this.date,
    required this.id,
    required this.guard,
  });

  @override
  List<Object> get props => [
    date,
    id,
    guard
  ];
}

class RateDriver extends OrderHistoryEvent {
  final String id;
  final String token;
  final String rate;

  const RateDriver({
    required this.id,
    required this.token,
    required this.rate,
  });

  @override
  List<Object> get props => [
    id,
    token,
    rate
  ];
}
