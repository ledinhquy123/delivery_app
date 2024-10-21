import 'package:flutter/material.dart';
import 'package:user_app/bloc_export.dart';
import 'package:user_app/ultis/ultis_export.dart';
import 'package:user_app/widgets/widgets_export.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPass = false;
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool showRepeatPass = false;

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailed) {
          showSnackbar(state.message, context, false);
        } else if (state is RegisterSuccess) {
          showSnackbar(
              'Đăng ký thành công, đăng nhập để tiếp tục', context, true);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
              ]),
              const SizedBox(height: 12.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Đăng Ký',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold),
                )
              ]),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Nhập tên',
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
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _repeatPasswordController,
                obscureText: !showRepeatPass,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showRepeatPass = !showRepeatPass;
                        });
                      },
                      child: Icon(showRepeatPass == false
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    suffixIconColor: Colors.grey,
                    hintText: 'Nhập lại mật khẩu',
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
                  color: state is RegisterPeding
                      ? Colors.grey
                      : Colors.green.shade900,
                  text: state is RegisterPeding ? 'Đang xử lý...' : 'Đăng ký',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: state is RegisterPeding
                          ? Colors.black
                          : Colors.white),
                  radius: 30.0,
                  onTap: () {
                    context.read<RegisterBloc>().add(Register(
                        name: _nameController.text,
                        phoneNumber: _phoneNumberController.text,
                        password: _passwordController.text,
                        passwordConfirmation: _repeatPasswordController.text));
                  })
            ],
          );
        },
      ),
    );
  }
}
