import 'package:duit_yourself/presentation/screens/login/bloc/login/login_bloc.dart';
import 'package:duit_yourself/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/widgets/slide_up_dialog/slide_popup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpDialog {
  void showSlideDialog({BuildContext context, LoginBloc loginBloc}) {
    final windowHeight = MediaQuery.of(context).size.height;
    final winddowWidth = MediaQuery.of(context).size.width;
    customSlideDialog(
      context: context,
      paddingTop: windowHeight * 0.45,
      width: winddowWidth - winddowWidth * 0.6,
      backgroundColor: White.smokeWhite,
      pillColor: Black.lightBlack,
      child: BlocProvider(
          create: (_) => BlocProvider.of<LoginBloc>(context),
          child: SignUpScreen(
            loginBloc: loginBloc,
          )),
    );
  }
}
