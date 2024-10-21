part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();
  
  @override
  List<Object> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {}

class GetOrdersListPending extends OrderHistoryState {}

class GetOrdersListSuccess extends OrderHistoryState {
  final ApiResponse apiResponse;

  const GetOrdersListSuccess({
    required this.apiResponse
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}

class GetOrderListFailed extends OrderHistoryState {
  final String message;

  const GetOrderListFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}

class RateDriverPending extends OrderHistoryState {}

class RateDriverSuccess extends OrderHistoryState {
  final ApiResponse apiResponse;

  const RateDriverSuccess({
    required this.apiResponse
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}

class RateDriverFailed extends OrderHistoryState {
  final String message;

  const RateDriverFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}