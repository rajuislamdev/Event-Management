import 'package:event_management/services/admin_service.dart';
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
}
