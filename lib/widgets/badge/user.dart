import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';

class BadgeUser extends StatelessWidget {
  final IconData icon;
  final String label;

  const BadgeUser({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: CustomColors.primary600,
            ),
            const SizedBox(width: 6),
            Text(label,
                style: CustomTextStyles.mediumXs
                    .copyWith(color: CustomColors.secondary400)),
          ],
        ),
      ),
    );
  }
}
