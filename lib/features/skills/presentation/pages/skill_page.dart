import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/add_skills/domain/entities/skill_level.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_bloc.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_event.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_state.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  Widget _levelChip(SkillLevel level) {
    return Chip(label: Text(level.name.toUpperCase()));
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Skill"),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<SkillsBloc>().add(AddSkill(controller.text));

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<SkillsBloc, SkillsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: state.skills.length,
            itemBuilder: (_, index) {
              final skill = state.skills[index];

              return Dismissible(
                key: ValueKey(skill.id),

                onDismissed: (_) {
                  context.read<SkillsBloc>().add(DeleteSkill(skill.id));
                },

                child: ListTile(
                  title: Text(skill.name),

                  trailing: _levelChip(skill.level),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
