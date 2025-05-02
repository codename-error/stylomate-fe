import 'package:flutter/material.dart';
import 'package:stylomate/services/wardrobe.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/utils/base64_builder.dart';
import 'package:stylomate/widgets/card/wardrobe_type.dart';
import 'package:stylomate/widgets/floating/add.dart';

class CollectionContent extends StatefulWidget {
  const CollectionContent({super.key});

  @override
  CollectionContentState createState() => CollectionContentState();
}

class CollectionContentState extends State<CollectionContent>
    with SingleTickerProviderStateMixin {
  final WardrobeService _wardrobeService = WardrobeService.create();
  List<WardrobeType> wardrobes = [];

  @override
  void initState() {
    super.initState();
    _loadWardrobes();
  }

  Future<void> _loadWardrobes() async {
    try {
      final response = await _wardrobeService.getWardrobes();
      if (response.isSuccessful && response.body != null) {
        setState(() {
          wardrobes = (response.body['data'] as List)
              .map((item) => WardrobeType(imageUrl: item['image_url']))
              .toList();
        });
      }
    } catch (e) {
      debugPrint('Failed to load wardrobes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (wardrobes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Stack(children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: wardrobes.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: CustomColors.secondary200,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: base64Builder(wardrobes[index].imageUrl),
              ),
            );
          },
        ),
        FloatingAddButton(
          onTap: () {
            Navigator.pushNamed(context, '/add-wardrobe');
          },
        ),
      ]);
    }
  }
}
