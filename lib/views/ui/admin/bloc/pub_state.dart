part of 'pub_bloc.dart';

@immutable
class WaitingPubState extends Equatable {
  const WaitingPubState({
    this.waitingPubStatus = BlocStatus.initial,
    this.pubListStatus = BlocStatus.initial,
    this.pubUpdateStatus = BlocStatus.initial,
    this.publications = const [],
    this.publicationsByUser = const [],
  });

  final BlocStatus waitingPubStatus;

  final List<Publication> publications;
  final BlocStatus pubListStatus;
  final BlocStatus pubUpdateStatus;
  final List<Publication> publicationsByUser;

  @override
  List<Object?> get props => [
        publications,
        publicationsByUser,
        waitingPubStatus,
        pubListStatus,
        pubUpdateStatus
      ];

  WaitingPubState copyWith(
          {BlocStatus? waitingPubStatus,
          BlocStatus? pubListStatus,
          BlocStatus? pubUpdateStatus,
          List<Publication>? publications,
          List<Publication>? publicationsByUser}) =>
      WaitingPubState(
        publicationsByUser: publicationsByUser ?? this.publicationsByUser,
        publications: publications ?? this.publications,
        waitingPubStatus: waitingPubStatus ?? this.waitingPubStatus,
        pubUpdateStatus: pubUpdateStatus ?? this.pubUpdateStatus,
        pubListStatus: pubListStatus ?? this.pubListStatus,
      );
}
