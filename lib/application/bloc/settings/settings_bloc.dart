import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/network/firebase/save_favorite_coin_firestore.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LogoutEvent>(_onLogout);
    on<RemoveAccountEvent>(_onRemoveAccount);
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(SettingsSuccess());
    } catch (e) {
      emit(SettingsFailure("Erro ao fazer logout"));
    }
  }

  Future<void> _onRemoveAccount(RemoveAccountEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        emit(SettingsFailure("Usuário não autenticado."));
        return;
      }

      // Reautenticar antes de deletar
      final credential = EmailAuthProvider.credential(
        email: event.email,
        password: event.password,
      );

      await user.reauthenticateWithCredential(credential);
      await user.delete();
      deleteUserDocument(user.uid);

      emit(SettingsSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        emit(SettingsFailure("Senha incorreta."));
      } else if (e.code == 'requires-recent-login') {
        emit(SettingsFailure("Reautenticação necessária."));
      } else {
        emit(SettingsFailure("Erro: ${e.message}"));
      }
    } catch (e) {
      emit(SettingsFailure("Erro inesperado ao remover conta."));
    }
  }
}
