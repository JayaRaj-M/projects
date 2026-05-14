import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static Future<T?> push<T>(String routeName, {Object? arguments}) {
    return navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacement<T>(String routeName, {Object? arguments}) {
    return navigator!.pushReplacementNamed<T, dynamic>(routeName, arguments: arguments);
  }

  static void pop<T>([T? result]) {
    navigator!.pop(result);
  }

  static Future<T?> pushAndClearStack<T>(String routeName, {Object? arguments}) {
    return navigator!.pushNamedAndRemoveUntil<T>(routeName, (route) => false, arguments: arguments);
  }
}