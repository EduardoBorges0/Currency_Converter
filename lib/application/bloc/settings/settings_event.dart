abstract class SettingsEvent {}

class LogoutEvent extends SettingsEvent {}

class RemoveAccountEvent extends SettingsEvent {
  final String email;
  final String password;

  RemoveAccountEvent({required this.email, required this.password});
}
