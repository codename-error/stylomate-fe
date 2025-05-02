import 'package:flutter/material.dart';
import 'item.dart';

class RecommendationBar extends StatefulWidget {
  const RecommendationBar({super.key});

  @override
  State<RecommendationBar> createState() => _RecommendationBarState();
}

class _RecommendationBarState extends State<RecommendationBar> {
  final List<String> recommendations = [
    'Shirt',
    'T-shirt',
    'Outer',
    'Shoes',
    'Hat',
    'Trouser'
  ];
  
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: 10,
              left: index == 0 ? 2 : 0,
            ),
            child: RecommendationItem(
              text: recommendations[index],
              isActive: index == _activeIndex,
              onTap: () {
                setState(() {
                  _activeIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}