import 'package:event_management/components/confirmation_dialog.dart';
import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/models/admin.dart';
import 'package:event_management/providers/admin_controller_provider.dart';
import 'package:event_management/providers/student_provider.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/services/hive_service.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class AdminProfile extends ConsumerStatefulWidget {
  const AdminProfile({super.key});

  @override
  ConsumerState<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends ConsumerState<AdminProfile> {
  static final nameController = TextEditingController();
  static final utmidController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();

  static final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(adminControllerProvider.notifier).getAdmin().then((admin) {
        if (admin != null) {
          setState(() {
            nameController.text = admin.name;
            utmidController.text = admin.utmid;
            emailController.text = admin.email;
            phoneController.text = admin.phone;
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
                        Gap(20.h),
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
                              child: Container(),
                            ),
                          ],
                        ),
                        Gap(40.h),
                        ref.watch(adminControllerProvider)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                buttonText: 'Update',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final Admin admin = Admin(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      utmid: utmidController.text.trim(),
                                    );
                                    ref
                                        .read(adminControllerProvider.notifier)
                                        .updateAdminInfo(admin: admin);
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
