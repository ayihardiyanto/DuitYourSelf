import 'package:flutter/material.dart';
import 'package:duit_yourself/common/routes/routes.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String routeName;
  Map queryParams;

  Future<dynamic> navigateTo(
    routeName, {
    queryParams,
  }) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    if (routeName == Routes.homeScreen) {
      return navigatorKey.currentState
          .pushNamedAndRemoveUntil(routeName, ModalRoute.withName('/'));
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }
  
  Future<dynamic> popAndPushNamed(
    routeName, {
    queryParams,
  }) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.popAndPushNamed(routeName);
  }

  
  Future<dynamic> pushReplaceNamed(
    routeName, {
    queryParams,
  }) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  void pop({dynamic argument}) {
    return navigatorKey.currentState.pop(argument);
  }
}
