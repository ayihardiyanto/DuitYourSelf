import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit_yourself/common/config/injector.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/login/login_bloc.dart';
import 'package:duit_yourself/presentation/screens/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<LoginBloc>(
        create: (BuildContext context) => getIt<LoginBloc>(),
        child: LoginForm(),
      ),
    );
  }
}
