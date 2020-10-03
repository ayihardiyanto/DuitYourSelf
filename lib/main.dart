import 'package:bloc/bloc.dart';
import 'package:duit_yourself/common/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:duit_yourself/common/config/injector.dart';
import 'package:duit_yourself/common/config/locator.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/bloc_delegate/simple_bloc_degate.dart';
import 'app.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlogDelegate();
  // Setup injections & Logger here
  await setupInjections();
  RouteGenerator.setupRouter();
  setupLocator();
  app.main();
}
