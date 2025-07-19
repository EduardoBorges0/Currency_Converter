abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {}

class SettingsFailure extends SettingsState {
  final String error;

  SettingsFailure(this.error);
}