import 'package:flutter/material.dart';
import 'package:stylomate/services/test.dart';
import 'package:stylomate/services/wardrobe.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/themes/custom_text_styles.dart';
import 'package:stylomate/themes/custom_icons.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  final TestService _service = TestService.create();
  final WardrobeService _wardrobeService = WardrobeService.create();
  String _responseText = "Loading...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final response = await _service.getPing();
      final wardrobeResponse = await _wardrobeService.getWardrobes();
      setState(() {
        _responseText = response.isSuccessful && wardrobeResponse.isSuccessful
            ? "Ping successful: ${response.body} and ${wardrobeResponse.body}"
            : "Error: ${response.error} (${response.statusCode}) and ${wardrobeResponse.error} (${wardrobeResponse.headers})";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _responseText = "Exception occurred: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.secondary50,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Stylomateicon.chefronleft),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Back',
                  style: CustomTextStyles.semiBoldBase.copyWith(
                    color: CustomColors.secondary900,
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 200,
        ),
        backgroundColor: CustomColors.secondary50,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Settings',
                style: CustomTextStyles.semiBoldXl.copyWith(
                  color: CustomColors.secondary900,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.secondary100,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Stylomateicon.editmodel,
                          color: CustomColors.nd500),
                      title: Text(
                        'Edit model',
                        style: CustomTextStyles.mediumBase.copyWith(
                          color: CustomColors.secondary900,
                        ),
                      ),
                      onTap: () {
                        // Handle tap
                      },
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: CustomColors.secondary100,
                    ),
                    ListTile(
                      leading: Icon(Stylomateicon.price,
                          color: CustomColors.nd500),
                      title: Text(
                        'Pricings',
                        style: CustomTextStyles.mediumBase.copyWith(
                          color: CustomColors.secondary900,
                        ),
                      ),
                      onTap: () {
                        // Handle tap
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Stylomateicon.logout,
                    color: CustomColors.nd500,
                    size: 24,),
                  const SizedBox(width: 8),
                  Text('Log out',
                    style: CustomTextStyles.semiBoldBase.copyWith(
                    color: CustomColors.nd500,
                    ))
                ],
                )),
            ),
           _isLoading 
                ? const CircularProgressIndicator()
                : Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _responseText,
                      style: CustomTextStyles.regularSm.copyWith(
                        color: CustomColors.secondary900,
                      ),
                    ),
                  ),
          ],
        ));
  }
}
