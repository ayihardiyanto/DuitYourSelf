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
      yield LoginFailed();
    }
  }
}
