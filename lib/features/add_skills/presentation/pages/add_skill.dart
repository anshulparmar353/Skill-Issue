import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddSkill extends StatefulWidget {
  const AddSkill({super.key});

  @override
  State<AddSkill> createState() {
    return _AddSkill();
  }
}

class _AddSkill extends State<AddSkill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // ListView.builder(
                    //   itemBuilder: 
                    // ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
