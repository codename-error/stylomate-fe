import 'package:flutter/material.dart';

class TryOnScreen extends StatefulWidget {
  const TryOnScreen({Key? key}) : super(key: key);

  @override
  State<TryOnScreen> createState() => _TryOnScreenState();
}

class _TryOnScreenState extends State<TryOnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/try_on_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Try-on',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Choose where you will start to realize the miracle!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildOptionButton(
                            title: 'Wardrobe',
                            backgroundColor: const Color(0xFF7AC555),
                            imagePath: 'assets/images/wardrobe_icon.png',
                            onTap: () {
                              // Handle wardrobe button tap
                            },
                          ),
                          const SizedBox(width: 16),
                          _buildOptionButton(
                            title: 'Url link',
                            backgroundColor: Colors.grey.shade300,
                            imagePath: 'assets/images/url_icon.png',
                            onTap: () {
                              // Handle URL link button tap
                            },
                          ),
                          const SizedBox(width: 16),
                          _buildOptionButton(
                            title: '',
                            backgroundColor: Colors.grey.shade300,
                            imagePath: 'assets/images/camera_icon.png',
                            onTap: () {
                              // Handle camera button tap
                            },
                            width: 60,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () {
                        // Handle home button tap
                      },
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle try-on button tap
                      },
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Try-on'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7AC555),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.lock, color: Colors.white),
                      onPressed: () {
                        // Handle lock button tap
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white),
                      onPressed: () {
                        // Handle profile button tap
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String title,
    required Color backgroundColor,
    required String imagePath,
    required VoidCallback onTap,
    double width = 140,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            if (title.isNotEmpty) ...[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}