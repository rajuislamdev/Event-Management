import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageController = StateProvider<int>((ref) => 0);
final isOnboardingLastPage = StateProvider<bool>((ref) => false);
final selectedAccountType = StateProvider<String>((ref) => 'student');
final selectedCategory = StateProvider<String>((ref) => 'All');
