import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.data == null) {
          return const Center(child: Text("No Data"));
        }

        final data = state.data!;

        return Column(
          children: [
            Text("Total Skills: ${data.totalSkills}"),

            Text("Beginner: ${data.beginner}"),
            Text("Intermediate: ${data.intermediate}"),
            Text("Advanced: ${data.advanced}"),

            Text("Roadmap Progress: ${data.roadmapCompletion}%"),
          ],
        );
      },
    );
  }
}
