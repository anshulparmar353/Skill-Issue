import 'package:flutter/material.dart';
import 'package:skill_issue/shared/widgets/my_button.dart';
import 'package:skill_issue/shared/theme/app_colors.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.iconImage,
    required this.title,
    required this.discription,
    required this.butttontext,
    required this.onPressedButton,
  });

  final String iconImage;
  final String title;
  final String discription;
  final String butttontext;
  final Function()? onPressedButton;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.color,
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),

          Image.asset(iconImage, width: width * 0.1),

          SizedBox(height: 10),

          Text(title, style: Theme.of(context).textTheme.headlineSmall),

          SizedBox(height: 10),

          Text(discription, style: Theme.of(context).textTheme.bodySmall),

          SizedBox(height: 10),

          MyButton(onTap: onPressedButton, buttonText: butttontext),
        ],
      ),
    );
  }
}
