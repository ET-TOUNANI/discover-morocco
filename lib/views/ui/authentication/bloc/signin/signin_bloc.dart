import 'package:discover_morocco/business_logic/models/authentication/failures/failures.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/enums/signin_method.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/formz/email.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/formz/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../business_logic/services/push_notification_service.dart';
import '../../../../../business_logic/services/user_service.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this.authenticationRepository,
    this.userService,
  ) : super(const SignInState());

  final AuthenticationRepository authenticationRepository;
  final UserService userService;

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

  Future<void> signInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final methods = await authenticationRepository.fetchSignInMethodsForEmail(
      email: state.email.value,
    );
    if (methods.isEmpty) {
      // not registered
      try {
        await authenticationRepository.signUp(
            email: state.email.value, password: state.password.value);
      } on SignInFailure catch (e) {
        emit(
          state.copyWith(
            errorMessage: e.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    } else if (!methods.contains(SignInMethod.password)) {
      emit(
        state.copyWith(
          errorMessage: 'Login with credentials is not allowed for this email.',
          status: FormzStatus.submissionFailure,
        ),
      );
      return;
    }

    try {
      await authenticationRepository.signInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      String token="";
      await firebaseMessaging.getToken().then((tkn) {
        token=tkn??"";

        // Save the token to your server/database to send targeted notifications.
      });
      UserModel user=UserModel(
          id: authenticationRepository.currentUser.id,
          photo:  authenticationRepository.currentUser.photo,
          name:  authenticationRepository.currentUser.name,
          fcmToken: token,
          email:  authenticationRepository.currentUser.email,
          emailVerified: authenticationRepository.currentUser.emailVerified ,
          isAnonymous:  authenticationRepository.currentUser.isAnonymous
      );
      await userService.createUser(user);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> signInAnonymously() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.signInAnonymously();
      String token="";
      await firebaseMessaging.getToken().then((tkn) {
        token=tkn??"";

        // Save the token to your server/database to send targeted notifications.
      });
      UserModel user=UserModel(
          id: authenticationRepository.currentUser.id,
          photo:  authenticationRepository.currentUser.photo,
          name:  authenticationRepository.currentUser.name,
          fcmToken: token,
          email:  authenticationRepository.currentUser.email,
          emailVerified: authenticationRepository.currentUser.emailVerified ,
          isAnonymous:  authenticationRepository.currentUser.isAnonymous
      );
      await userService.createUser(user);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          anonymously: true,
        ),
      );
    } on SignInAnonymouslyFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.signInWithGoogle();
      String token="";
      await firebaseMessaging.getToken().then((tkn) {
        token=tkn??"";

        // Save the token to your server/database to send targeted notifications.
      });
      UserModel user=UserModel(
          id: authenticationRepository.currentUser.id,
          photo:  authenticationRepository.currentUser.photo,
          name:  authenticationRepository.currentUser.name,
          fcmToken: token,
          email:  authenticationRepository.currentUser.email,
          emailVerified: authenticationRepository.currentUser.emailVerified ,
          isAnonymous:  authenticationRepository.currentUser.isAnonymous
      );
      await userService.createUser(user);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
