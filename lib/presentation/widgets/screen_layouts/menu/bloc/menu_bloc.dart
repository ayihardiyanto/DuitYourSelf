import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:duit_yourself/common/models/menu.dart';
import 'package:meta/meta.dart';
part 'menu_event.dart';
part 'menu_state.dart';

@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final Menu getMenuRolesUsecase;
  MenuBloc({@required this.getMenuRolesUsecase});
  @override
  MenuState get initialState => MenuInitial();
  @override
  Stream<MenuState> transformEvents(
    Stream<MenuEvent> events,
    Stream<MenuState> Function(MenuEvent event) next,
  ) {
    return super.transformEvents(
      events.timeout(
        Duration(milliseconds: 1500),
      ),
      next,
    );
  }

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is RolesStatus) {
      yield MenuLoading();
      try {
        if (event.role.toLowerCase() == 'hrOps') {
          final menu = menuItemsRecruiter;
          yield MenuLoaded(menurole: menu);
        } else {
          final menu = menuItemsHrops;
          yield MenuLoaded(menurole: menu);
        }
      } catch (_) {
        yield MenuError();
      }
    }
  }
}