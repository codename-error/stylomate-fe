import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_icons.dart';

class RandomStyleButton extends StatelessWidget {
  final VoidCallback onTap;

  const RandomStyleButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 80,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 80,
          height: 68,
          decoration: BoxDecoration(
            color: CustomColors.nd200, // Purple color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Stylomateicon.dadu, 
                color: CustomColors.nd500,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                'Random',
                style: CustomTextStyles.mediumXs.copyWith(
                  color: CustomColors.nd500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}