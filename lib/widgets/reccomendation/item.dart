import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';

class RecomBoxItem extends StatelessWidget {
  final String text;
  final String imgPath;
  final bool isRecommended;
  final double aspectRatio;
  final VoidCallback? onTap;

  const RecomBoxItem({
    super.key,
    required this.text,
    required this.imgPath,
    this.isRecommended = false,
    this.aspectRatio = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isRecommended)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Image.asset(
                      'assets/images/recommended.png',
                      width: 122,
                      height: 20,
                    ),
                  ),
              ],
            ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Text(
                text,
                style: CustomTextStyles.mediumBase.copyWith(
                  color: CustomColors.secondary500,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
