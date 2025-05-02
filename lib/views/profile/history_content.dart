import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_colors.dart';
import 'package:stylomate/widgets/card/history_type.dart';
import 'package:stylomate/widgets/card/history.dart';


class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  HistoryContentState createState() => HistoryContentState();
}

class HistoryContentState extends State<HistoryContent>
    with SingleTickerProviderStateMixin {
  final List<HistoryType> histories = [
    HistoryType(date: DateTime(2025, 05, 1), serviceTitle: 'Stylo AI', tokenActivity: 5, isDecreased: true),
    HistoryType(date: DateTime(2025, 05, 1), serviceTitle: 'Style me', tokenActivity: 5, isDecreased: true),
    HistoryType(date: DateTime(2025, 05, 1), serviceTitle: 'Share', tokenActivity: 5, isDecreased: false),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: histories.length,
            itemBuilder: (context, index) {
              return HistoryCard(
                serviceTitle: histories[index].serviceTitle,
                tokenActivity: histories[index].tokenActivity,
                date: histories[index].date,
                isDecreased: histories[index].isDecreased,
              );
            },
          ),
        ],
      ),
    );
  }
}
