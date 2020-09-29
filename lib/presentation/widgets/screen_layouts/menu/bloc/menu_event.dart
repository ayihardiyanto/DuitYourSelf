part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class RolesStatus extends MenuEvent {
  final String role;
  const RolesStatus({@required this.role});
  @override
  List<Object> get props => [role];
}
