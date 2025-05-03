import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';

class SelectWardrobeItemScreen extends StatefulWidget {
  final String itemType; // "top" or "bottom"
  final String backgroundImagePath;
  
  const SelectWardrobeItemScreen({
    super.key, 
    required this.itemType,
    required this.backgroundImagePath,
  });

  @override
  SelectWardrobeItemScreenState createState() => SelectWardrobeItemScreenState();
}

class SelectWardrobeItemScreenState extends State<SelectWardrobeItemScreen> {
  // State variables
  List<WardrobeItem> _items = [];
  final List<WardrobeItem> _selectedItems = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWardrobeItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Load wardrobe items from database or API
  Future<void> _loadWardrobeItems() async {
    // Simulate loading items
    await Future.delayed(const Duration(milliseconds: 600));
    
    setState(() {
      _isLoading = false;
      
      // Mock data for demonstration
      if (widget.itemType == 'top') {
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
        ];
      } else {
        _items = [
          WardrobeItem(
            id: '3',
            name: 'Blue Jeans',
            imagePath: 'assets/images/blue_jeans.png',
            type: 'bottom',
          ),
          WardrobeItem(
            id: '4',
            name: 'Black Pants',
            imagePath: 'assets/images/black_pants.png',
            type: 'bottom',
          ),
        ];
      }
    });
  }

  void _toggleItemSelection(WardrobeItem item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.clear(); // Single selection mode
        _selectedItems.add(item);
      }
    });
  }

  void _confirmSelection() {
    if (_selectedItems.isNotEmpty) {
      Navigator.pop(context, _selectedItems.first);
    } else {
      Navigator.pop(context);
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Back',
          style: CustomTextStyles.regularBase.copyWith(
            color: CustomColors.secondary900,
          ),
        ),
        titleSpacing: 0,
        leadingWidth: 40,
      ),
      body: Stack(
        children: [
          // Zoomed background
          Positioned.fill(
            child: Transform.scale(
              scale: 1.2, // Zoom effect
              child: Image.asset(
                widget.backgroundImagePath,
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.9), // Add a white overlay
                colorBlendMode: BlendMode.lighten,
              ),
            ),
          ),
          
          // Content
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // Top section with search field
                    Container(
                      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
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
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
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
                    
                    // Grid of items
                    Expanded(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                final item = _items[index];
                                final isSelected = _selectedItems.contains(item);
                                
                                return GestureDetector(
                                  onTap: () => _toggleItemSelection(item),
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
                  ],
                ),
              ),
              
              // Confirm button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _confirmSelection,
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
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Model class for wardrobe items
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