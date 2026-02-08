import 'package:flutter/material.dart';
import 'package:skill_issue/core/utils/resusable_widgets/my_button.dart';
import 'package:skill_issue/core/utils/resusable_widgets/my_text_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final TextEditingController passwordcontroller = TextEditingController();
    final TextEditingController confirmpasswordcontroller =
        TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                SizedBox(height: 15),

                MyTextField(
                  controller: passwordcontroller,
                  hintText: "Password",
                  obscure: true,
                ),

                SizedBox(height: 15),

                MyTextField(
                  controller: confirmpasswordcontroller,
                  hintText: "Confirm Password",
                  obscure: true,
                ),

                SizedBox(height: 25),

                MyButton(onTap: () {}, buttonText: "Submit"),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
