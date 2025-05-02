import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';

class HistoryCard extends StatelessWidget {
  final String imgPath;
  final VoidCallback? onTap;

  const HistoryCard({
    super.key,
    required this.imgPath,
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
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.cover,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
