import 'package:event_management/controllers/todo_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoControllerProvider =
    StateNotifierProvider<TodoController, bool>((ref) => TodoController(ref));
