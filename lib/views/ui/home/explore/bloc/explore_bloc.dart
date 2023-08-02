import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:discover_morocco/business_logic/models/models/enums/bloc_status.dart';
import 'package:discover_morocco/business_logic/services/db_service.dart';

import '../../../../../business_logic/models/models/publication.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc(
    this._repository,
  ) : super(const ExploreState()) {
    on<ExploreFetched>(_onFetched);
    on<ExploreCategoriesFetched>(_onCategoriesFetched);
    on<ExplorePopularFetched>(_onPopularFetched);
    on<ExploreFeatureFetched>(_onFeatureFetched);
  }

  final DbService _repository;

  Future<void> _onFetched(
    ExploreFetched event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(categoriesStatus: BlocStatus.loading));
    try {
      emit(
        state.copyWith(
          categoriesStatus: BlocStatus.success,
          categories: await _repository.publications(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(categoriesStatus: BlocStatus.failure));
    }
  }

  Future<void> _onCategoriesFetched(
    ExploreCategoriesFetched event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(categoriesStatus: BlocStatus.loading));
    try {
      emit(
        state.copyWith(
          categoriesStatus: BlocStatus.success,
          categories: await _repository.publications(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(categoriesStatus: BlocStatus.failure));
    }
  }

  Future<void> _onPopularFetched(
    ExplorePopularFetched event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(popularsStatus: BlocStatus.loading));
    try {
      emit(
        state.copyWith(
          popularsStatus: BlocStatus.success,
          populars: await _repository.populars(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(popularsStatus: BlocStatus.failure));
    }
  }

  Future<void> _onFeatureFetched(
    ExploreFeatureFetched event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(featureStatus: BlocStatus.loading));
    try {
      emit(
        state.copyWith(
          featureStatus: BlocStatus.success,
          features: await _repository.features(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(featureStatus: BlocStatus.failure));
    }
  }
}
