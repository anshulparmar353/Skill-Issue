import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/roadmap/domain/entities/roadmap.dart';
import 'package:skill_issue/features/roadmap/presentation/bloc/roadmap_bloc.dart';
import 'package:skill_issue/features/roadmap/presentation/bloc/roadmap_state.dart';

class RoadmapPage extends StatelessWidget {
  const RoadmapPage({super.key});

  Widget _buildRoadmap(Roadmap roadmap) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            roadmap.role,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(value: roadmap.completion / 100),

          const SizedBox(height: 24),

          Expanded(
            child: ListView.builder(
              itemCount: roadmap.steps.length,
              itemBuilder: (_, index) {
                final step = roadmap.steps[index];

                return ListTile(
                  leading: Icon(
                    step.completed ? Icons.check_circle : Icons.circle_outlined,
                  ),
                  title: Text(step.title),
                  subtitle: Text(step.description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoadmapBloc, RoadmapState>(
      builder: (context, state) {
        if (state is RoadmapLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RoadmapError) {
          return Center(child: Text(state.message));
        }

        if (state is RoadmapLoaded) {
          final roadmap = state.roadmap;
          return _buildRoadmap(roadmap);
        }

        return const SizedBox();
      },
    );
  }
}
