import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/formz/email.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/formz/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../business_logic/services/Auth_service.dart';
import '../../../../../business_logic/services/user_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.userService, this.authenticationRepository,
  ) : super(  ProfileState(
      email:Email.dirty( authenticationRepository.currentUser.email??''),
      name: authenticationRepository.currentUser.name??'',
      phone:  authenticationRepository.currentUser.phone??'',
      photo: authenticationRepository.currentUser.photo??'',
  ));
  final UserService userService;
  final AuthenticationRepository authenticationRepository;


  Future<void> editProfile() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      UserModel user= UserModel(
          id: authenticationRepository.currentUser.id,
          isAnonymous:  authenticationRepository.currentUser.isAnonymous,
          emailVerified:  authenticationRepository.currentUser.emailVerified,
        email:state.email.value,
        name: state.name,
        photo:state.photo,
        fcmToken: authenticationRepository.currentUser.fcmToken,
      );
      final res =await userService.updateUser(user);
      if (res) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: "An unknown exception occurred.",
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }  catch (e) {
      emit(state.copyWith(errorMessage: e.toString(),status: FormzStatus.submissionFailure));
    }
  }


  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email, status: Formz.validate([email, state.password]),
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
