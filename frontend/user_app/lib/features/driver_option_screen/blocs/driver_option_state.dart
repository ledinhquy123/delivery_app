// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'driver_option_bloc.dart';

abstract class DriverOptionState extends Equatable {
  const DriverOptionState();
  
  @override
  List<Object> get props => [];
}

class DriverOptionInitial extends DriverOptionState {}

// ? STATE GET DRIVER LIST
class GetDriverListPeding extends DriverOptionState {}

class GetDriverListFailed extends DriverOptionState {
  final String message;

  const GetDriverListFailed({
    required this.message,
  });

  @override
  List<Object> get props => [ message ];
}

class GetDriverListSuccess extends DriverOptionState {
  final List<DriverModel> drivers;

  const GetDriverListSuccess({
    required this.drivers,
  });

  @override
  List<Object> get props => [ drivers ];
}

// ? STATE PLACE AN ORDER
class PlaceAnOrderPeding extends DriverOptionState {}

class PlaceAnOrderFailed extends DriverOptionState {
  final String message;

  const PlaceAnOrderFailed({
    required this.message
  });

  @override
  List<Object> get props => [ message ];
}

class PlaceAnOrderSuccess extends DriverOptionState {
  final ApiResponse apiResponse;

  const PlaceAnOrderSuccess({
    required this.apiResponse,
  });

  @override
  List<Object> get props => [ apiResponse ];
}
