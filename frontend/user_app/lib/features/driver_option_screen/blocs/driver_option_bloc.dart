import 'package:equatable/equatable.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:user_app/services/services_export.dart';

part 'driver_option_event.dart';
part 'driver_option_state.dart';

class DriverOptionBloc extends Bloc<DriverOptionEvent, DriverOptionState> {
  DriverOptionBloc() : super(DriverOptionInitial()) {
    on<GetDriverList>(_onGetDriverList);
    on<PlaceAnOrder>(_onPlaceAnOrder);
  }

  void _onGetDriverList(
      GetDriverList event, Emitter<DriverOptionState> emit) async {
    emit(GetDriverListPeding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiResponse apiResponse =
        await DriverService.getDriverList(prefs.getString('token')!);

    if (apiResponse.success == true) {
      List<dynamic> driverResponse = apiResponse.data as List<dynamic>;
      List<DriverModel> drivers =
          driverResponse.map((driver) => DriverModel.fromMap(driver)).toList();
      emit(GetDriverListSuccess(drivers: drivers));
    } else {
      emit(GetDriverListFailed(message: apiResponse.message));
    }
  }

  void _onPlaceAnOrder(
      PlaceAnOrder event, Emitter<DriverOptionState> emit) async {
    emit(PlaceAnOrderPeding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'user_id': event.userId,
      'items': event.items,
      'from_address': event.fromAddress,
      'to_address': event.toAddress,
      'receiver': event.receiver,
      'order_status_id': event.orderStatusId,
      'user_note': event.userNote,
      'driver_rate': event.driverRate,
      'serverKey': event.serverKey,
      'driver_id': event.driverId,
      'distance': event.distance,
      'shipping_cost': event.shippingCost
    };
    ApiResponse apiResponse =
        await OrderService.placeAnOrder(prefs.getString('token')!, data);

    if (apiResponse.success == true) {
      emit(PlaceAnOrderSuccess(apiResponse: apiResponse));
    } else {
      emit(PlaceAnOrderFailed(message: apiResponse.message));
    }
  }
}
