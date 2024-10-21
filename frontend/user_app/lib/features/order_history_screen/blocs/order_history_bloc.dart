import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:user_app/services/services_export.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    on<GetOrdersList>(_onGetOrderList);
    on<RateDriver>(_onRateDriver);
  }

  void _onGetOrderList(GetOrdersList event, Emitter<OrderHistoryState> emit) async {
    emit(GetOrdersListPending());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    ApiResponse response = await OrderService.getOrdersList(
      event.date, 
      event.id,
      event.guard,
      token
    );

    if(response.success == true) {
      emit(GetOrdersListSuccess(apiResponse: response));
    }else {
      emit(GetOrderListFailed(message: response.message));
    }
  }

  void _onRateDriver(RateDriver event, Emitter<OrderHistoryState> emit) async {
    emit(RateDriverPending());

    Map<String, dynamic> data = {
      "driver_rate": event.rate
    };
    ApiResponse response = await OrderService.ratingDriver(
      event.id,
      event.token,
      data
    );

    if(response.success == true) {
      emit(RateDriverSuccess(apiResponse: response));
    }else {
      emit(RateDriverFailed(message: response.message));
    }
  }
}
