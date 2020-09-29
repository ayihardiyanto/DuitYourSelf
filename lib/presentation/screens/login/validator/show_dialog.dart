import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit_yourself/common/config/injector.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/login/login_bloc.dart';
import 'package:duit_yourself/presentation/screens/login/validator/validator_screen.dart';

Future<Future> showDialogAlert(BuildContext context) async => showDialog(
    context: context,
    barrierDismissible: false,
    child: BlocProvider<LoginBloc>(
      create:  (BuildContext context) => getIt<LoginBloc>(),
      child: ValidatorScreen()
    )
  );

