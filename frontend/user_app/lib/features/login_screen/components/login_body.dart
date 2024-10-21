// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/features/features_export.dart';
import 'package:user_app/ultis/ultis_export.dart';
import 'package:user_app/widgets/widgets_export.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPass = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          showSnackbar(state.message, context, false);
        } else if (state is LoginSuccess) {
          navigatorKey.currentState!.pushNamed(OtpVerifyScreen.routeName);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  )
                ],
              ),
              const SizedBox(height: 12.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Đăng Nhập',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold),
                )
              ]),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Nhập số điện thoại',
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade900),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0))),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)))),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                obscureText: !showPass,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                      child: Icon(showPass == false
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    suffixIconColor: Colors.grey,
                    hintText: 'Nhập mật khẩu',
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade900),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0))),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)))),
              ),
              const SizedBox(height: 24.0),
              ButtonCustom(
                width: MediaQuery.of(context).size.width * 3 / 4,
                height: 40.0,
                color:
                    state is LoginPeding ? Colors.grey : Colors.green.shade900,
                text: state is LoginPeding ? 'Đang xử lý...' : 'Tiếp tục',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: state is LoginPeding ? Colors.black : Colors.white),
                radius: 30.0,
                onTap: state is LoginPeding
                    ? () {}
                    : () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String serverKey = prefs.getString('serverKey')!;
                        String tokenDevice = prefs.getString('tokenDevice')!;

                        context.read<LoginBloc>().add(Login(
                            phoneNumber: _phoneNumberController.text,
                            password: _passwordController.text,
                            tokenDevice: tokenDevice,
                            serverKey: serverKey,
                            guard: 'user'));
                      },
              )
            ],
          );
        },
      ),
    );
  }
}
