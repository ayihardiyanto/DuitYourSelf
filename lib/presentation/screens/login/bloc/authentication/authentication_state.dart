part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState(this.displayName, this.photo, this.role);
  final String displayName;
  final String photo;
  final String role;

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  const Uninitialized() : super('', '', '');

@override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  const Authenticated(displayName, photo, role) : super(displayName, photo, role);

  @override
  String toString() => 'Authenticated { displayName: $displayName , photo: $photo , role: $role}';
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated() : super('','','');

  @override
  String toString() => 'Unauthenticated';
}

class Unauthorized extends AuthenticationState {
  const Unauthorized() : super('','','');

  @override
  String toString() => 'Unauthorized';
}