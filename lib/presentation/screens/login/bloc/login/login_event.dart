part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends LoginEvent {
  final bool isGoogleSignIn;
  final String email;
  final String password;

  LoginWithGooglePressed(
      {@required this.isGoogleSignIn, this.email, this.password});
  @override
  String toString() => 'LoginWithGooglePressed';

  @override
  List<Object> get props => [
        isGoogleSignIn,
        email,
        password,
      ];
}

class SignUp extends LoginEvent {}
