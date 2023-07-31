import 'package:bloc/bloc.dart';
import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'publication_state.dart';


class PublicationCubit extends Cubit<PublicationState> {
  PublicationCubit(
      this.authenticationRepository,
      ) : super(const PublicationState(
      title: '',
      description:'',
      image:'',
      video:''
  ));
  final AuthenticationRepository authenticationRepository;
  void titleChanged(String value) {
    emit(
      state.copyWith(
        title: value
      ),
    );
  }
  void descriptionChanged(String value) {
    emit(
      state.copyWith(
          description: value
      ),
    );
  }
  void imageChanged(String value) {
    emit(
      state.copyWith(
          image: value
      ),
    );
  }
  void videoChanged(String value) {
    emit(
      state.copyWith(
          video: value
      ),
    );
  }

}