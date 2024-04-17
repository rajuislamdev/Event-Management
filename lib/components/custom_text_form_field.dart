import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomTextFormField extends StatelessWidget {
  final String name;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Widget? widget;
  final bool? obscureText;
  final int? minLines;
  final bool showName;
  final String hintText;
  const CustomTextFormField({
    super.key,
    required this.name,
    this.focusNode,
    required this.textInputType,
    required this.controller,
    required this.textInputAction,
    required this.validator,
    this.readOnly,
    this.widget,
    this.obscureText,
    this.minLines,
    this.showName = true,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName)
          Text(
            name,
            style: AppTextStyle(context)
                .bodyText
                .copyWith(fontWeight: FontWeight.w500),
          ),
        Gap(8.h),
        AbsorbPointer(
          absorbing: readOnly ?? false,
          child: FormBuilderTextField(
            readOnly: readOnly ?? false,
            textAlign: TextAlign.start,
            minLines: minLines ?? 1,
            maxLines: minLines ?? 1,
            name: name,
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText ?? false,
            style: AppTextStyle(context).bodyText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            cursorColor: AppColor.purple,
            obscuringCharacter: '●',
            decoration:
                GlobalFunction.buildInputDecoration(context, hintText, widget),
            keyboardType: textInputType,
            textInputAction: textInputAction,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
