abstract class RoadmapEvent {}

class LoadRoadmap extends RoadmapEvent {
  final String roleId;

  LoadRoadmap(this.roleId);
}
