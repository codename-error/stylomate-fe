import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';

class PreviewWardrobeScreen extends StatefulWidget {
  const PreviewWardrobeScreen({super.key});

  @override
  PreviewWardrobeState createState() => PreviewWardrobeState();
}

class PreviewWardrobeState extends State<PreviewWardrobeScreen> {
  // Add state variables here
  bool _isUploading = false;

  // Handle the upload functionality
  Future<void> _handleUpload() async {
    setState(() {
      _isUploading = true;
    });
    
    // Add your upload logic here
    // For example: await uploadService.uploadImage(imageFile);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isUploading = false;
    });
    
    Navigator.pushNamed(context, '/done-wardrobe');
    // You might want to navigate or show a success message after upload
  }
  
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
          'Item preview',
          style: CustomTextStyles.semiBoldBase.copyWith(
            color: CustomColors.secondary900,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/black_shirt.png', // Replace with your image path or network image
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : _handleUpload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: _isUploading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Upload',
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