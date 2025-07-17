import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/authentication_repositories.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositories authRepository;

  AuthenticationBloc(this.authRepository) : super(AuthInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        bool register = await authRepository.registerUser(
          email: event.email,
          password: event.password,
        );
        if(register){
          emit(AuthSuccess());
          return;
        }else{
          emit(AuthFailure("Erro ao registrar usuário"));
          return;
        }
      } catch (e) {
        emit(AuthFailure("Erro ao registrar"));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.loginUser(
          email: event.email,
          password: event.password,
        );

        if (user != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure("Usuário ou senha inválidos"));
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Erro ao fazer login"));
      } catch (e) {
        emit(AuthFailure("Erro inesperado ao fazer login"));
      }
    });


  }
}
