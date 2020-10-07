


part of 'app_bar_bloc.dart';


abstract class AppBarEvent extends Equatable{
  const AppBarEvent();
}

class GetUserData extends AppBarEvent {
  @override
  String toString() => 'GetUserData';

  @override
  List<Object> get props => [];
}