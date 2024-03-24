import 'package:event_management/screens/admin/event_page.dart';
import 'package:event_management/screens/common/login_screen.dart';
import 'package:event_management/screens/common/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  Routes._();
  static const splash = '/';
  static const loginScreen = '/loginScreen';
  static const adminEventPage = '/adminEventPage';
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
