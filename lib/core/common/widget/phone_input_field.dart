import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/core/validator/input_fields_validator.dart';

class Phone_input_field extends StatelessWidget {
  const Phone_input_field({
    super.key,
    required this.controller,
    required this.formKey,
    required this.countryCodeController,
  });
  final TextEditingController controller;
  final GlobalKey formKey;
  final TextEditingController countryCodeController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        style: FontStyleManager().size14Normal(),
        decoration: InputDecoration(
          hintStyle: FontStyleManager().size14Normal(),
          hintText: "123-456-798",
          contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 2.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.darkGreyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.darkGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: ColorManager.primaryColor, width: 2.0),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryCodePicker(
                  onInit: (value) {
                    countryCodeController.text = value!.dialCode.toString();
                  },
                  onChanged: (value) {
                    countryCodeController.text = value.dialCode.toString();
                  },
                  initialSelection: "Egypt",
                  flagWidth: 28.w,
                  padding: EdgeInsets.all(8.sp),
                  textStyle: FontStyleManager().size16Normal(),
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                Icon(Icons.expand_more)
              ],
            ),
          ),
        ),
        keyboardType: TextInputType.phone,
        validator: InputValidator.validatePhone,
      ),
    );
  }
}
