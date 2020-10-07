part of 'login_bloc.dart';

@immutable
class LoginState {
  const LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSuccess,
    @required this.isFailure,
    this.errorMessage = '',
  });

  factory LoginState.empty() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure(String errorMessage) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.success() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSuccess: true,
      isFailure: false,
    );
  }

  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorMessage: $errorMessage,
    }''';
  }
}

class LoginFailed extends LoginState {
  final bool isGoogle;

  LoginFailed({this.isGoogle});

}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class ToSignUp extends LoginState {}

class SignUpSuccess extends LoginState {}

class SigningUp extends LoginState {}
