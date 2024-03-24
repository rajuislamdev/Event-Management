import 'package:flutter/material.dart';

class GlobalFunction {
  static String errorText(
      {required String fieldName, required BuildContext context}) {
    return '$fieldName is required!';
  }

  static String? commonValidator({
    required String value,
    required String name,
    required BuildContext context,
  }) {
    if (value.isEmpty) {
      return errorText(fieldName: name, context: context);
    }
    return null;
  }
}
