import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:user_app/services/services_export.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<Logout>(_onLogout);
  }

  void _onLogout(Logout event, Emitter<HomeState> emit) async {
    emit(LogoutPeding());

    ApiResponse apiResponse = await UserService.logout(event.token);
    if (apiResponse.success == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      emit(LogoutSuccess());
    } else {
      emit(LogoutFailed(message: apiResponse.message));
    }
  }
}
