import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_constants.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/firebase_options.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Enable offline persistence for iOS and Android
  firestore.settings = const Settings(persistenceEnabled: true);
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.appSettingsBox);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // XD Design Sizes
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: false,
      builder: (context, child) {
        GlobalFunction.changeStatusBarTheme(isDark: false);

        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.offWhite,
            appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(color: AppColor.white),
              backgroundColor: AppColor.purple,
              titleTextStyle: AppTextStyle(context).appBarText,
            ),
          ),
          title: 'Event Managment',
          onGenerateRoute: generatedRoutes,
          initialRoute: Routes.splash,
        );
      },
    );
  }
}
