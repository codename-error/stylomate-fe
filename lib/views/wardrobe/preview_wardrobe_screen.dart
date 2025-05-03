import 'package:flutter/material.dart';
import 'package:stylomate/services/wardrobe.dart';
import 'dart:io';
import 'dart:convert';  // Add this import for base64Encode
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';
import 'package:http/http.dart' as http;

class PreviewWardrobeScreen extends StatefulWidget {
  const PreviewWardrobeScreen({super.key});

  @override
  PreviewWardrobeState createState() => PreviewWardrobeState();
}

class PreviewWardrobeState extends State<PreviewWardrobeScreen> {
  final WardrobeService _wardrobeService = WardrobeService.create();
  bool _isUploading = false;
  Map<String, dynamic> args = {}; // Initialize with empty map

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Move context-dependent code from initState to didChangeDependencies
    args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
  }

  @override
  void initState() {
    super.initState();
    // Don't access context here
  }

  // Handle the upload functionality
  Future<void> _handleUpload() async {
    setState(() {
      _isUploading = true;
    });
    
    try {
      if (args['imagePath'] == null) {
        throw Exception('No image file provided');
      }
      
      final String imagePath = args['imagePath'];
      final File imageFile = File(imagePath);
      final List<int> fileBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(fileBytes);
      final String type = args['type']?.toString() ?? 'unknown';
      final String bodyRequest = jsonEncode({
        'type': type,
        'file': base64Image,
      });
      
      final response = await _wardrobeService.addWardrobe(bodyRequest);

      print(bodyRequest);
      
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
        
        if (response.isSuccessful) {
          debugPrint('Upload successful');
          Navigator.pushNamed(context, '/done-wardrobe');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: ${response.error ?? "Unknown error"}')),
          );
        }
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${e.toString()}')),
        );
      }
    }
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
              child: args['imagePath'] != null 
                ? Image.file(
                    File(args['imagePath']),
                    fit: BoxFit.contain,
                  )
                : const Center(child: Text('No image available')),
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