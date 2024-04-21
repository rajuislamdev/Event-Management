import 'package:event_management/components/confirmation_dialog.dart';
import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/models/student.dart';
import 'package:event_management/providers/student_provider.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/screens/student/registration.dart';
import 'package:event_management/services/hive_service.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class StudentProfile extends ConsumerStatefulWidget {
  const StudentProfile({super.key});

  @override
  ConsumerState<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends ConsumerState<StudentProfile> {
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(studentControllerProvider.notifier).getStudent().then((student) {
        if (student != null) {
          setState(() {
            nameController.text = student.name;
            utmidController.text = student.utmid;
            emailController.text = student.email;
            phoneController.text = student.phone;
            matricnoController.text = student.matricNo;
            facultyController.text = student.faculty;
            programController.text = student.program;
            semesterController.text = student.semester;
          });
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => ConfirmationDialog(
                    title: 'Are you sure want to logout?',
                    confirmButtonText: 'Confirm',
                    onPressed: () {
                      ref.read(hiveServiceProvider).logout().then(
                            (value) => context.nav.pushNamedAndRemoveUntil(
                                Routes.loginScreen, (route) => false),
                          );
                    },
                  ),
                );
              },
            )
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer(builder: (context, ref, _) {
      return FormBuilder(
        key: _formKey,
        child: Center(
          child: ref.watch(studentControllerProvider)
              ? const CircularProgressIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 28.sp,
                            ),
                          ),
                        ),
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
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Gap(12.h),
                                    FormBuilderDropdown(
                                      focusColor: Colors.transparent,
                                      initialValue: facultyController.text,
                                      name: 'faculty',
                                      decoration:
                                          GlobalFunction.buildInputDecoration(
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
                                          .map((dropdownValue) =>
                                              DropdownMenuItem(
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
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Gap(12.h),
                                    FormBuilderDropdown(
                                      focusColor: Colors.transparent,
                                      initialValue: programController.text,
                                      name: 'program',
                                      decoration:
                                          GlobalFunction.buildInputDecoration(
                                              ContextLess.context,
                                              'Program',
                                              null),
                                      onChanged: (value) {},
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(
                                            errorText: 'Program is required!')
                                      ]),
                                      items: programs
                                          .map((dropdownValue) =>
                                              DropdownMenuItem(
                                                value: dropdownValue,
                                                child: Text(
                                                    dropdownValue.toString()),
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
                          initialValue: semesterController.text,
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
                        Gap(40.h),
                        ref.watch(studentControllerProvider)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                buttonText: 'Update',
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
                                        .read(
                                            studentControllerProvider.notifier)
                                        .updateStudentInfo(student: student);
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
}
