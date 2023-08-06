part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class AppLocalChanged extends SettingsEvent {
  //final Locals locale;

  const AppLocalChanged();

  @override
  List<Object?> get props => [];
}

class AppBrightnessChanged extends SettingsEvent {
  final MoreBrightness brightness;

  const AppBrightnessChanged(this.brightness);

  @override
  List<Object?> get props => [brightness];
}

class AppLogoutRequested extends SettingsEvent {
  const AppLogoutRequested();
}

class AppUserChanged extends SettingsEvent {
   AppUserChanged(this.user){
   print("AppUserChanged***************");
  }

  final UserModel user;

  @override
  List<Object?> get props => [user];
}
