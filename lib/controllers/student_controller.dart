import 'package:event_management/models/student.dart';
import 'package:event_management/services/hive_service.dart';
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

  Future<bool> login({
    required String utmid,
    required String password,
  }) async {
    try {
      state = true;
      bool isSuccess = await ref
          .read(studentServiceProvider)
          .login(utmid: utmid, password: password);
      state = false;
      return isSuccess;
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return false;
    }
  }

  Future<Student?> getStudent() async {
    try {
      state = true;
      final docId = ref.read(hiveServiceProvider).getUserId();

      final studentInfo =
          await ref.read(studentServiceProvider).getStudent(docId!);
      debugPrint(studentInfo.toJson());
      state = false;
      return studentInfo;
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return null;
    }
  }

  Future<void> updateStudentInfo({required Student student}) async {
    try {
      state = true;
      final docId = await ref.read(hiveServiceProvider).getUserInfo();

      await ref
          .read(studentServiceProvider)
          .updateStudentInfo(documentId: docId!['id'], updatedData: student);
      GlobalFunction.showCustomSnackbar(
          message: 'Student information has been successfully updated!',
          isSuccess: true);
      state = false;
    } catch (error) {
      GlobalFunction.showCustomSnackbar(
          message: 'Something went wrong', isSuccess: true);
      debugPrint(error.toString());
      state = false;
    }
  }
}
