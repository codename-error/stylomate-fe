import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';
import 'package:camera/camera.dart';

class ScanWardrobeScreen extends StatefulWidget {
  const ScanWardrobeScreen({super.key});

  @override
  ScanWardrobeScreenState createState() => ScanWardrobeScreenState();
}

class ScanWardrobeScreenState extends State<ScanWardrobeScreen> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  bool _isCameraInitialized = false;
  int _selectedCategory = 0; // 0 for top, 1 for bottom

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras[0],
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _controller!.initialize();
        if (!mounted) return;
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          _isCameraInitialized
              ? Center(
                  child: CameraPreview(_controller!),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),

          // Grid overlay (PNG)
          Center(
            child: Image.asset(
              _selectedCategory == 0
                  ? 'assets/images/top_grid_overlay.png'
                  : 'assets/images/bottom_grid_overlay.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Stylomateicon.chefronleft,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Back',
                    style: CustomTextStyles.semiBoldBase.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category selection buttons (new position)
          Positioned(
            bottom: 130, // Position it just above the camera controls
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCategoryButton(Stylomateicon.baju, 0),
                    const SizedBox(width: 5),
                    _buildCategoryButton(Stylomateicon.celana, 1),
                  ],
                ),
              ),
            ),
          ),

          // Camera controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Flash/settings button
                  GestureDetector(
                    onTap: () async {
                      if (!_isCameraInitialized) return;
                      final FlashMode currentFlash = _controller!.value.flashMode;
                      FlashMode newFlash;
                      if (currentFlash == FlashMode.off) {
                        newFlash = FlashMode.torch;
                      } else {
                        newFlash = FlashMode.off;
                      }
                      await _controller!.setFlashMode(newFlash);
                      setState(() {});
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8AD958), // Light green color from reference
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.flash_on,
                        color: CustomColors.secondary600,
                        size: 24,
                      ),
                    ),
                  ),

                  // Capture button
                  GestureDetector(
                    onTap: _captureImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.3), width: 5),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  // Rotate camera button
                  GestureDetector(
                    onTap: _switchCamera,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8AD958), // Light green color from reference
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Stylomateicon.switchIcon,
                        color: CustomColors.secondary600,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(IconData icon, int index) {
    bool selected = _selectedCategory == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = index;
        });
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: selected ? CustomColors.secondary600 : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.white : Colors.grey,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.black,
          size: 24,
        ),
      ),
    );
  }

  Future<void> _captureImage() async {
    if (!_isCameraInitialized) return;

    try {
      final BuildContext currentContext = context;
      final XFile photo = await _controller!.takePicture();
      print('Photo captured: ${photo.path}');
      if (!mounted) return;
      Navigator.pushNamed(currentContext, '/preview-wardrobe', arguments: {
        'imagePath': photo.path,
        'category': _selectedCategory == 0 ? 'top' : 'bottom',
      });
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (cameras.length <= 1) return;

    final lensDirection = _controller!.description.lensDirection;
    CameraDescription newCamera;

    if (lensDirection == CameraLensDirection.back) {
      newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
    } else {
      newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
    }

    if (newCamera != null) {
      await _controller!.dispose();
      _controller = CameraController(
        newCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {});
    }
  }
}
