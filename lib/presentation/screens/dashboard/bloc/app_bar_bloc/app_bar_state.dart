part of 'app_bar_bloc.dart';

@immutable
abstract class AppBarState extends Equatable {
  const AppBarState({this.displayName, this.photo});
  final String displayName;
  final String photo;

  @override
  List<Object> get props => [];
}

class DataLoaded extends AppBarState {
  final String displayName;
  final String photo;
  const DataLoaded({this.displayName, this.photo});

  @override
  String toString() => '';
}

class InitialAppBar extends AppBarState {}


class GetDataLoading extends AppBarState {}

class DataFailedToLoad extends AppBarState{}
