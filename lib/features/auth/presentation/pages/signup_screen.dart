import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_issue/core/utils/routes/app_go_router.dart';
import 'package:skill_issue/core/utils/routes/navigation_services.dart';
import 'package:skill_issue/core/utils/resusable_widgets/my_button.dart';
import 'package:skill_issue/core/utils/resusable_widgets/my_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final TextEditingController emailcontroller = TextEditingController();
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
                  "Sign up",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                SizedBox(height: 15),

                MyTextField(
                  controller: emailcontroller,
                  hintText: "Email",
                  obscure: false,
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

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already registered?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    TextButton(
                      onPressed: () {
                        NavigationServices.navigationKey.currentContext!.go(
                          AppRoutes.loginScreen,
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
