import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/misc/misc_controller.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final TextEditingController _utmidController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  static final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  static final List<Map<String, dynamic>> _accountType = [
    {'key': 'student', 'type': 'Student'},
    {'key': 'admin', 'type': 'Admin'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(context: context),
      body: _buildBody(context: context),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return Consumer(builder: (context, ref, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                name: 'Utmid',
                textInputType: TextInputType.text,
                controller: _utmidController,
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Utmid is required!')
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
              Gap(20.h),
              Row(
                children: LoginScreen._accountType
                    .map((e) => Row(
                          children: [
                            Checkbox(
                                value:
                                    ref.watch(selectedAccountType) == e['key'],
                                onChanged: (type) {
                                  ref.read(selectedAccountType.notifier).state =
                                      e['key'];
                                }),
                            Gap(5.w),
                            Text(
                              e['type'],
                              style: AppTextStyle(context).bodyText,
                            )
                          ],
                        ))
                    .toList(),
              ),
              Gap(20.h),
              CustomButton(
                buttonText: 'Log in',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.nav.pushNamed(Routes.adminEventPage);
                  } else {
                    print('object');
                  }
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBottomNav({required BuildContext context}) {
    return SizedBox(
      height: 55.h,
      child: Center(
        child: Wrap(
          children: [
            Text(
              "You don't have an account? ",
              style: AppTextStyle(context).bodyText,
            ),
            GestureDetector(
              onTap: () {
                context.nav.pushNamed(Routes.studentRegistration);
              },
              child: Text(
                'Register',
                style: AppTextStyle(context).bodyText.copyWith(
                    color: AppColor.purple, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
