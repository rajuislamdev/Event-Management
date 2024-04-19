import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/screens/common/login_screen.dart';
import 'package:event_management/services/hive_service.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminService {
  final Ref ref;
  AdminService(this.ref);

  final CollectionReference studentCollectionRef =
      FirebaseFirestore.instance.collection('admin');

  Future<bool> login({
    required String utmid,
    required String password,
  }) async {
    try {
      final exists = await checkAccountExist(utmid: utmid);
      if (exists) {
        final userData = await getUserData(utmid: utmid);
        final storePassword = userData['password'];
        final docId = userData['id'];
        if (password == storePassword) {
          ref
              .read(hiveServiceProvider)
              .setUserInfo(id: docId, accountType: AccountType.admin.name);
          return true;
        } else {
          GlobalFunction.showCustomSnackbar(
            message: 'Incorrect password!',
            isSuccess: false,
          );
          return false;
        }
      } else {
        GlobalFunction.showCustomSnackbar(
          message: 'Account not found!',
          isSuccess: false,
        );
        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  Future<bool> checkAccountExist({required String utmid}) async {
    final querySnapshot = await studentCollectionRef
        .where('utmid', isEqualTo: utmid)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<Map<String, dynamic>> getUserData({required String utmid}) async {
    final querySnapshot = await studentCollectionRef
        .where('utmid', isEqualTo: utmid)
        .limit(1)
        .get();
    final userData = querySnapshot.docs.first.data();
    return {
      'id': querySnapshot.docs.first.id,
      ...userData as Map<String, dynamic>,
    };
  }
}

final adminServiceProvider = StateProvider((ref) => AdminService(ref));
