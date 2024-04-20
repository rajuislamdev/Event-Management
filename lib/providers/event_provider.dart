import 'package:event_management/controllers/event_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventControllerProvider =
    StateNotifierProvider<EventController, bool>((ref) => EventController(ref));
