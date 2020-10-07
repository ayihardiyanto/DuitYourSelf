import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:duit_yourself/domain/usecases/user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
part 'app_bar_event.dart';
part 'app_bar_state.dart';

@injectable
class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  final UserUsecase userUsecase;

  AppBarBloc({this.userUsecase});

  @override
  AppBarState get initialState => InitialAppBar();

  @override
  Stream<AppBarState> mapEventToState(
    AppBarEvent event,
  ) async* {
    if (event is GetUserData) {
      yield GetDataLoading();
      try {
        final data = await userUsecase.getData();
        final name = jsonDecode(data)['name'];
        final photo = jsonDecode(data)['imageUrl'];
        yield DataLoaded(displayName: name, photo: photo);
      } catch (_) {
        yield DataFailedToLoad();
      }
    }
  }
}
