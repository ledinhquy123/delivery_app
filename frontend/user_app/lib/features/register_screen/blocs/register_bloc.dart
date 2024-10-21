import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/services/services_export.dart';
import 'package:user_app/models/api_response.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<Register>(_onRegister);
  }

  void _onRegister(Register event, Emitter<RegisterState> emit) async {
    emit(RegisterPeding());

    Map<String, dynamic> data = {
      "name": event.name,
      "phone_number": event.phoneNumber,
      "password": event.password,
      "password_confirmation" : event.passwordConfirmation
    };

    ApiResponse apiResponse = await AuthServicer.register(data);

    if(apiResponse.success == true) {
      emit(RegisterSuccess());
    }else {
      emit(RegisterFailed(message: apiResponse.message));
    }
  }
}
