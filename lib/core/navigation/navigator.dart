import 'package:flutter/material.dart';

class AppNavigator {
  static Future<T?> pushSlide<T>({
    required BuildContext context,
    required Widget page,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (_, animation, __) => page,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation =
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              );

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  static Future<T?> pushReplacementSlide<T, TO>({
    required BuildContext context,
    required Widget page,
    TO? result,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (_, animation, __) => page,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation =
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              );

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
      result: result,
    );
  }

  static Future<T?> pushAndRemoveUntilSlide<T>({
    required BuildContext context,
    required Widget page,
    required RoutePredicate predicate,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (_, animation, __) => page,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation =
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              );

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
      predicate,
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
