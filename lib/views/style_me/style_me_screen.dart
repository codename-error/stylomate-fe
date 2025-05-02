import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';
import 'package:stylomate/widgets/navigation/bar.dart';

class WardrobeItem {
  final String id;
  final String name;
  final String imagePath;
  final String type;

  WardrobeItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.type,
  });
}

class StyleMeScreen extends StatefulWidget {
  const StyleMeScreen({super.key});

  @override
  StyleMeScreenState createState() => StyleMeScreenState();
}

class StyleMeScreenState extends State<StyleMeScreen> {
  // State variables
  bool _isLoading = false;
  WardrobeItem? _selectedTop;
  WardrobeItem? _selectedBottom;
  int _selectedTabIndex = 1; // Default to Style me tab (middle)
  final TextEditingController _searchController = TextEditingController();
  List<WardrobeItem> _items = [];
  List<WardrobeItem> _filteredItems = [];
  String _currentItemType = 'top';
  final DraggableScrollableController _draggableController = DraggableScrollableController();
  bool _isBottomSheetVisible = false;

  @override
  void initState() {
    super.initState();
    _loadMockItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _draggableController.dispose();
    super.dispose();
  }

  // Load mock wardrobe items
  void _loadMockItems() {
    _items = [
      WardrobeItem(
        id: '1',
        name: 'Green T-Shirt',
        imagePath: 'assets/images/green_tshirt.png',
        type: 'top',
      ),
      WardrobeItem(
        id: '2',
        name: 'Grey Shirt',
        imagePath: 'assets/images/grey_shirt.png',
        type: 'top',
      ),
      WardrobeItem(
        id: '3',
        name: 'Striped Shirt',
        imagePath: 'assets/images/striped_shirt.png',
        type: 'top',
      ),
      WardrobeItem(
        id: '4',
        name: 'Black Shirt',
        imagePath: 'assets/images/black_shirt.png',
        type: 'top',
      ),
      WardrobeItem(
        id: '5',
        name: 'Light Blue Shirt',
        imagePath: 'assets/images/light_blue_shirt.png',
        type: 'top',
      ),
      WardrobeItem(
        id: '6',
        name: 'Brown Shirt',
        imagePath: 'assets/images/brown_shirt.png',
        type: 'top',
      ),
      WardrobeItem(
        id: '7',
        name: 'Blue Jeans',
        imagePath: 'assets/images/blue_jeans.png',
        type: 'bottom',
      ),
      WardrobeItem(
        id: '8',
        name: 'Black Pants',
        imagePath: 'assets/images/black_pants.png',
        type: 'bottom',
      ),
    ];
  }

  // Method to show bottom sheet for top items
  void _addTopItem() {
    setState(() {
      _currentItemType = 'top';
      _searchController.clear();
      _filterItems();
      _isBottomSheetVisible = true;
    });
  }

  // Method to show bottom sheet for bottom items
  void _addBottomItem() {
    setState(() {
      _currentItemType = 'bottom';
      _searchController.clear();
      _filterItems();
      _isBottomSheetVisible = true;
    });
  }

