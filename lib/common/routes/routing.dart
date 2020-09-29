import 'package:duit_yourself/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit_yourself/common/config/injector.dart';
import 'package:duit_yourself/common/errors/error_screen.dart';
import '../../presentation/screens/login/bloc/authentication/authentication_bloc.dart';
import '../../presentation/screens/login/authentication.dart';
import 'routes.dart';
import '../extension/string_extension.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var routingData = settings.name.getRoutingData;
    switch (routingData.route) {
      case Routes.loginScreen:
        return _getPageRoute(buildLoginScreen(), settings);
      case Routes.homeScreen:
        return _getPageRoute(buildWelcomeScreen(), settings);

      default:
        return MaterialPageRoute(builder: (_) => buildErrorScreen());
    }
  }

  static Widget buildLoginScreen() {
    return BlocProvider(
        create: (BuildContext context) => getIt<AuthenticationBloc>(),
        child: Authentications());
  }

  static Widget buildErrorScreen() {
    return ErrorScreen();
  }

  static Widget buildWelcomeScreen() {
    return WelcomeScreen();
  }

  static PageRoute _getPageRoute(Widget child, RouteSettings settings) {
    return FadeRoute(child: child, routeName: settings.name);
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  FadeRoute({this.child, this.routeName})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          settings: RouteSettings(name: routeName),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: Scaffold(body: child),
          ),
        );
}
