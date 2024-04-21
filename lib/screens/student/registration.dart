import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/models/student.dart';
import 'package:event_management/providers/student_provider.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  static final nameController = TextEditingController();
  static final utmidController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();
  static final matricnoController = TextEditingController();
  static final facultyController = TextEditingController();
  static final programController = TextEditingController();
  static final semesterController = TextEditingController();
  static final passwordController = TextEditingController();

  static final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(context: context),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Consumer(builder: (context, ref, _) {
      return FormBuilder(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    name: 'Name',
                    textInputType: TextInputType.text,
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Name is required!')
                    ]),
                    hintText: "Enter your name here",
                  ),
                  Gap(12.h),
                  CustomTextFormField(
                    name: 'Email',
                    textInputType: TextInputType.text,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Email is required!'),
                      FormBuilderValidators.email(
                          errorText: 'Please enter valid email!'),
                    ]),
                    hintText: "Enter your email here",
                  ),
                  Gap(12.h),
                  CustomTextFormField(
                    name: 'Phone',
                    textInputType: TextInputType.text,
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Phone is required!'),
                    ]),
                    hintText: "Enter your phone number here",
                  ),
                  Gap(12.h),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: CustomTextFormField(
                          name: 'Utmid',
                          textInputType: TextInputType.text,
                          controller: utmidController,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Utmid is required!')
                          ]),
                          hintText: "Enter your utmid here",
                        ),
                      ),
                      Gap(5.w),
                      Flexible(
                        flex: 1,
                        child: CustomTextFormField(
                          name: 'Matric No',
                          textInputType: TextInputType.text,
                          controller: matricnoController,
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Matric No is required!')
                          ]),
                          hintText: "Enter your Matric No here",
                        ),
                      ),
                    ],
                  ),
                  Gap(12.h),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Faculty',
                                style: AppTextStyle(ContextLess.context)
                                    .bodyText
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Gap(12.h),
                              FormBuilderDropdown(
                                focusColor: Colors.transparent,
                                name: 'faculty',
                                decoration: GlobalFunction.buildInputDecoration(
                                  ContextLess.context,
                                  'Faculty',
                                  null,
                                ),
                                onChanged: (value) {},
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'Faculty is required!')
                                ]),
                                items: faculty
                                    .map((dropdownValue) => DropdownMenuItem(
                                          value: dropdownValue,
                                          child: Text(dropdownValue),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(5.w),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Program',
                                style: AppTextStyle(ContextLess.context)
                                    .bodyText
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Gap(12.h),
                              FormBuilderDropdown(
                                focusColor: Colors.transparent,
                                name: 'program',
                                decoration: GlobalFunction.buildInputDecoration(
                                    ContextLess.context, 'Program', null),
                                onChanged: (value) {},
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'Program is required!')
                                ]),
                                items: programs
                                    .map((dropdownValue) => DropdownMenuItem(
                                          value: dropdownValue,
                                          child: Text(dropdownValue.toString()),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(12.h),
                  FormBuilderDropdown(
                    focusColor: Colors.transparent,
                    name: 'semester',
                    decoration: GlobalFunction.buildInputDecoration(
                        ContextLess.context, 'Semester', null),
                    onChanged: (value) {},
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Semester is required!')
                    ]),
                    items: semester
                        .map((dropdownValue) => DropdownMenuItem(
                              value: dropdownValue,
                              child: Text(dropdownValue.toString()),
                            ))
                        .toList(),
                  ),
                  Gap(12.h),
                  CustomTextFormField(
                    name: 'Password',
                    textInputType: TextInputType.text,
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Phone is required!'),
                      FormBuilderValidators.minLength(6,
                          errorText: 'Password must be at least 6 charectures')
                    ]),
                    hintText: "Enter your phone number here",
                  ),
                  Gap(40.h),
                  ref.watch(studentControllerProvider)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          buttonText: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final Student student = Student(
                                utmid: utmidController.text.trim(),
                                name: nameController.text,
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                matricNo: matricnoController.text.trim(),
                                faculty: _formKey.currentState!
                                    .fields['faculty']!.value as String,
                                program: _formKey.currentState!
                                    .fields['program']!.value as String,
                                semester: _formKey.currentState!
                                    .fields['semester']!.value as String,
                              );
                              ref
                                  .read(studentControllerProvider.notifier)
                                  .registration(
                                      student: student,
                                      password: passwordController.text.trim())
                                  .then((isSuccess) {
                                if (isSuccess) {
                                  context.nav.pop();
                                }
                              });
                            }
                          },
                        )
                ],
              ),
            ),
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
              "Do you already have an account? ",
              style: AppTextStyle(context).bodyText,
            ),
            GestureDetector(
              onTap: () {
                context.nav.pop();
              },
              child: Text(
                'Login',
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

final List<String> faculty = ['Faculty1', 'Faculty2', 'Faculty3', 'Faculty4'];
final List<String> programs = ['Program1', 'Program2', 'Program3', 'Program4'];
final List<String> semester = [
  'First',
  'Second',
  'Third',
  'Four',
  'Five',
  'Six',
  'Seven',
  'Eight',
  'Nine',
  'Ten'
];
