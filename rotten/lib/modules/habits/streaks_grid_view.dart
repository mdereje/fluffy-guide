import 'package:flutter/material.dart';
import 'package:rotten/dummy_data.dart';
import 'package:rotten/modules/habits/streak_display_card.dart';

class StreaksGridView extends StatelessWidget {
  const StreaksGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List<Widget>.generate(
            10,
            (index) => StreakDisplayCard(
                num: (index + 1) * 100, s: faker.animal.animal())));
  }
}
