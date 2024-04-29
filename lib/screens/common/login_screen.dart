import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/misc/misc_controller.dart';
import 'package:event_management/providers/admin_controller_provider.dart';
import 'package:event_management/providers/student_provider.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
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
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassVisible1 = false;
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
          key: LoginScreen._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                name: 'Utmid',
                textInputType: TextInputType.text,
                controller: LoginScreen._utmidController,
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
                obscureText: !isPassVisible1,
                textInputType: TextInputType.text,
                widget: IconButton(
                  onPressed: () {
                    setState(() {
                      isPassVisible1 = !isPassVisible1;
                    });
                  },
                  icon: Icon(!isPassVisible1
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
                controller: LoginScreen._passwordController,
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
              ref.watch(adminControllerProvider) ||
                      ref.watch(studentControllerProvider)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      buttonText: 'Log in',
                      onPressed: () {
                        if (LoginScreen._formKey.currentState!.validate()) {
                          if (ref.read(selectedAccountType) ==
                              AccountType.student.name) {
                            print('call');
                            ref
                                .read(studentControllerProvider.notifier)
                                .login(
                                  utmid:
                                      LoginScreen._utmidController.text.trim(),
                                  password: LoginScreen._passwordController.text
                                      .trim(),
                                )
                                .then((isSuccess) {
                              if (isSuccess) {
                                context.nav.pushNamedAndRemoveUntil(
                                    Routes.studentDashboard, (route) => false);
                              }
                            });
                          } else {
                            ref
                                .read(adminControllerProvider.notifier)
                                .login(
                                  utmid:
                                      LoginScreen._utmidController.text.trim(),
                                  password: LoginScreen._passwordController.text
                                      .trim(),
                                )
                                .then((isSuccess) {
                              if (isSuccess) {
                                context.nav.pushNamedAndRemoveUntil(
                                    Routes.adminEventPage, (route) => false);
                              }
                            });
                          }
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

enum AccountType { admin, student }
