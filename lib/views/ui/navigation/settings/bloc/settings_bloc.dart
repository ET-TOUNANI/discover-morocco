import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/enums/status.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/user.dart';
import 'package:discover_morocco/business_logic/models/models/enums/brightness.dart';
import 'package:discover_morocco/business_logic/services/Auth_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String prefKey = 'PREF_KEY_SETTINGS';

  SettingsBloc({
    required this.authenticationRepository,
    required this.sharedPreferences,
  }) : super(
          sharedPreferences.containsKey(prefKey)
              ? SettingsState.fromJson(
                  jsonDecode(
                    sharedPreferences.getString(prefKey)!,
                  ),
                )
              : const SettingsState(),
        ) {
    on<_AppUserChanged>(_changeUser);
    on<AppLogoutRequested>(_logout);
    on<AppLocalChanged>(_changeLocal);
    on<AppBrightnessChanged>(_changeBrightness);

    authenticationRepository.user.listen((user) => add(_AppUserChanged(user)));

    if (authenticationRepository.currentUser != state.user) {
      add(_AppUserChanged(authenticationRepository.currentUser));
    }
  }

  final SharedPreferences sharedPreferences;
  final AuthenticationRepository authenticationRepository;
  late final StreamSubscription<UserModel> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _changeLocal(
    AppLocalChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final newState = state.copyWith();
    await sharedPreferences.setString(prefKey, jsonEncode(newState.toJson()));
    emit(newState);
  }

  FutureOr<void> _changeBrightness(
    AppBrightnessChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final newState = state.copyWith(brightness: event.brightness);
    await sharedPreferences.setString(prefKey, jsonEncode(newState.toJson()));
    emit(newState);
  }

  FutureOr<void> _logout(
    AppLogoutRequested event,
    Emitter<SettingsState> emit,
  ) async {
    final newState = state.copyWith(
      user: UserModel.empty,
      authStatus: AuthenticationStatus.unauthenticated,
    );
    await sharedPreferences.setString(prefKey, jsonEncode(newState.toJson()));

    unawaited(authenticationRepository.logOut());

    emit(newState);
  }

  FutureOr<void> _changeUser(
    _AppUserChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final newState = state.copyWith(
      user: event.user,
      authStatus: event.user.isEmpty
          ? AuthenticationStatus.unauthenticated
          : AuthenticationStatus.authenticated,
    );

    await sharedPreferences.setString(prefKey, jsonEncode(newState.toJson()));

    emit(newState);
  }
}
