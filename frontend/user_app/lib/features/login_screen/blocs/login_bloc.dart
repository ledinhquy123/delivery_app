import 'package:equatable/equatable.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/services/services_export.dart';
import 'package:user_app/models/api_response.dart';
import 'package:user_app/models/auth/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    emit(LoginPeding());

    Map<String, dynamic> data = {
      "phone_number": event.phoneNumber,
      "password": event.password,
      "token": event.tokenDevice,
      "serverKey": event.serverKey,
      "guard": event.guard
    };

    ApiResponse apiResponse = await AuthServicer.login(data);

    if (apiResponse.success == true) {
      LoginModel login = LoginModel.fromMap(apiResponse.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('id', login.user.id);
      prefs.setString('userName', login.user.name);
      prefs.setString('phoneNumber', login.user.phoneNumber);
      prefs.setString('avatar', login.user.avatar!);
      prefs.setString('token', login.token);

      emit(LoginSuccess());
    } else {
      emit(LoginFailed(message: apiResponse.message));
    }
  }
}
