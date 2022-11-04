import 'package:dcd_restaurant_app/models/restaurant.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Restaurant arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments.id);
  }

  static back() => navigatorKey.currentState?.pop();
}
