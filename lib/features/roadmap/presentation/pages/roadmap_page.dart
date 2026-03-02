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
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text(state.error!));
        }

        final roadmap = state.roadmap;

        if (roadmap == null) {
          return const Center(child: Text("No Roadmap Found"));
        }

        return _buildRoadmap(roadmap);
      },
    );
  }
}
