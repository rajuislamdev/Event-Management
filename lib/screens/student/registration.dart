import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/misc/misc_controller.dart';
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
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Email is required!')
                    ]),
                    hintText: "Enter your email here",
                  ),
                  Gap(12.h),
                  CustomTextFormField(
                    name: 'Phone',
                    textInputType: TextInputType.text,
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Phone is required!')
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
                          controller: nameController,
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
                                name: 'dropdown_field',
                                decoration: GlobalFunction.buildInputDecoration(
                                  ContextLess.context,
                                  'Faculty',
                                  null,
                                ),
                                onChanged: (value) {
                                  ref.read(selectedFaculty.notifier).state =
                                      value.toString();
                                },
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
                                name: 'dropdown_field_experience',
                                decoration: GlobalFunction.buildInputDecoration(
                                    ContextLess.context, 'Program', null),
                                onChanged: (value) {
                                  ref.read(selectedProgram.notifier).state =
                                      value;
                                },
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
                    name: 'dropdown_field_experience',
                    decoration: GlobalFunction.buildInputDecoration(
                        ContextLess.context, 'Semester', null),
                    onChanged: (value) {
                      ref.read(selectedSemester.notifier).state = value;
                    },
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
                    controller: nameController,
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
                  CustomButton(
                    buttonText: 'Sign Up',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
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

  static final List<String> faculty = [
    'Faculty1',
    'Faculty2',
    'Faculty3',
    'Faculty4'
  ];
  static final List<String> programs = [
    'Program1',
    'Program2',
    'Program3',
    'Program4'
  ];
  static final List<String> semester = [
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
