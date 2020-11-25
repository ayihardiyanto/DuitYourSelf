part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class OpenProfile extends DashboardEvent {
  final String name;
  final Widget image;

  OpenProfile({this.name, this.image});
  @override
  String toString() => 'OpenProfile';

  @override
  List<Object> get props => [];
}

class Home extends DashboardEvent {
  Home();
  @override
  String toString() => 'Home';

  @override
  List<Object> get props => [];
}

class SaveProfile extends DashboardEvent {
  final String username;
  final String selfDescription;
  final dynamic profile;
  final String headline;
  SaveProfile({this.username, this.selfDescription, this.profile, this.headline});
  @override
  String toString() => 'SaveProfile';

  @override
  List<Object> get props => [username, selfDescription, profile, headline];
}

class OnPostJobTapped extends DashboardEvent {
  @override
  String toString() => 'PostJob';

  @override
  List<Object> get props => [];
}


