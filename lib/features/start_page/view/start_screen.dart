import 'package:flutter/material.dart';
import 'package:skill_issue/utils/resusable_widgets/my_container.dart';
import 'package:skill_issue/utils/resusable_widgets/my_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),

              Align(
                child: Image.asset(
                  isDark
                      ? "assets/logo/darkmodelogo.png"
                      : "assets/logo/lightmodelogo.png",

                  width: width * 0.6,
                ),
              ),

              Column(
                children: [
                  MyText(text: "We'll help you discover the right tech path —"),
                  MyText(text: "even if you don't know what skills are"),
                  MyText(text: "called yet."),
                ],
              ),

              SizedBox(height: 20),

              MyContainer(
                iconImage: "assets/email-icon.png",
                title: "I'm not sure what to learn",
                discription:
                    "Don't worry about knowing tech terms. We'll ask simple questions about your interests and guide you from there",
                butttontext: "Let's discover together",
                onPressedButton: () {},
              ),

              SizedBox(height: 20),

              MyContainer(
                iconImage: "assets/email-icon.png",
                title: "I already have some experience",
                discription:
                    "Know some programming or tech concepts? We'll validate your knowledge and show you exactly how deep to go.",
                butttontext: "Validate my skills",
                onPressedButton: () {},
              ),

              SizedBox(height: 30),

              Center(
                child: MyText(
                  text:
                      "Built for students who want clarity, not confusion. No jargon ne overwhelm",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
