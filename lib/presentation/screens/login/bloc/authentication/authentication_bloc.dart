import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:duit_yourself/domain/usecases/user_usecase.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';


@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  
   final UserUsecase _userUsecase;

  AuthenticationBloc(this._userUsecase);

  @override
  AuthenticationState get initialState => Unauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      try {
        final isSignedIn = await _userUsecase.isSignedIn();
        if (isSignedIn) {
          // final getRole = await _userUsecase.getRoles();
          // if (getRole != null) {
          //   final name = await _userUsecase.getUser();
          //   final photo = await _userUsecase.getPhoto();
            yield* _mapLoggedInToState('', '', '');
          // } else {
          //   yield* _mapLoginDeniedToState();
          // }
        } else {
          yield* _mapLoggedOutToState();
        }
      } catch (e) {
        yield* _mapLoginDeniedToState();
      }
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is LoginDenied) {
      yield* _mapLoginDeniedToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final checkUser = await _userUsecase.signInCheck();
      if (checkUser) {
        final getRole = await _userUsecase.getRoles();
        if (getRole == null) {
          yield Unauthorized();
        } else {
          final name = await _userUsecase.getUser();
          final photo = await _userUsecase.getPhoto();
          yield Authenticated(name, photo, getRole);
        }
      } else {
        yield const Unauthenticated();
      }
    } catch (_) {
      yield const Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(name, role, photo) async* {
    yield Authenticated(name, role, photo);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await  _userUsecase.signOut();
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapLoginDeniedToState() async* {
    await _userUsecase.signOut();
    yield Unauthorized();
  }  
}
