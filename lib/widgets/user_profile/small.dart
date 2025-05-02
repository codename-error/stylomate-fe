import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';

class UserProfileSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/dummy user.png',
              width: 40,
              height: 40,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: CustomColors.secondary50,
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColors.secondary50,
                width: 2,
              ),
            ),
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: CustomColors.primary600,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
