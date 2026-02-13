class MultiQuizState {

  final List<String> skillQueue;
  final int currentIndex;
  final bool completed;

  String get currentSkillId => skillQueue[currentIndex];

  bool get hasNext => currentIndex < skillQueue.length - 1;

  MultiQuizState({
    required this.skillQueue,
    required this.currentIndex,
    required this.completed,
  });

  factory MultiQuizState.initial() =>
      MultiQuizState(
        skillQueue: [],
        currentIndex: 0,
        completed: false,
      );

  MultiQuizState copyWith({
    List<String>? skillQueue,
    int? currentIndex,
    bool? completed,
  }) {
    return MultiQuizState(
      skillQueue: skillQueue ?? this.skillQueue,
      currentIndex: currentIndex ?? this.currentIndex,
      completed: completed ?? this.completed,
    );
  }
}
