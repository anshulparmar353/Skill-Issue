import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_event.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_state.dart';

class EditProfilePage extends StatefulWidget {

  final String currentName;

  const EditProfilePage({
    super.key,
    required this.currentName,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _save() {

    final name = nameController.text.trim();

    if (name.isEmpty) return;

    context.read<ProfileBloc>().add(UpdateProfileName(name));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),

      body: BlocConsumer<ProfileBloc, ProfileState>(

        listener: (context, state) {

          if (state.updated) {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile Updated"),
              ),
            );

            Navigator.pop(context);
          }
        },

        builder: (context, state) {

          return Padding(

            padding: const EdgeInsets.all(20),

            child: Column(

              children: [

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: state.loading ? null : _save,

                  child: state.loading
                      ? const CircularProgressIndicator()
                      : const Text("Save"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
