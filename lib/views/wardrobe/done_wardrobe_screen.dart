import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';

class DoneWardrobeScreen extends StatefulWidget {
  const DoneWardrobeScreen({super.key});

  @override
  DoneWardrobeScreenState createState() => DoneWardrobeScreenState();
}

class DoneWardrobeScreenState extends State<DoneWardrobeScreen> {
  // Add any state variables here if needed
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Stylomateicon.chefronleft, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Back',
          style: CustomTextStyles.regularBase.copyWith(
            color: CustomColors.secondary900,
          ),
        ),
        titleSpacing: 0,
        leadingWidth: 30,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB5F99B), // Light green color
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Success title
                  Text(
                    'Upload Successful!',
                    style: CustomTextStyles.semiBoldXl.copyWith(
                      color: CustomColors.secondary900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Success description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Our item has been successfully uploaded and added to WardDrop. You can now style it or explore more options!',
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.regularSm.copyWith(
                        color: CustomColors.secondary600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom button section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the next screen or back to the wardrobe
                      Navigator.of(context).popUntil((ModalRoute.withName('/profile')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: CustomTextStyles.semiBoldBase.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}