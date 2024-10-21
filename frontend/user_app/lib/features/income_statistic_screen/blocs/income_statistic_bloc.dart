import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/models/models_export.dart';
import 'package:user_app/services/services_export.dart';

part 'income_statistic_event.dart';
part 'income_statistic_state.dart';

class IncomeStatisticBloc extends Bloc<IncomeStatisticEvent, IncomeStatisticState> {
  IncomeStatisticBloc() : super(IncomeStatisticInitial()) {
    on<GetIncomeStatisitc>(_onGetIncomeStatistic);
  }

  void _onGetIncomeStatistic(GetIncomeStatisitc event, Emitter<IncomeStatisticState> emit) async {
    emit(GetIncomeStatisticPeding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    ApiResponse response = await OrderService.getIncomeStatistic(event.type, event.id, token);
    if(response.success == true) {
      emit(GetIncomeStatisticSuccess(apiResponse: response));
    }else {
      emit(GetIncomeStatisticFailed(message: response.message));
    }
  }
}
