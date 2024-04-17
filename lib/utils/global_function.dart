import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static InputDecoration buildInputDecoration(
      BuildContext context, String hint, Widget? suffixIcon) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16),
      alignLabelWithHint: true,
      hintText: hint,
      hintStyle: AppTextStyle(context).bodyText.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColor.lightGray,
          ),
      suffixIcon: suffixIcon,
      floatingLabelStyle: AppTextStyle(context).bodyText.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColor.purple,
          ),
      filled: true,
      fillColor: AppColor.white,
      errorStyle: AppTextStyle(context).bodyTextSmall.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColor.red,
          ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColor.lightGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColor.offWhite, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColor.purple, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColor.red,
        ),
      ),
    );
  }
}
