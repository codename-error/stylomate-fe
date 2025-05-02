import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_icons.dart';
import 'package:stylomate/themes/custom_text_styles.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48, // Fixed height
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search trend reccomendation',
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    hintStyle: CustomTextStyles.regularBase
                        .copyWith(color: CustomColors.secondary100),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Stylomateicon.search,
                        color: CustomColors.secondary300,
                        size: 20,
                      ),
                      onPressed: () {
                        // Add search functionality here
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    // Add search functionality here
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              height: 48, // Same height as TextField
              width: 48, // Square aspect ratio
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.primary600,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  color: CustomColors.primary600,
                  icon: const Icon(
                    Stylomateicon.filter,
                    color: CustomColors.secondary600,
                    size: 20,
                  ),
                  onPressed: () {
                    // Add edit functionality here
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
