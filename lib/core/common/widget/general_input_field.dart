import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/core/validator/input_fields_validator.dart';

class GeneralInputField extends StatelessWidget {
  const GeneralInputField(
      {super.key,
      this.readOnly = false,
      this.onTap,
      this.maxLines = 1,
      required this.textEditingController,
      required this.formKey,
      required this.hintText,
      this.iconData,
      this.isEnable = true,
      this.inputValidator,
      this.keyboardType});
  final TextEditingController textEditingController;
  final GlobalKey formKey;
  final String hintText;
  final Widget? iconData;
  final bool isEnable;
  final TextInputType? keyboardType;
  final String? Function(String?)? inputValidator;
  final int? maxLines;
  final bool readOnly;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Form(
            key: formKey,
            child: TextFormField(
                readOnly: readOnly,
                onTap: onTap,
                maxLines: maxLines,
                keyboardType: keyboardType ?? TextInputType.text,
                validator:
                    inputValidator ?? InputValidator.validateRegularField,
                enabled: isEnable,
                controller: textEditingController,
                style: FontStyleManager.size14Normal(),
                decoration: InputDecoration(
                    suffixIcon: iconData,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                    hintText: hintText,
                    hintStyle: FontStyleManager.size14Normal(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))))));
  }
}
