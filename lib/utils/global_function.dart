import 'package:event_management/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
      backgroundColor: isSuccess ? AppColor.purple : AppColor.red,
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

  static Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    return picked;
  }

  static Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }

  static String formateDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MM-yyyy').format(date);
    }
    return '';
  }

  static String? formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay != null) {
      final hour = timeOfDay.hourOfPeriod;
      final minute = timeOfDay.minute.toString().padLeft(2, '0');
      final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }
    return null;
  }
}
