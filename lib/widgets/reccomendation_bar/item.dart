import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';

class RecommendationItem extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const RecommendationItem({
    super.key,
    required this.text,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isActive 
              ? CustomColors.primary600
              : CustomColors.primary50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: CustomTextStyles.regularSm.copyWith(
              color: isActive 
                  ? CustomColors.secondary600
                  : CustomColors.secondary300,
            ),
          ),
        ),
      ),
    );
  }
}