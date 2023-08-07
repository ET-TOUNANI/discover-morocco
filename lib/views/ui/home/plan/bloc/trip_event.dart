part of 'trip_bloc.dart';

@immutable
abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object?> get props => [];
}

class AddPlanEvent extends TripEvent {

  const AddPlanEvent();

  @override
  List<Object?> get props => [];
}
class FetchPlanEvent extends TripEvent {

  const FetchPlanEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePlanEvent extends TripEvent {

  final int index;
  final bool value;
  const UpdatePlanEvent(this.index, this.value);

  @override
  List<Object?> get props => [index,value];
}