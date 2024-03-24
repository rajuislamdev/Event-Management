import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.forward();
      });
      Future.delayed(const Duration(seconds: 3), () {
        context.nav.pushNamed(Routes.loginScreen);
      });

      return () {};
    }, []);
    return Scaffold(body: _buildBody(context, controller));
  }

  Widget _buildBody(BuildContext context, AnimationController controller) {
    return Center(
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
        child: Text(
          'Event Management UTM',
          style: AppTextStyle(context).title,
        ),
      ),
    );
  }
}
