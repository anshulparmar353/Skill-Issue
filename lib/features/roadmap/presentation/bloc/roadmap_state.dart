import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/roadmap/domain/entities/roadmap.dart';

abstract class RoadmapState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class RoadmapInitial extends RoadmapState {}

class RoadmapLoading extends RoadmapState {}

class RoadmapLoaded extends RoadmapState {
  final Roadmap roadmap;

  RoadmapLoaded(this.roadmap);
  
  @override
  List<Object?> get props => [roadmap];
}

class RoadmapError extends RoadmapState {
  final String message;

  RoadmapError(this.message);

  @override
  List<Object?> get props => [message];
}
