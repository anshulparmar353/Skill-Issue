import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_issue/core/routes/app_go_router.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_event.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = state.profile;

        if (profile == null) {
          return const Text("No Profile");
        }

        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.profileEditScreen, extra: profile.name);
              },
              child: const Text("Edit Profile"),
            ),

            Text(profile.name),
            Text(profile.email),

            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
