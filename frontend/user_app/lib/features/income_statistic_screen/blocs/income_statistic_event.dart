part of 'income_statistic_bloc.dart';

abstract class IncomeStatisticEvent extends Equatable {
  const IncomeStatisticEvent();

  @override
  List<Object> get props => [];
}

class GetIncomeStatisitc extends IncomeStatisticEvent {
  final String type;
  final String id;

  const GetIncomeStatisitc({
    required this.type,
    required this.id,
  });

  @override
  List<Object> get props => [
    type,
    id
  ];
}
