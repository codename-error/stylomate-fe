import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/widgets/card/wardrobe_type.dart';


class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  HistoryContentState createState() => HistoryContentState();
}

class HistoryContentState extends State<HistoryContent>
    with SingleTickerProviderStateMixin {
  final List<WardrobeType> wardrobes = [
    WardrobeType(
      imageUrl: 'assets/images/apparel-1.png',
    ),
    WardrobeType(
      imageUrl: 'assets/images/apparel-2.png',
    ),
    WardrobeType(
      imageUrl: 'assets/images/apparel-3.png',
    ),
    WardrobeType(
      imageUrl: 'assets/images/apparel-4.png',
    ),
    WardrobeType(
      imageUrl: 'assets/images/apparel-1.png',
    ),
    WardrobeType(
      imageUrl: 'assets/images/apparel-2.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                child: Image.asset(
                  wardrobes[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
  }
}
