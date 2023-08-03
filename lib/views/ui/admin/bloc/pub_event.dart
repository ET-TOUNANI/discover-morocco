part of 'pub_bloc.dart';

@immutable
abstract class PubEvent extends Equatable {}

class WaitingPubEventFetched extends PubEvent {
  @override
  List<Object?> get props => [];
}

class PubEventListFetched extends PubEvent {
  @override
  List<Object?> get props => [];
}

class RejectPubEvent extends PubEvent {
  final Publication pub;

  RejectPubEvent({required this.pub});
  @override
  List<Object?> get props => [pub];
}

class ApprovePubEvent extends PubEvent {
  final Publication pub;

  ApprovePubEvent({required this.pub});
  @override
  List<Object?> get props => [pub];
}
