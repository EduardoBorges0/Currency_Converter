abstract class AuthenticationEvent {}

class RegisterUserEvent extends AuthenticationEvent {
  final String email;
  final String password;

  RegisterUserEvent({required this.email, required this.password});
}

class LoginUserEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});
}