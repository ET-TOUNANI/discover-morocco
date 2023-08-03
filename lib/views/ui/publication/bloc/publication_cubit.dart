import 'package:bloc/bloc.dart';
import 'package:discover_morocco/business_logic/models/authentication/failures/add_failure.dart';
import 'package:discover_morocco/business_logic/models/models/publication.dart';
import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../business_logic/models/models/enums/PubState.dart';
import '../../../../business_logic/services/db_service.dart';

part 'publication_state.dart';

class PublicationCubit extends Cubit<PublicationState> {
  PublicationCubit(
    this.authenticationRepository,
    this.dbService,
  ) : super(const PublicationState(
            title: '', description: '', image: '', video: ''));
  final AuthenticationRepository authenticationRepository;
  final DbService dbService;

  Future<void> createPub() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (state.title == '' || state.image == '' || state.video == '') {
        emit(
          state.copyWith(
            errorMessage: "Please fill all fields before submission.",
            status: FormzStatus.submissionFailure,
          ),
        );
      }

      Publication publication = Publication(
        title: state.title,
        imageUrl: state.image,
        video: state.video,
        state: PubState.pending,
        description: state.description,
        id: const Uuid().v4(),
        user: authenticationRepository.currentUser,
      );
      final res = await dbService.createPub(publication);
      if (res) {
        emit(
          state.copyWith(
            title: '',
            description: '',
            image: '',
            video: '',
            status: FormzStatus.submissionSuccess,
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
    } on AddFailure catch (e) {
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

  void titleChanged(String value) {
    emit(
      state.copyWith(
        title: value,
        status: FormzStatus.valid,
      ),
    );
  }

  void descriptionChanged(String value) {
    emit(
      state.copyWith(
        description: value,
        status: FormzStatus.valid,
      ),
    );
  }

  void imageChanged(String value) {
    emit(
      state.copyWith(
        image: value,
        status: FormzStatus.valid,
      ),
    );
  }

  void videoChanged(String value) {
    emit(
      state.copyWith(
        video: value,
        status: FormzStatus.valid,
      ),
    );
  }
}
