part of 'trip_bloc.dart';


@immutable
class TripState extends Equatable {
  final OngoingTripModel? trip;
  final DestinationModel destination;
  final BlocStatus status;
  final String date;
  //final int choose;

  const TripState(  {
    required this.trip ,
    this.status=BlocStatus.initial,
    required this.destination,
    this.date='',
   // this.choose=0,
  });

  TripState copyWith({
    OngoingTripModel ?trip,
    BlocStatus ?status,
    DestinationModel ?destination,
    String ?date,
   // int ?choose,
  }) =>
      TripState(
        trip: trip??this.trip,
        status: status??this.status,
        destination: destination??this.destination,
        date: date??this.date,
      );

  @override
  List<Object?> get props => [
    trip,status,destination,date
  ];

}
