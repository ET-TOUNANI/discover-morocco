import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../business_logic/models/models/enums/PubState.dart';
import '../../../../business_logic/models/models/enums/bloc_status.dart';
import '../../../../business_logic/models/models/publication.dart';
import '../../../../business_logic/services/Auth_service.dart';
import '../../../../business_logic/services/db_service.dart';

part 'pub_event.dart';
part 'pub_state.dart';

class PubliacationBloc extends Bloc<PubEvent, WaitingPubState> {
  PubliacationBloc(
    this._repository,
    this.authenticationRepository,
  ) : super(const WaitingPubState()) {
    on<WaitingPubEventFetched>(_onWaitingPubFetched);
    on<PubEventListFetched>(_onPubListFetched);
    on<ApprovePubEvent>(_onApprove);
    on<RejectPubEvent>(_onReject);
  }

  final DbService _repository;
  final AuthenticationRepository authenticationRepository;

  Future<void> _onApprove(
    ApprovePubEvent event,
    Emitter<WaitingPubState> emit,
  ) async {
    emit(state.copyWith(pubUpdateStatus: BlocStatus.loading));
    try {
      Publication pub = Publication(
          state: PubState.accepted,
          id: event.pub.id,
          title: event.pub.title,
          user: event.pub.user,
          imageUrl: event.pub.imageUrl,
          video: event.pub.video,
          comments: event.pub.comments,
          description: event.pub.description,
          isLiked: event.pub.isLiked,
          isPublished: true,
          likes: event.pub.likes);
      final res = await _repository.updatePub(pub);
      if (res) {
        emit(
          state.copyWith(
            pubUpdateStatus: BlocStatus.success,
          ),
        );
      } else {
        emit(state.copyWith(pubUpdateStatus: BlocStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(pubUpdateStatus: BlocStatus.failure));
    }
  }

  Future<void> _onReject(
    RejectPubEvent event,
    Emitter<WaitingPubState> emit,
  ) async {
    emit(state.copyWith(pubUpdateStatus: BlocStatus.loading));
    try {
      Publication pub = Publication(
          state: PubState.rejected,
          id: event.pub.id,
          title: event.pub.title,
          user: event.pub.user,
          imageUrl: event.pub.imageUrl,
          video: event.pub.video,
          comments: event.pub.comments,
          description: event.pub.description,
          isLiked: event.pub.isLiked,
          isPublished: false,
          likes: event.pub.likes);
      final res = await _repository.updatePub(pub);
      if (res) {
        emit(
          state.copyWith(
            pubUpdateStatus: BlocStatus.success,
          ),
        );
      } else {
        emit(state.copyWith(pubUpdateStatus: BlocStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(pubUpdateStatus: BlocStatus.failure));
    }
  }

  Future<void> _onPubListFetched(
    PubEventListFetched event,
    Emitter<WaitingPubState> emit,
  ) async {
    emit(state.copyWith(pubListStatus: BlocStatus.loading));
    try {
      emit(
        state.copyWith(
          pubListStatus: BlocStatus.success,
          publicationsByUser: await _repository
              .getPublicationsByUser(authenticationRepository.currentUser),
        ),
      );
    } catch (e) {
      emit(state.copyWith(pubListStatus: BlocStatus.failure));
    }
  }

  Future<void> _onWaitingPubFetched(
    WaitingPubEventFetched event,
    Emitter<WaitingPubState> emit,
  ) async {
    emit(state.copyWith(waitingPubStatus: BlocStatus.loading));
    try {
      emit(
        state.copyWith(
          waitingPubStatus: BlocStatus.success,
          publications: await _repository.waitingPublications(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(waitingPubStatus: BlocStatus.failure));
    }
  }
}
