import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentService {
  final Ref ref;
  StudentService(this.ref);

  final CollectionReference studentCollectionRef =
      FirebaseFirestore.instance.collection('student');
}
