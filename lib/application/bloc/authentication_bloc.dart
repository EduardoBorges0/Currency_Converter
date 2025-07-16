import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/authentication_repositories.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositories authRepository;

  AuthenticationBloc(this.authRepository) : super(AuthInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.registerUser(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure("Erro ao registrar"));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.loginUser(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure("Erro ao fazer login"));
      }
    });
  }
}
