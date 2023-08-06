import 'dart:async';
import 'dart:convert';

import 'package:discover_morocco/business_logic/models/authentication/models/enums/status.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/user.dart';
import 'package:discover_morocco/business_logic/models/models/enums/brightness.dart';
import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../business_logic/services/user_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String prefKey = 'PREF_KEY_SETTINGS';

  SettingsBloc(this.userService, {
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
  final UserService userService;

  @override
  Future<void> close() {
    //_userSubscription.cancel();
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
    // Fetch the full user data from Firestore using the userService
    UserModel? updatedUser = await userService.getUserById(event.user.id);

    if (updatedUser != null) {
      // Merge the additional attributes from Firestore into the current user object

      final newState = state.copyWith(
        user: updatedUser,
        authStatus: updatedUser.isEmpty
            ? AuthenticationStatus.unauthenticated
            : AuthenticationStatus.authenticated,
      );

      await sharedPreferences.setString(prefKey, jsonEncode(newState.toJson()));
      emit(newState);
    }
  }

}
