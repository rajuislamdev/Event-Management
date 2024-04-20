import 'package:event_management/models/event.dart';
import 'package:event_management/screens/admin/add_event_page.dart';
import 'package:event_management/screens/admin/event_page.dart';
import 'package:event_management/screens/common/login_screen.dart';
import 'package:event_management/screens/common/splash_screen.dart';
import 'package:event_management/screens/student/registration.dart';
import 'package:event_management/screens/student/student_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  Routes._();
  static const splash = '/';
  static const loginScreen = '/loginScreen';
  static const studentRegistration = '/studentRegistration';
  static const studentDashboard = '/studentDashboard';
  static const adminEventPage = '/adminEventPage';
  static const addEventPage = '/addEventPage';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    //core
    case Routes.splash:
      child = const SplashScreen();
      break;
    case Routes.loginScreen:
      child = const LoginScreen();
    case Routes.adminEventPage:
      child = const AdminEventPage();
    case Routes.addEventPage:
      final EventModel? event = settings.arguments as EventModel?;
      child = AddEventScreen(
        event: event,
      );
    case Routes.studentDashboard:
      child = const StudentDashboard();
    case Routes.studentRegistration:
      child = const Registration();
    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  debugPrint('Route: ${settings.name}');

  return PageTransition(
    child: child,
    type: PageTransitionType.theme,
    settings: settings,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 300),
  );
}
