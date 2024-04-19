import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';

class ContextLess {
  ContextLess._();

  static NavigatorState get nav {
    return Navigator.of(GlobalFunction.navigatorKey.currentContext!);
  }

  static BuildContext get context {
    return GlobalFunction.navigatorKey.currentContext!;
  }
}

//allows navigation with context.nav
extension EasyNavigator on BuildContext {
  NavigatorState get nav {
    return Navigator.of(this);
  }
}
