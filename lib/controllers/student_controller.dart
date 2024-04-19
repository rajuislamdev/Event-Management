import 'package:event_management/models/student.dart';
import 'package:event_management/services/student_service.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentController extends StateNotifier<bool> {
  final Ref ref;
  StudentController(this.ref) : super(false);

  Future<bool> registration({
    required Student student,
    required String password,
  }) async {
    try {
      state = true;
      bool isSuccess = await ref.read(studentServiceProvider).registration(
            student: student,
            password: password,
          );
      if (isSuccess) {
        GlobalFunction.showCustomSnackbar(
          message: 'Account has been successfully created!',
          isSuccess: true,
        );
      } else {
        GlobalFunction.showCustomSnackbar(
          message: 'Already have an account with this email!',
          isSuccess: false,
        );
      }
      state = false;
      return isSuccess;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }
}
