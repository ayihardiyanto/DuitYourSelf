import 'package:duit_yourself/presentation/screens/login/bloc/login/login_bloc.dart';
import 'package:duit_yourself/presentation/screens/sign_up/sign_up_form.dart';
import 'package:duit_yourself/presentation/screens/sign_up/sign_up_strings.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/custom_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  final LoginBloc loginBloc;

  const SignUpScreen({Key key, @required this.loginBloc}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode emailNode;
  FocusNode passwordNode;
  bool enableButton = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  void validInputChecker(bool isValid) {
    enableButton = isValid;
    print('button enabled : $enableButton');
  }

  void render(Function anything) {
    anything();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.of(context).size.height;
    final windowWidth = MediaQuery.of(context).size.width;
    return BlocConsumer(
        bloc: widget.loginBloc,
        builder: (context, state) {
          return Container(
            height: windowHeight * 0.5,
            child: Stack(
              children: [
                SignUpForm(
                  renderTrigger: render,
                  checkSubmittable: validInputChecker,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: windowWidth,
                    height: windowHeight * 0.1,
                    decoration: BoxDecoration(
                      color: White.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: windowWidth * 0.05,
                          vertical: windowHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Text(
                                  'By clicking Sign Up, you agree to our Terms, and Data Policy.')),
                          Expanded(
                            child: CustomFlatButton(
                                width: windowWidth * 0.4,
                                buttonColor: Blue.darkBlue,
                                buttonTitle: 'Sign Up',
                                onPressed: enableButton
                                    ? () {
                                        widget.loginBloc.add(
                                          OnSubmitSignUp(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                      }
                                    : null),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is SigningUp) {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }
          if (state is SignUpSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    actions: [
                      Container(
                        width: windowWidth * 0.4,
                        height: windowHeight * 0.6,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: windowWidth * 0.03,
                              vertical: windowHeight * 0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                SignUpStrings.signUp,
                                style: PxText.popUpTitle
                                    .copyWith(color: Blue.darkBlue),
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: windowHeight * 0.25,
                                    width: windowWidth * 0.5,
                                    child: Image.asset(
                                      SignUpStrings.successImage,
                                    ),
                                  )),
                              Text(
                                SignUpStrings.successMessage,
                                style: PxText.contentText.copyWith(
                                  color: Black.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  SignUpStrings.regardString,
                                  style: PxText.contentText.copyWith(
                                    color: Black.black,
                                  ),
                                ),
                              ),
                              CustomFlatButton(
                                  buttonTitle: 'Skip',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          }
        });
  }
}
