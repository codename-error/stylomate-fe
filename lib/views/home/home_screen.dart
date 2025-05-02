import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/widgets/search_recommendation.dart';
import 'package:stylomate/widgets/reccomendation_bar/bar.dart';
import 'package:stylomate/widgets/reccomendation/grid.dart';
import 'package:stylomate/widgets/navigation/bar.dart';
import 'package:stylomate/widgets/user_profile/small.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.secondary50,
        body: Stack(
          children: [
            Image.asset('assets/images/bg siang.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * (263 / 394),
                fit: BoxFit.cover),
            Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 64),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserProfileSmall(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 8),
                            decoration: BoxDecoration(
                              color: CustomColors.nd100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/point hd.png',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '24',
                                  style: CustomTextStyles.semiBoldBase.copyWith(
                                    color: CustomColors.nd500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/banner.png',
                          width: double.infinity,
                          height: 110,
                        ),
                      ),
                      SearchWidget(),
                      RecommendationBar(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular',
                            style: CustomTextStyles.mediumXl
                                .copyWith(color: CustomColors.secondary500),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See all',
                              style: CustomTextStyles.mediumBase
                                  .copyWith(color: CustomColors.primary700),
                            ),
                          )
                        ],
                      ),
                      const RecommendationGrid(),
                    ],
                  )),
            ),
            FloatingNavigationBar()
          ],
        ));
  }
}
