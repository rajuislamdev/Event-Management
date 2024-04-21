import 'package:event_management/models/admin.dart';
import 'package:event_management/services/admin_service.dart';
import 'package:event_management/services/hive_service.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminController extends StateNotifier<bool> {
  final Ref ref;
  AdminController(this.ref) : super(false);

  Future<bool> login({
    required String utmid,
    required String password,
  }) async {
    try {
      state = true;
      final isSuccess = await ref
          .read(adminServiceProvider)
          .login(utmid: utmid, password: password);
      state = false;
      return isSuccess;
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return false;
    }
  }

  Future<Admin?> getAdmin() async {
    try {
      state = true;
      final docId = ref.read(hiveServiceProvider).getUserId();

      final adminInfo = await ref.read(adminServiceProvider).getAdmin(docId!);
      debugPrint(adminInfo.toJson());
      state = false;
      return adminInfo;
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return null;
    }
  }

  Future<void> updateAdminInfo({required Admin admin}) async {
    try {
      state = true;
      final adminId = await ref.read(hiveServiceProvider).getUserInfo();

      await ref
          .read(adminServiceProvider)
          .updateAdminInfo(documentId: adminId!['id'], updatedData: admin);
      GlobalFunction.showCustomSnackbar(
          message: 'Admin information has been successfully updated',
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
