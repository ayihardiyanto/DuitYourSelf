import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit_yourself/common/routes/routes.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/login/login_bloc.dart';
// import 'package:duit_yourself/presentation/screens/login/login_button.dart';
import 'package:duit_yourself/presentation/screens/login/validator/validator_strings.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class ValidatorScreen extends StatefulWidget {

  @override
  _ValidatorScreen createState() => _ValidatorScreen();

}

class _ValidatorScreen extends State<ValidatorScreen> {
  LoginBloc loginBloc;
  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state){
        if (state.isFailure) {
            print('State is Failure');
          }
        if (state.isSuccess) {
            Navigator.pushNamed(context, Routes.loginScreen);
          }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Dialog(
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7)
            ),
            backgroundColor: Grey.lightGrey,
            child: Container(
              height: 330,
              width: 460,
              padding: EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  // Image.asset(ValidatorStrings.imageValidator, height: 106),
                  SizedBox(height: 5),
                  Text(ValidatorStrings.popUpTitle,
                    style: PxText.popUpTitle
                  ),
                  SizedBox(height: 8),
                  Text(ValidatorStrings.popUpMessage,
                    style: PxText.popUpMessage
                  ),
                  SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      color: White.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(
                        width: 0.8,
                        color: Purple.barneyPurple
                      )
                    ),
                    width: 300,
                    height: 45,
                    child: Container(),
                  ),
                ],
              ),
            )
          );
        }
      ),
    );
  }
}