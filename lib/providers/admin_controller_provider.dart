import 'package:event_management/controllers/admin_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminControllerProvider =
    StateNotifierProvider<AdminController, bool>((ref) => AdminController(ref));
