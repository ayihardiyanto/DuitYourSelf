part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class ProfileLoaded extends DashboardState {
  @override
  String toString() => '';
}

class InitialDashboard extends DashboardState {}

class ProfileLoading extends DashboardState {}

class ProfileFailed extends DashboardState {}

class ToHome extends DashboardState {}
class ProfileSaved extends DashboardState {}
class SavingProfile extends DashboardState {}
class ToPostJobScreen extends DashboardState{}


