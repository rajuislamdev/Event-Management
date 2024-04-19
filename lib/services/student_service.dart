import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/models/student.dart';
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
}

final studentServiceProvider = StateProvider((ref) => StudentService(ref));
