// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'driver_option_bloc.dart';

abstract class DriverOptionEvent extends Equatable {
  const DriverOptionEvent();

  @override
  List<Object> get props => [];
}

class GetDriverList extends DriverOptionEvent {
  final String token;

  const GetDriverList({
    required this.token,
  });

  @override
  List<Object> get props => [ token ];
}

class PlaceAnOrder extends DriverOptionEvent {
  final String userId;
  final String items;
  final String fromAddress;
  final String toAddress;
  final String shippingCost;
  final String orderStatusId;
  final String receiver;
  final String userNote;
  final String driverRate;
  final String distance;
  final String driverId;
  final String serverKey;

  const PlaceAnOrder({
    required this.userId,
    required this.items,
    required this.fromAddress,
    required this.toAddress,
    required this.shippingCost,
    required this.orderStatusId,
    required this.receiver,
    required this.userNote,
    required this.driverRate,
    required this.distance,
    required this.driverId,
    required this.serverKey,
  });

  @override
  List<Object> get props => [ 
    userId,
    items,
    fromAddress,
    toAddress,
    shippingCost,
    orderStatusId,
    receiver,
    userNote,
    driverRate,
    distance,
    driverId,
    serverKey
  ];  
}