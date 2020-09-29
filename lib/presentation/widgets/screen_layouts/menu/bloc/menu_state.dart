part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Menu> menurole;
  const MenuLoaded({@required this.menurole});
  MenuLoaded copyWith({Menu menurole}) {
    return MenuLoaded(menurole: menurole ?? this.menurole);
  }

  @override
  List<Object> get props => [menurole];
  @override
  String toString() => 'MenuStatusLoaded {menurole: $menurole }';
}

class MenuError extends MenuState {}
