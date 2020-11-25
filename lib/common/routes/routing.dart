import 'package:duit_yourself/common/config/injector.dart';
import 'package:duit_yourself/common/errors/error_screen.dart';
import 'package:duit_yourself/common/routes/routes.dart';
import 'package:duit_yourself/presentation/screens/dashboard/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/dashboard.dart';
// import 'package:duit_yourself/presentation/screens/dashboard/profile_edit.dart';
import 'package:duit_yourself/presentation/screens/login/authentication.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/authentication/authentication_bloc.dart';
import 'package:duit_yourself/presentation/screens/welcome/welcome_screen.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static fluro.Router router = fluro.Router();

  static void setupRouter() {
    router.define(Routes.loginScreen, handler: buildLoginScreen);
    router.define(Routes.errorScreen, handler: buildErrorScreen);
    router.define(Routes.welcomeScreen,
        handler: buildWelcomeScreen,
        transitionType: fluro.TransitionType.inFromBottom);

    router.define('${Routes.dashboard}/:displayName/:imageUrl',
        handler: buildDashboard, transitionType: fluro.TransitionType.fadeIn);

    // router.define('${Routes.profileEdit}/:username/:imageUrl/:dashboardKey',
    //     handler: buildProfileEdit, transitionType: fluro.TransitionType.fadeIn);
  }

  static fluro.Handler buildLoginScreen = fluro.Handler(
    handlerFunc: (context, parameters) => BlocProvider(
      create: (BuildContext context) => getIt<AuthenticationBloc>(),
      child: Authentications(),
    ),
  );

  static fluro.Handler buildErrorScreen =
      fluro.Handler(handlerFunc: (context, parameters) => ErrorScreen());

  static fluro.Handler buildWelcomeScreen =
      fluro.Handler(handlerFunc: (context, parameters) => WelcomeScreen());

  static fluro.Handler buildDashboard =
      fluro.Handler(handlerFunc: (context, parameters) {
    final name = parameters['displayName'][0];
    final imageUrl = parameters['imageUrl'][0];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AppBarBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DashboardBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>(),
        )
      ],
      child: Dashboard(
        imageUrl: imageUrl,
        username: name,
        isInitialUser: imageUrl.trim().isEmpty,
      ),
    );
  });

  // static fluro.Handler buildProfileEdit =
  //     fluro.Handler(handlerFunc: (context, parameters) {
  //   final name = parameters['displayName'][0];
  //   final image = parameters['imageUrl'][0];
  //   final appBarKey = parameters['appBarKey'][0];
  //   return ProfileEdit(
  //     image: imageUrl,
  //     username: name,
  //     key: appBarKey as Key,
  //   );
  // });
}
