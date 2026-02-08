import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_issue/utils/routes/app_go_router.dart';
import 'package:skill_issue/utils/routes/navigation_services.dart';
import 'package:skill_issue/utils/resusable_widgets/my_button.dart';
import 'package:skill_issue/utils/resusable_widgets/my_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

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

                Text("Login", style: Theme.of(context).textTheme.headlineLarge),

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        NavigationServices.navigationKey.currentContext!.push(
                          AppRoutes.forgotPasswordScreen,
                        );
                      },
                      child: Text(
                        "Forgotpassword",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                MyButton(
                  onTap: () {
                    NavigationServices.navigationKey.currentContext!.push(
                      AppRoutes.startscreen,
                    );
                  },
                  buttonText: "Sign in",
                ),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account yet?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    TextButton(
                      onPressed: () {
                        NavigationServices.navigationKey.currentContext!.push(
                          AppRoutes.signupScreen,
                        );
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/google logo.png",
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(width: 5),
                      Text("Sign in with Google"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
