import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/textfield_duit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailNode;
  final FocusNode passwordNode;
  final Function checkSubmittable;
  final Function renderTrigger;

  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  const SignUpForm({
    Key key,
    this.emailController,
    this.passwordController,
    this.emailNode,
    this.passwordNode,
    this.checkSubmittable,
    this.renderTrigger,
  }) : super(key: key);

  static bool validConfPass = false;
  static bool showPass = false;
  static bool showConfPass = false;
  static bool validEmail = false;
  static bool validPass = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print('email : $validEmail, pass: $validPass, confPass: $validConfPass');
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              Text(
                'Sign Up',
                style: PxText.popUpTitle
                    .copyWith(color: Blue.darkBlue, fontSize: 35),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Fill your data',
                style: TextStyle(color: Blue.darkBlue, fontSize: 15),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFieldDuit(
                  labelText: 'Email',
                  hintText: 'Email',
                  focusNode: emailNode,
                  controller: emailController,
                  onChange: (text) {
                    renderTrigger(() {
                      if (!emailRegExp.hasMatch(text) &&
                          emailController.text.isNotEmpty) {
                        validEmail = false;
                      } else {
                        validEmail = true && text.isNotEmpty;
                      }
                      checkSubmittable(
                          validEmail && validPass && validConfPass);
                    });
                  },
                  suffixIcon: Container(
                    width: 10,
                    height: 10,
                  ),
                  autoValidate: true,
                  validator: (text) {
                    if (!emailRegExp.hasMatch(text) &&
                        emailController.text.isNotEmpty) {
                      validEmail = false;
                      return 'incorrect email, must contain @ and dot (.)';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              TextFieldDuit(
                focusNode: passwordNode,
                controller: passwordController,
                obscureText: !showPass,
                labelText: 'Password',
                hintText: 'Password',
                onChange: (text) {
                  renderTrigger(() {
                    if (passwordController.text.length < 8 &&
                        passwordController.text.isNotEmpty) {
                      validPass = false;
                    } else {
                      validPass = text.isNotEmpty;
                    }
                    checkSubmittable(validEmail && validPass && validConfPass);
                  });
                },
                suffixIcon: passwordController.text.isNotEmpty
                    ? IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          showPass ? Icons.visibility_off : Icons.visibility,
                        ),
                        color: Grey.brownGrey,
                        onPressed: () {
                          renderTrigger(() {
                            print(showPass);
                            showPass = !showPass;
                          });
                        },
                      )
                    : Container(
                        width: 10,
                        height: 10,
                      ),
                autoValidate: true,
                validator: (text) {
                  if (passwordController.text.length < 8 &&
                      passwordController.text.isNotEmpty) {
                    validPass = false;
                    return 'Password length must be at least 8 characters';
                  } else {
                    return null;
                  }
                },
              ),
              TextFieldDuit(
                labelText: 'Confirm Password',
                hintText: 'Confirm Password',
                enabled: passwordController.text.length > 7,
                suffixIcon: IconButton(
                  icon: Icon(
                      showConfPass ? Icons.visibility_off : Icons.visibility),
                  color: Grey.brownGrey,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    renderTrigger(() {
                      showConfPass = !showConfPass;
                    });
                  },
                ),
                obscureText: !showConfPass,
                onChange: (String text) {
                  renderTrigger(() {
                    // confPass = text;
                    if (text.isNotEmpty) {
                      validConfPass =
                          text.isNotEmpty && (text == passwordController.text);
                      checkSubmittable(
                          validEmail && validPass && validConfPass);
                    }
                  });
                },
                autoValidate: true,
                validator: (String text) {
                  if (text.isNotEmpty && text != passwordController.text) {
                    return 'Password doesn\'t match';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
