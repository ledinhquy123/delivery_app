part of 'income_statistic_bloc.dart';

abstract class IncomeStatisticState extends Equatable {
  const IncomeStatisticState();
  
  @override
  List<Object> get props => [];
}

class IncomeStatisticInitial extends IncomeStatisticState {}

class GetIncomeStatisticPeding extends IncomeStatisticState {}

class GetIncomeStatisticFailed extends IncomeStatisticState {
  final String message;

  const GetIncomeStatisticFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}

class GetIncomeStatisticSuccess extends IncomeStatisticState {
  final ApiResponse apiResponse;

  const GetIncomeStatisticSuccess({
    required this.apiResponse
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}
