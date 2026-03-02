import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_roadmap_usecase.dart';
import 'roadmap_event.dart';
import 'roadmap_state.dart';

class RoadmapBloc extends Bloc<RoadmapEvent, RoadmapState> {

  final GetRoadmapUseCase getRoadmap;

  RoadmapBloc(this.getRoadmap)
      : super(RoadmapState.initial()) {

    on<LoadRoadmap>(_load);
  }

  Future<void> _load(LoadRoadmap event, emit) async {

    emit(state.copyWith(loading: true));

    try {

      final roadmap = await getRoadmap();

      emit(state.copyWith(
        loading: false,
        roadmap: roadmap,
      ));

    } catch (e) {

      emit(state.copyWith(
        loading: false,
        error: "Failed to load roadmap",
      ));
    }
  }
}
