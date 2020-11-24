import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duit_yourself/common/constants/key_local_storage_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';
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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final LocalStorage storage =
      LocalStorage(KeyLocalStorageConstants.userDetail);

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
          final data = await _userUsecase.getData();

          print('data : $data');
          if (data != null) {
            print('data : $data');
            final name = jsonDecode(data)['name'];
            final photo = jsonDecode(data)['imageUrl'];
            yield* _mapLoggedInToState(name, photo);
          } else {
            final emailFromStorage = storage.getItem('email') as String;
            final transformEmailToName = emailFromStorage.split('@')[0];

            final newUserDataPayload = {
              "email": emailFromStorage,
              "headline": "",
              "imageUrl": "",
              "name": emailFromStorage.split("@")[0],
            };

            firestore
                .collection('user')
                .doc(emailFromStorage)
                .set(newUserDataPayload)
                .then((value) => print("CREATED"))
                .catchError((e) => print("ERROR $e"));

            yield* _mapLoggedInToState(transformEmailToName, '');
          }
        }
      } catch (e) {
        print('error $e');
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
        final getRole = await _userUsecase.getData();
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

  Stream<AuthenticationState> _mapLoggedInToState(name, photo) async* {
    print('name in bloc: $name');
    yield Authenticated(name, '', photo);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await _userUsecase.signOut();
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapLoginDeniedToState() async* {
    await _userUsecase.signOut();
    yield Unauthorized();
  }
}
