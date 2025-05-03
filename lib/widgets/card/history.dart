import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/utils/display_date.dart';
import 'package:stylomate/themes/custom_icons.dart';

class HistoryCard extends StatelessWidget {
  final String serviceTitle;
  final int tokenActivity;
  final DateTime date;
  final bool isDecreased;

  const HistoryCard({
    super.key,
    required this.serviceTitle,
    required this.tokenActivity,
    required this.date,
    this.isDecreased = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDecreased
                      ? CustomColors.nd200
                      : CustomColors.primary200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                    serviceTitle == "Stylo AI"
                      ? Stylomateicon.magic
                      : serviceTitle == "Style me"
                        ? Stylomateicon.camera
                        : serviceTitle == "Share"
                          ? Stylomateicon.send
                          : Stylomateicon.camera,
                  color: isDecreased
                      ? CustomColors.nd700
                      : CustomColors.primary700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceTitle,
                    style: CustomTextStyles.mediumLg.copyWith(
                      color: CustomColors.secondary900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayDate(date),
                    style: CustomTextStyles.regularXs.copyWith(
                      color: CustomColors.secondary300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/point hd.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${isDecreased ? '-' : '+'} $tokenActivity',
                style: CustomTextStyles.semiBoldBase.copyWith(
                  color: CustomColors.nd500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
