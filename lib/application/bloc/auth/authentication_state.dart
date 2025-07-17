abstract class AuthenticationState {}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {}

class AuthFailure extends AuthenticationState {
  final String error;

  AuthFailure(this.error);
}
