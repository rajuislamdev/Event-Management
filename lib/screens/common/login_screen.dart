import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final TextEditingController _utmidController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  static final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context: context),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              name: 'Utmid',
              textInputType: TextInputType.text,
              controller: _utmidController,
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Utmid is required!')
              ]),
              hintText: "Enter your Utmid here",
            ),
            Gap(20.h),
            CustomTextFormField(
              name: 'Password',
              textInputType: TextInputType.text,
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: 'Password is required!')
              ]),
              hintText: "Enter your password here",
            ),
            Gap(60.h),
            CustomButton(
              buttonText: 'Log in',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.nav.pushNamed(Routes.adminEventPage);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
