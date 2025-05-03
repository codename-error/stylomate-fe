import 'package:flutter/material.dart';
import 'package:stylomate/services/wardrobe.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/utils/base64_builder.dart';
import 'package:stylomate/widgets/navigation/bar.dart';
import 'package:stylomate/widgets/style_me/random_button.dart';

class WardrobeItem {
  final int id;
  final String imageUrl;
  final String type;

  WardrobeItem({
    required this.id,
    required this.imageUrl,
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
  final TextEditingController _searchController = TextEditingController();
  List<WardrobeItem> _items = [];
  List<WardrobeItem> _filteredItems = [];
  String _currentItemType = 'top';
  final DraggableScrollableController _draggableController =
      DraggableScrollableController();
  bool _isBottomSheetVisible = false;
  final WardrobeService _wardrobeService = WardrobeService.create();

  @override
  void initState() {
    super.initState();
    _loadWardrobes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _draggableController.dispose();
    super.dispose();
  }

  Future<void> _loadWardrobes() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final response = await _wardrobeService.getWardrobes();
      if (response.isSuccessful && response.body != null) {
        setState(() {
          _items = (response.body['data'] as List)
              .map((item) => WardrobeItem(
                    id: item['id'] ?? '',
                    imageUrl: item['image_url'] ?? '',
                    type: item['category'].toString().toLowerCase(),
                  ))
              .toList();
          _updateFilteredItems();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        debugPrint('Failed to load wardrobes: ${response.error}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Failed to load wardrobes: $e');
    }
  }
  
  void _updateFilteredItems() {
    setState(() {
      _filteredItems = _items.where((item) => item.type == _currentItemType).toList();
    });
  }

  // Method to show bottom sheet for top items
  void _addTopItem() {
    setState(() {
      _currentItemType = 'top';
      _searchController.clear();
      _updateFilteredItems();
      _isBottomSheetVisible = true;
    });
  }

  // Method to show bottom sheet for bottom items
  void _addBottomItem() {
    setState(() {
      _currentItemType = 'bottom';
      _searchController.clear();
      _updateFilteredItems();
      _isBottomSheetVisible = true;
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
          // Avatar background
          Center(
            child: Image.asset(
              'assets/images/avatar.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          
          // Main content
          Column(
            children: [
              // Top spacing for status bar
              const SizedBox(height: 72),

              // Header section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    // Selected top item (if any)
                    if (_selectedTop != null)
                      Positioned(
                        top: 160,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            height: 240,
                            child: base64Builder(_selectedTop!.imageUrl),
                          ),
                        ),
                      ),

                    // Selected bottom item (if any)
                    if (_selectedBottom != null)
                      Positioned(
                        bottom: 130,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            height: 250,
                            child: base64Builder(_selectedBottom!.imageUrl),
                          ),
                        ),
                      ),

                    RandomStyleButton(onTap: () {
                      _generateRandomStyle();
                    }),

                    // Add shirt button (right side)
                    Positioned(
                      right: 20,
                      top: 100,
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
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Add bottom button
                    Positioned(
                      right: 20,
                      bottom: 180,
                      child: GestureDetector(
                        onTap: _addBottomItem,
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
                                'Add Bottom',
                                style: CustomTextStyles.regularXs.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    Positioned(
                      right: 20,
                      bottom: 100,
                      child: GestureDetector(
                        onTap: _styleWithAI,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: CustomColors.nd500,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(height: 4),
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
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              FloatingNavigationBar(),
            ],
          ),
          
          // Dark overlay when bottom sheet is visible
          if (_isBottomSheetVisible)
            GestureDetector(
              onTap: _closeBottomSheet,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.7), // Made darker
              ),
            ),
          
          // Bottom sheet
          if (_isBottomSheetVisible) _buildDraggableBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildDraggableBottomSheet() {
    return DraggableScrollableSheet(
      controller: _draggableController,
      initialChildSize: 0.6, // Start at 60% of screen height
      minChildSize: 0.2, // Minimum 20% of screen height
      maxChildSize: 0.9, // Maximum 90% of screen height
      builder: (BuildContext context, ScrollController scrollController) {
        return GestureDetector(
          // This prevents taps on the sheet from closing it
          onTap: () {},
          child: Container(
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

                // Title of the sheet
                Text(
                  _currentItemType == 'top' ? 'Select Top' : 'Select Bottom',
                  style: CustomTextStyles.semiBoldLg,
                ),
                const SizedBox(height: 8),

                // Search bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              // Search functionality would go here
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
                  child: _filteredItems.isEmpty
                      ? Center(
                          child: Text(
                            'No ${_currentItemType} items found',
                            style: CustomTextStyles.regularLg,
                          ),
                        )
                      : GridView.builder(
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
                                (_currentItemType == 'top' && _selectedTop?.id == item.id) ||
                                (_currentItemType == 'bottom' && _selectedBottom?.id == item.id);

                            return GestureDetector(
                              onTap: () {
                                _confirmSelection(item);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                  border: isSelected
                                      ? Border.all(
                                          color: const Color(0xFF8AD958), width: 3)
                                      : null,
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: base64Builder(item.imageUrl),
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
          ),
        );
      },
    );
  }

  // Method to generate a random style
  void _generateRandomStyle() {
    if (_items.isEmpty) return;
    
    setState(() {
      _isLoading = true;
    });

    // Simulate processing time
    Future.delayed(const Duration(milliseconds: 1000), () {
      final tops = _items.where((item) => item.type == 'top').toList();
      final bottoms = _items.where((item) => item.type == 'bottom').toList();
      
      setState(() {
        if (tops.isNotEmpty) {
          _selectedTop = tops[DateTime.now().millisecond % tops.length];
        }
        
        if (bottoms.isNotEmpty) {
          _selectedBottom = bottoms[DateTime.now().millisecond % bottoms.length];
        }
        
        _isLoading = false;
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