  // Filter items based on search text and current type
  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _items.where((item) {
        return item.type == _currentItemType &&
            (query.isEmpty || item.name.toLowerCase().contains(query));
      }).toList();
    });
  }

  // Confirm selected item
  void _confirmSelection(WardrobeItem item) {
    setState(() {
      if (_currentItemType == 'top') {
        _selectedTop = item;
      } else {
        _selectedBottom = item;
      }
      _isBottomSheetVisible = false;
    });
  }

  // Close bottom sheet without selection
  void _closeBottomSheet() {
    setState(() {
      _isBottomSheetVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Top spacing for status bar
              const SizedBox(height: 40),
              
              // Header section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Combine your style',
                      style: CustomTextStyles.semiBoldXl.copyWith(
                        color: CustomColors.secondary900,
                      ),
                    ),
                    Text(
                      'Today\'s mood',
                      style: CustomTextStyles.regularSm.copyWith(
                        color: CustomColors.secondary600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Main model area with items
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 3D model background (using PNG)
                    Center(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    
                    // Selected top item (if any)
                    if (_selectedTop != null)
                      Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            _selectedTop!.imagePath,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      
                    // Selected bottom item (if any)
                    if (_selectedBottom != null)
                      Positioned(
                        bottom: 120,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            _selectedBottom!.imagePath,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    
                    // Random styling button (left top)
                    Positioned(
                      left: 20,
                      top: 80,
                      child: GestureDetector(
                        onTap: _randomStyle,
                        child: Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE05FD5), // Purple color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shuffle, 
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                'Random',
                                style: CustomTextStyles.regularXs.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Add shirt button (right side)
                    Positioned(
                      right: 20,
                      top: 80,
                      child: GestureDetector(
                        onTap: _addTopItem,
                        child: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8AD958), // Green color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add, 
                                color: Colors.white,
                                size: 24,
                              ),
                              Text(
                                'Add Item',
                                style: CustomTextStyles.regularXs.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Shirt',
                                style: CustomTextStyles.mediumSm.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Add pants button (right bottom)
                    Positioned(
                      right: 20,
                      bottom: 120,
                      child: GestureDetector(
                        onTap: _addBottomItem,
                        child: Row(
                          children: [
                            Text(
                              'Pants',
                              style: CustomTextStyles.mediumSm.copyWith(
                                color: CustomColors.secondary900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Style AI button (right bottom)
                    Positioned(
                      right: 20,
                      bottom: 60,
                      child: GestureDetector(
                        onTap: _styleWithAI,
                        child: Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE05FD5), // Purple color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                'Style AI',
                                style: CustomTextStyles.regularXs.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Loading indicator
                    if (_isLoading)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Bottom navigation bar
              FloatingNavigationBar(),
            ],
          ),
          
          // Draggable Bottom Sheet
          if (_isBottomSheetVisible)
            _buildDraggableBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildDraggableBottomSheet() {
    return DraggableScrollableSheet(
      controller: _draggableController,
      initialChildSize: 0.6, // Start at 60% of screen height
      minChildSize: 0.2,     // Minimum 20% of screen height
      maxChildSize: 0.9,     // Maximum 90% of screen height
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar for dragging
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search your apparel',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _filterItems();
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8AD958),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.grid_view,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Grid of items
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = _filteredItems[index];
                    final isSelected = 
                        (_currentItemType == 'top' && _selectedTop == item) ||
                        (_currentItemType == 'bottom' && _selectedBottom == item);
                    
                    return GestureDetector(
                      onTap: () {
                        _confirmSelection(item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(color: const Color(0xFF8AD958), width: 3)
                              : null,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                item.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF8AD958),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Confirm button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _closeBottomSheet,
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
              ),
              
              // Bottom indicator
              Container(
                width: 50,
                height: 4,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to handle random styling
  void _randomStyle() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call or processing
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
        
        // Randomly select top and bottom items
        final tops = _items.where((item) => item.type == 'top').toList();
        final bottoms = _items.where((item) => item.type == 'bottom').toList();
        
        if (tops.isNotEmpty) {
          _selectedTop = tops[DateTime.now().millisecond % tops.length];
        }
        
        if (bottoms.isNotEmpty) {
          _selectedBottom = bottoms[DateTime.now().millisecond % bottoms.length];
        }
      });
    });
  }

  // Method to handle AI styling
  void _styleWithAI() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call or processing
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _isLoading = false;
        
        // AI would ideally pick a suitable combination
        // For this example, just select the first items
        final tops = _items.where((item) => item.type == 'top').toList();
        final bottoms = _items.where((item) => item.type == 'bottom').toList();
        
        if (tops.isNotEmpty) {
          _selectedTop = tops[0];
        }
        
        if (bottoms.isNotEmpty) {
          _selectedBottom = bottoms[0];
        }
      });
    });
  }
}