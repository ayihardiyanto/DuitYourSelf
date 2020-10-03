import 'dart:async';
import 'package:duit_yourself/presentation/screens/sign_up/sign_up_dialog.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/custom_flat_button.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/textfield_duit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/authentication/authentication_bloc.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/login/login_bloc.dart';
import 'package:duit_yourself/presentation/screens/login/login_strings.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  LoginBloc loginBloc;
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode emailNode;
  FocusNode passwordNode;
  bool showPass = false;
  bool isFailedLogin = false;

  Timer imageFader;
  int _latestImage = 0;

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    imageFader.cancel();
  }

  List _images = [
    LoginStrings.image1,
    LoginStrings.image3,
    LoginStrings.image4,
    LoginStrings.image2,
  ];

  Widget _calledWidget;

  void _determineWidget(int index) {
    setState(() {
      _calledWidget = Image.asset(
        _images[index],
        key: ValueKey(index),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    });
  }

  void passwordToggler() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _latestImage == 3 ? _latestImage = 0 : _latestImage++;
      imageFader = Timer(Duration(milliseconds: 3000), () {
        if (passwordController.text.isEmpty) {
          _determineWidget(_latestImage);
        }
      });
    });
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LoginFailed) {
          Navigator.pop(context);
          isFailedLogin = true;
        }
        if (state is LoginSuccess) {
          Navigator.pop(context);
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }

        if (state is LoginLoading) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        }

        if (state is ToSignUp) {
          SignUpDialog().showSlideDialog(context: context, loginBloc: loginBloc);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (BuildContext context, LoginState state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: _calledWidget ??
                          FadeInImage(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            placeholder: AssetImage(
                              _images[0],
                            ),
                            image: AssetImage(
                              _images[0],
                            ),
                          ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black26,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2,
                    left: MediaQuery.of(context).size.width / 8,
                    child: Column(
                      children: [
                        Text(
                          LoginStrings.duitYourSelf,
                          style: PxText.popUpTitle
                              .copyWith(color: Yellow.sunYellow, fontSize: 36),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 450,
                          child: Text(
                            LoginStrings.contentText,
                            style: PxText.contentText.copyWith(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.black87,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 40),
                              Text('Login to Your Account',
                                  style: PxText.popUpTitle.copyWith(
                                      color: Yellow.sunYellow, fontSize: 20)),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                // width: 213,
                                height: 38,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Don\'t have an account?',
                                        style: PxText.contentText,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          loginBloc.add(SignUp());
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            ' Sign Up for Free!',
                                            style: PxText.contentText.copyWith(
                                                color: Blue.lightBlue),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                              TextFieldDuit(
                                hintText: 'Email',
                                controller: emailController,
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Grey.brownGrey,
                                ),
                              ),
                              TextFieldDuit(
                                hintText: 'Password',
                                controller: passwordController,
                                obscureText: !showPass,
                                suffixIcon: passwordController.text.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(showPass
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        color: Grey.brownGrey,
                                        onPressed: () {
                                          passwordToggler();
                                        },
                                      )
                                    : null,
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Grey.brownGrey,
                                ),
                              ),
                              if (isFailedLogin)
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(
                                      'Username/password may not be correct, please try again!',
                                      style: TextStyle(color: Red.blush),
                                    ),
                                  ),
                                ),
                              CustomFlatButton(
                                  buttonTitle: 'Sign In',
                                  buttonColor: Blue.darkBlue,
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginWithGooglePressed(
                                          isGoogleSignIn: false,
                                          email: emailController.text,
                                          password: passwordController.text),
                                    );
                                  }),
                              CustomFlatButton(
                                marginTop: 10,
                                leadingIcon: Image.asset(
                                  LoginStrings.google,
                                  height: 15,
                                  width: 15,
                                ),
                                buttonColor: White.white,
                                titleColor: Blue.darkBlue,
                                buttonTitle: 'Sign in With Google',
                                buttonStyle: CustomButtonStyle.STYLE_TWO,
                                onPressed: () {
                                  loginBloc.add(
                                    LoginWithGooglePressed(
                                        isGoogleSignIn: true),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
