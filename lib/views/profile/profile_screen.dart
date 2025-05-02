import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';
import 'package:stylomate/views/profile/collection_content.dart';
import 'package:stylomate/views/profile/history_content.dart';
import 'package:stylomate/widgets/navigation/bar.dart';
import 'package:stylomate/widgets/user_profile/large.dart';
import 'package:stylomate/widgets/badge/user.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondary50,
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: CustomColors.secondary100,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(40, 40),
                        ),
                        onPressed: () {},
                        child: Icon(
                          Stylomateicon.setting,
                          color: CustomColors.secondary400,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserProfileLarge(),
                        const SizedBox(height: 16),
                        Text(
                          'Zidan Amikul',
                          style: CustomTextStyles.medium3xl.copyWith(
                            color: CustomColors.secondary600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        BadgeUser(
                          icon: Stylomateicon.premium,
                          label: 'Premium user',
                        ),
                        const SizedBox(height: 24),
                        TabBar(
                          controller: _tabController,
                          indicatorColor: CustomColors.primary700,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: CustomColors.primary700,
                          unselectedLabelColor: CustomColors.secondary400,
                          labelStyle: CustomTextStyles.mediumBase,
                          tabs: const [
                            Tab(text: 'Collections'),
                            Tab(text: 'History'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              CollectionContent(),
                              HistoryContent(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FloatingNavigationBar()
        ],
      ),
    );
  }
}
