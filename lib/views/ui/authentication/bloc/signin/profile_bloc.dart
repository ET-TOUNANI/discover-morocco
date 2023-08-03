import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/formz/email.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/formz/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.authenticationRepository,
  ) : super(ProfileState(
            email:
                Email.dirty(authenticationRepository.currentUser.email ?? ''),
            name: authenticationRepository.currentUser.name ?? '',
            photo: authenticationRepository.currentUser.photo ??
                'assets/mock/profile.png'));

  final AuthenticationRepository authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  void nameChanged(String value) {
    emit(
      state.copyWith(
        name: value,
        status: Formz.validate([state.email, state.password]),
      ),
    );
  }

  void phoneChanged(String value) {
    emit(
      state.copyWith(
        phone: value,
        status: Formz.validate([state.email, state.password]),
      ),
    );
  }

  void photoChanged(String value) {
    emit(
      state.copyWith(
        photo: value,
        status: Formz.validate([state.email, state.password]),
      ),
    );
  }
}
