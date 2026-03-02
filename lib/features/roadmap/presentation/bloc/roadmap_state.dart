import '../../domain/entities/roadmap.dart';

class RoadmapState {

  final bool loading;
  final Roadmap? roadmap;
  final String? error;

  RoadmapState({
    required this.loading,
    this.roadmap,
    this.error,
  });

  factory RoadmapState.initial() =>
      RoadmapState(loading: false);

  RoadmapState copyWith({
    bool? loading,
    Roadmap? roadmap,
    String? error,
  }) {
    return RoadmapState(
      loading: loading ?? this.loading,
      roadmap: roadmap ?? this.roadmap,
      error: error,
    );
  }
}
