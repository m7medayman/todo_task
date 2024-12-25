import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/core/validator/input_fields_validator.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.formKey,
    required this.controller,
  }) : super(key: key);
  final GlobalKey formKey;
  final TextEditingController controller;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Form(
            key: widget.formKey,
            child: TextFormField(
                validator: InputValidator.validatePassword,
                controller: widget.controller,
                obscureText: _obscureText,
                style: FontStyleManager().size14Normal(),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: FontColors.grey,
                        size: 24.sp,
                      ),
                      onPressed: _toggleVisibility,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                    hintText: "password...",
                    hintStyle: FontStyleManager().size14Normal(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))))));
  }
}
