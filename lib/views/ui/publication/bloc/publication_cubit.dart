import 'package:bloc/bloc.dart';
import 'package:discover_morocco/business_logic/models/authentication/failures/add_failure.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/models/models/destination.dart';
import 'package:discover_morocco/business_logic/models/models/publication.dart';
import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:discover_morocco/business_logic/services/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../business_logic/models/models/enums/PubState.dart';
import '../../../../business_logic/services/publication_service.dart';
import '../../../../business_logic/services/push_notification_service.dart';
import '../../../../business_logic/utils/logicConstants.dart';

part 'publication_state.dart';

class PublicationCubit extends Cubit<PublicationState> {
  PublicationCubit(
    this.authenticationRepository,
    this.dbService,
    this.userService,

  ) : super( PublicationState(
            title: '', description: '', image: '', video: '', destination: destinations.first));
  final AuthenticationRepository authenticationRepository;
  final DbService dbService;
  final UserService userService;
  final FirebaseApi firebaseApi=FirebaseApi();

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

      Publication publication = Publication(
        title: state.title,
        imageUrl: state.image,
        video: state.video,
        state: PubState.pending,
        description: state.description,
        id: const Uuid().v4(),
        user: user,
        destination: state.destination,
      );
      final res = await dbService.createPub(publication);
      if (res) {
        final admin=await userService.getUserById(Constant.adminId);
        await firebaseApi.sendMessage(title: 'New Publication Added',
            body: 'A new publication "${state.title}" has been added.',
            userDeviceToken: admin?.fcmToken??"");
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
  void destinationChanged(String value) {
    emit(
      state.copyWith(
        destination: destinations.firstWhere((element) => element.city==value),
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
