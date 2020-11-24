import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:duit_yourself/domain/usecases/user_usecase.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserUsecase userUsecase;

  LoginBloc(this.userUsecase);

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState(
          event.isGoogleSignIn, event.email, event.password);
    }
    if (event is SignUp) {
      try {
        yield ToSignUp();
      } catch (_) {}
    }

    if (event is OnSubmitSignUp) {
      yield SigningUp();
      try {
        print(event.email);
        print(event.password);
        final result = await userUsecase.signUp(
            email: event.email, password: event.password);

        if (result == '201') {
          print('SIGN SUCCESS');
          yield SignUpSuccess();
        }
      } catch (e) {
        print('SIGN UP ERROR' + e);
      }
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState(
      bool isGoogleSignIn, String email, String password) async* {
    yield LoginLoading();
    try {
      await userUsecase.signOut();
      await userUsecase.signIn(
          isGoogle: isGoogleSignIn, email: email, password: password);
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailed(isGoogle: isGoogleSignIn);
    }
  }
}
