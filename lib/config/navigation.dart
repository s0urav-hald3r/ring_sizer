import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorKey {
  NavigatorKey._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic>? push(dynamic route) {
    return navigatorKey.currentState?.push(PageTransition(
      child: route,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 500),
    ));
  }

  static Future<dynamic>? pushReplacement(dynamic route) {
    return navigatorKey.currentState?.pushReplacement(PageTransition(
      child: route,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 500),
    ));
  }

  static Future<dynamic>? pushAndRemoveUntil(dynamic route) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
        PageTransition(
          child: route,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
        ),
        (route) => false);
  }

  static bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  static void pop() {
    return navigatorKey.currentState?.pop();
  }
}
