import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageController = StateProvider<int>((ref) => 0);
final isOnboardingLastPage = StateProvider<bool>((ref) => false);
final selectedAccountType = StateProvider<String>((ref) => 'student');
final selectedFaculty = StateProvider<String?>((ref) => null);
final selectedProgram = StateProvider<String?>((ref) => null);
final selectedSemester = StateProvider<String?>((ref) => null);
// final deviceId 
