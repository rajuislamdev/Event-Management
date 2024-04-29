import 'package:event_management/routes.dart';
import 'package:event_management/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    Future.wait([ref.read(hiveServiceProvider).getUserInfo()]).then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        if (value.first != null) {
          if (value.first!['accountType'] == 'admin') {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.adminEventPage, (routes) => false);
          } else if (value.first!['accountType'] == 'student') {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.studentDashboard, (route) => false);
          }
        } else {
          Navigator.of(context).pushNamed(Routes.loginScreen);
        }
      });
    });
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
        child: const Text(
          'UTMBuzz',
          style: TextStyle(fontSize: 24.0), // Change the style as needed
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
