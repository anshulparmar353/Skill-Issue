import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_roadmap_usecase.dart';
import 'roadmap_event.dart';
import 'roadmap_state.dart';

class RoadmapBloc extends Bloc<RoadmapEvent, RoadmapState> {
  final GetRoadmapUseCase getRoadmap;

  RoadmapBloc(this.getRoadmap) : super(RoadmapInitial()) {
    on<LoadRoadmap>(_load);
  }

  Future<void> _load(LoadRoadmap event,Emitter<RoadmapState> emit) async {
    emit(RoadmapLoading());

    try {
      final result = await getRoadmap(event.roleId);

      result.fold(
        (failure) => emit(RoadmapError(failure.message)),
        (roadmap) => emit(RoadmapLoaded(roadmap)),
      );

    } catch (e) {
      emit(RoadmapError("Failed to load Roadmap"));
    }
  }
}
