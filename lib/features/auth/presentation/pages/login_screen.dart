import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_event.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_state.dart';
import 'package:skill_issue/core/routes/app_go_router.dart';
import 'package:skill_issue/shared/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void _login() {
    context.read<AuthBloc>().add(
      LoginRequested(
        emailcontroller.text.trim(),
        passwordcontroller.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {

              if (state.isNewUser) {
                return context.go(AppRoutes.addSkillsScreen);
              } else {
                return context.go(AppRoutes.dashboardScreen);
              }
              
            }

            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },

          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),

                    Text(
                      "Login",
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.go(AppRoutes.forgotPasswordScreen);
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

                    ElevatedButton(
                      onPressed: isLoading ? null : _login,
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text("Sign in"),
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
                            context.go(AppRoutes.signupScreen);
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
            );
          },
        ),
      ),
    );
  }
}
