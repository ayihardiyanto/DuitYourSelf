import 'package:duit_yourself/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:duit_yourself/presentation/screens/welcome/welcome_screen.dart';
import 'package:fluro/fluro.dart';
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
  final route = Route();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var routingData = settings.name.getRoutingData;
    switch (routingData.route) {
      case Routes.loginScreen:
        return _getPageRoute(buildLoginScreen(), settings);
      case Routes.signUp:
        return _getPageRoute(buildSignUpScreen(), settings);
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

  static Widget buildSignUpScreen() {
    return SignUpScreen();
  }

  static Widget buildErrorScreen() {
    return ErrorScreen();
  }

  static Widget buildWelcomeScreen() {
    return WelcomeScreen();
  }

  static PageRoute _getPageRoute(Widget child, RouteSettings settings) {
    return Transition(child: child, routeName: settings.name);
  }
}

class Transition extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  // final AnimationTo animationTo;

  Transition({
    this.child,
    this.routeName,
    // this.animationTo,
  }) : super(
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
            ) {
              if (routeName == Routes.signUp) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              } else {
                return FadeTransition(
                  opacity: animation,
                  child: Scaffold(body: child),
                );
              }
            });
}
