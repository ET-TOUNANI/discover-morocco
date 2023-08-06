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
      name: userModel.name??'',
      phone:  userModel.phone??'',
      photo: userModel.photo??'',
  ));
  final UserService userService;
  final AuthenticationRepository authenticationRepository;


  Future<void> editProfile() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      UserModel user= UserModel(
          id: userModel.id,
          isAnonymous:  userModel.isAnonymous,
          emailVerified:  userModel.emailVerified,
        name: state.name,
        email: userModel.email,
        photo:state.photo,
        phone: state.phone,
        fcmToken: userModel.fcmToken,
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
