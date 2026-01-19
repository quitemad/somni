import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationUtil {
  static void goTo(BuildContext context, String route) {
    context.go(route);
  }

  static void pushTo(BuildContext context, String route) {
    context.push(route);
  }

  static void replace(BuildContext context, String route) {
    context.go(route);
  }
}
