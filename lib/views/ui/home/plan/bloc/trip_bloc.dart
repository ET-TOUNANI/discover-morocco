import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/models/models/destination.dart';
import 'package:discover_morocco/business_logic/models/models/ongoing_trip_timeline.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../../business_logic/models/models/enums/bloc_status.dart';
import '../../../../../business_logic/models/models/ongoing_trip.dart';
import '../../../../../business_logic/services/user_service.dart';
import '../../../../../business_logic/utils/logicConstants.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc(this.userService) : super(
       TripState(
         destination: destinations.first,
          date: DateTime.now().toString().split(' ').first,
          trip:userModel.trip,
      )
  ) {
    on<AddPlanEvent>(_addPlan);
    on<UpdatePlanEvent>(_updatePlan);
  }

  final UserService userService;

  FutureOr<void> _addPlan(
      AddPlanEvent event,
      Emitter<TripState> emit,
      ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      List<OngoingTripTimelineModel> timelines=(state.trip!= null) ?state.trip!.timeline:[];
      timelines.add(
        OngoingTripTimelineModel(
            id:const Uuid().v4() ,
            date: state.date,
            done: false,
            destination: state.destination
        )
      );
      OngoingTripModel newTrip= OngoingTripModel(
          id: (state.trip!= null)?state.trip!.id :const Uuid().v4(),
          timeline: timelines
      );
      userModel=UserModel(
        id: userModel.id,
        isAnonymous:  userModel.isAnonymous,
        emailVerified:  userModel.emailVerified,
        name: userModel.name,
        email: userModel.email,
        photo:userModel.photo,
        phone: userModel.phone,
        fcmToken: userModel.fcmToken,
        trip: newTrip
      );
      await userService.
    updateUser(userModel);
      emit(
        state.copyWith(
          status: BlocStatus.success,
          trip: userModel.trip
        )
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure));
    }

  }


  FutureOr<void> _updatePlan(
      UpdatePlanEvent event,
      Emitter<TripState> emit,
      ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      List<OngoingTripTimelineModel> timelines=(state.trip!= null) ?state.trip!.timeline:[];
     final oldTimeline=timelines[event.index];
      timelines[event.index]=OngoingTripTimelineModel(
          id:oldTimeline.id,
          date: oldTimeline.date,
          done: event.value,
          destination: oldTimeline.destination
      );
      OngoingTripModel newTrip= OngoingTripModel(
          id: (state.trip!= null)?state.trip!.id :const Uuid().v4(),
          timeline: timelines
      );
      userModel=UserModel(
          id: userModel.id,
          isAnonymous:  userModel.isAnonymous,
          emailVerified:  userModel.emailVerified,
          name: userModel.name,
          email: userModel.email,
          photo:userModel.photo,
          phone: userModel.phone,
          fcmToken: userModel.fcmToken,
          trip: newTrip
      );
      await userService.
      updateUser(userModel);
      emit(
          state.copyWith(
              status: BlocStatus.success,
              trip: userModel.trip
          )
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure));
    }

  }

  void destinationChanged(String value) {
    //print("destinationChanged**************** $value");
    emit(
      state.copyWith(
        //choose:state.choose++,
        destination: destinations.firstWhere((element) => element.city==value),
      ),
    );
  }
  void dateChange(String value) {
    //print("destinationChanged**************** $value");
    emit(
      state.copyWith(
        //choose:state.choose++,
        date: value,
      ),
    );
  }
}
