import 'package:flutter/material.dart';
import 'package:stylomate/models/test.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';

class AddWardrobeScreen extends StatefulWidget {
  const AddWardrobeScreen({super.key});

  @override
  AddWardrobeScreenState createState() => AddWardrobeScreenState();
}

class AddWardrobeScreenState extends State<AddWardrobeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.secondary50,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Stylomateicon.chefronleft),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Back',
                  style: CustomTextStyles.semiBoldBase.copyWith(
                    color: CustomColors.secondary900,
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 200,
        ),
        backgroundColor: CustomColors.secondary50,
        body: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Add your clothes to the wardrobe',
                      style: CustomTextStyles.bold3xl.copyWith(
                        color: CustomColors.secondary600,
                      ),
                    ),
                    Text(
                      'Place your clothing within the marks provided. Make sure the item is fully visible, unfolded, and clearly captured.',
                      style: CustomTextStyles.regularSm.copyWith(
                        color: CustomColors.secondary400,
                      ),
                    ),
                  ],
                )),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/do upload.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                  Image.asset(
                    'assets/images/dont upload.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(), // This helps with spacing
                Padding(
                padding: const EdgeInsets.only(left: 24, right:24, bottom: 32),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                  backgroundColor: CustomColors.secondary600,
                  ),
                  onPressed: () {},
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                    Stylomateicon.camera,
                    color: CustomColors.secondary50,
                    ),
                    const SizedBox(width: 8),
                    Text(
                    'Take a picture now',
                    style: CustomTextStyles.mediumLg.copyWith(
                      color: CustomColors.secondary50,
                    ),
                    ),
                  ],
                  ),
                ),
                ),
              ],
              ),
            ),
          ],
        ));
  }
}
