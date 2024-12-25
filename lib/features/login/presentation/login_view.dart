import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:task/core/common/widget/password_input_field.dart';
import 'package:task/core/common/widget/phone_input_field.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/page_states/page_state_handler.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/features/login/presentation/cubit/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeypassword = GlobalKey<FormState>();
  final _countryCodeController = TextEditingController();
  PageStateHandler pageStateHandler = PageStateHandler();
  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          pageStateHandler.handlePageState(state.pageState, context);
        },
        child: Scaffold(
          appBar: null,
          body: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            fit: BoxFit.fitWidth,
                            "assets/back_ground.png",
                            width: 375.w,
                            height: 750.h,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 326.w,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 450.h,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 300.h),
                                child: IntrinsicHeight(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey
                                          .withOpacity(0.1), // Semi-transparent
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      spacing: 20.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          child: Text(
                                            "Login",
                                            style:
                                                FontStyleManager().size24Bold(),
                                          ),
                                        ),
                                        Phone_input_field(
                                          formKey: _formKeyPhone,
                                          controller: _phoneController,
                                          countryCodeController:
                                              _countryCodeController,
                                        ),
                                        PasswordField(
                                          formKey: _formKeypassword,
                                          controller: _passwordController,
                                        ),
                                        MyButton(
                                          lable: 'Sign In',
                                          onPressed: () {
                                            if (_formKeyPhone.currentState!
                                                    .validate() &&
                                                _formKeypassword.currentState!
                                                    .validate()) {
                                              context.read<LoginCubit>().login(
                                                  _phoneController.text,
                                                  _passwordController.text,
                                                  _countryCodeController.text);
                                            }
                                          },
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "Didn’t have any account?",
                                                style: FontStyleManager()
                                                    .size14Normal(),
                                              ),
                                              TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Sign Up here",
                                                    style: FontStyleManager()
                                                        .size14Normal(
                                                            color: FontColors
                                                                .purple)
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.lable,
    required this.onPressed,
  });
  final String lable;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(1, 50.h))),
        onPressed: onPressed,
        child: Text(
          lable,
          style: FontStyleManager().size16Bold(color: FontColors.white),
        ));
  }
}
