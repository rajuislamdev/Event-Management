import 'package:event_management/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalFunction {
  static void changeStatusBarTheme({required isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
    bool isTop = false,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      dismissDirection:
          isTop ? DismissDirection.startToEnd : DismissDirection.startToEnd,
      backgroundColor: isSuccess ? AppColor.blueChalk : AppColor.red,
      content: Text(message),
      margin: isTop
          ? EdgeInsets.only(
              bottom: MediaQuery.of(navigatorKey.currentState!.context)
                      .size
                      .height -
                  100,
              right: 20,
              left:
                  MediaQuery.of(navigatorKey.currentState!.context).size.width -
                      300,
            )
          : null,
    );
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      snackBar,
    );
  }
}
