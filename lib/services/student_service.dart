import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/models/student.dart';
import 'package:event_management/screens/common/login_screen.dart';
import 'package:event_management/services/hive_service.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentService {
  final Ref ref;
  StudentService(this.ref);

  final CollectionReference studentCollectionRef =
      FirebaseFirestore.instance.collection('student');

  Future<bool> isUtmidUnique({required String utmid}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('student')
              .where('utmid', isEqualTo: utmid)
              .get();
      return querySnapshot.docs.isEmpty;
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

  Future<bool> registration({
    required Student student,
    required String password,
  }) async {
    try {
      final studentData = <String, dynamic>{
        ...student.toMap(),
        'password': password,
      };
      final bool isUnique = await isUtmidUnique(utmid: student.utmid);
      if (isUnique) {
        await studentCollectionRef.add(studentData);
        return true;
      } else {
        GlobalFunction.showCustomSnackbar(
          message: 'Already have an account with this utmid.',
          isSuccess: false,
        );
        return false;
      }
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
      final exists = await checkAccountExist(utmid: utmid);
      if (exists) {
        final userData = await getUserData(utmid: utmid);
        final storePassword = userData['password'];
        final docId = userData['id'];
        if (password == storePassword) {
          ref
              .read(hiveServiceProvider)
              .setUserInfo(id: docId, accountType: AccountType.student.name);
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
}

final studentServiceProvider = StateProvider((ref) => StudentService(ref));
