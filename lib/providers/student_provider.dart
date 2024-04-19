import 'package:event_management/controllers/student_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentProvider = StateNotifierProvider<StudentController, bool>(
    (ref) => StudentController(ref));
