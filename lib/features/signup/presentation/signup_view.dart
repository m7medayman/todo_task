import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/common/widget/drop_down_Button.dart';
import 'package:task/core/common/widget/general_input_field.dart';
import 'package:task/core/common/widget/password_input_field.dart';
import 'package:task/core/common/widget/phone_input_field.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/page_states/page_state_handler.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/core/rout_manager/rout_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/core/validator/input_fields_validator.dart';
import 'package:task/features/signup/presentation/cubit/singup_cubit.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _phoneController = TextEditingController();
  final _phoneCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeypassword = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _levelController = TextEditingController();
  final _experienceController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyLevel = GlobalKey<FormState>();
  final _formKeyAddress = GlobalKey<FormState>();
  final _yearsOFExperienceController = TextEditingController();
  final _formKeyYearsOFExperience = GlobalKey<FormState>();
  @override
  void dispose() {
    _phoneCodeController.dispose();
    _nameController.dispose();
    _levelController.dispose();
    _experienceController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  PageStateHandler pageStateHandler = PageStateHandler();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SingupCubit>(),
      child: BlocListener<SingupCubit, SingupState>(
        listener: (context, state) {
          pageStateHandler.handlePageState(state.pageState, context);
          if (state.pageState is SuccessPageState) {
            Navigator.of(context).pushReplacementNamed(Routes.homePage);
          }
        },
        child: Builder(builder: (context) {
          final isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          return Scaffold(
            appBar: null,
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            // scale: 0.2,
                            fit: BoxFit.fill,
                            "assets/back_ground.png",
                            width: 375.w,
                            height: isPortrait ? 350.h : 250.h,
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
                                height: isPortrait ? 200.h : 150.h,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 300.h,
                                ),
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
                                            "Signup",
                                            style:
                                                FontStyleManager.size24Bold(),
                                          ),
                                        ),
                                        GeneralInputField(
                                            textEditingController:
                                                _nameController,
                                            formKey: _formKeyName,
                                            hintText: "Name"),
                                        Phone_input_field(
                                          controller: _phoneController,
                                          formKey: _formKeyPhone,
                                          countryCodeController:
                                              _phoneCodeController,
                                        ),
                                        GeneralInputField(
                                            keyboardType: TextInputType.number,
                                            textEditingController:
                                                _yearsOFExperienceController,
                                            formKey: _formKeyYearsOFExperience,
                                            inputValidator:
                                                InputValidator.validateInt,
                                            hintText: "Years of experience..."),
                                        MyLevelDropDownButton(
                                          formKey: _formKeyLevel,
                                          controller: _levelController,
                                        ),
                                        GeneralInputField(
                                            textEditingController:
                                                _addressController,
                                            formKey: _formKeyAddress,
                                            hintText: "Address..."),
                                        PasswordField(
                                          controller: _passwordController,
                                          formKey: _formKeypassword,
                                        ),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                minimumSize:
                                                    WidgetStatePropertyAll(
                                                        Size(1, 50.h))),
                                            onPressed: () {
                                              if (_formKeyName.currentState!
                                                      .validate() &&
                                                  _formKeyPhone.currentState!
                                                      .validate() &&
                                                  _formKeyYearsOFExperience
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyLevel.currentState!
                                                      .validate() &&
                                                  _formKeyAddress.currentState!
                                                      .validate() &&
                                                  _formKeypassword.currentState!
                                                      .validate()) {
                                                context.read<SingupCubit>().signUP(
                                                    name: _nameController.text,
                                                    phone: _phoneCodeController
                                                            .text +
                                                        _phoneController.text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    yearsOfExperince:
                                                        _yearsOFExperienceController
                                                            .text,
                                                    adress:
                                                        _addressController.text,
                                                    level:
                                                        _levelController.text);
                                              }
                                            },
                                            child: Text(
                                              "Sign up",
                                              style:
                                                  FontStyleManager.size16Bold(
                                                      color: FontColors.white),
                                            )),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "Already have any account?",
                                                style: FontStyleManager
                                                    .size14Normal(),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            Routes.login);
                                                  },
                                                  child: Text(
                                                    "Sign in",
                                                    style: FontStyleManager
                                                            .size14Normal(
                                                                color:
                                                                    FontColors
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
              ),
            ),
          );
        }),
      ),
    );
  }
}
