import 'package:flutter/material.dart';
import 'package:rotten/modules/habits/database/streaks_collection.dart';
import 'package:rotten/modules/habits/models/streak.dart';
import 'package:rotten/modules/habits/streak_display_card.dart';

class StreaksGridView extends StatefulWidget {
  const StreaksGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<StreaksGridView> createState() => _StreaksGridViewState();
}

class _StreaksGridViewState extends State<StreaksGridView> {
  var streakCollection = StreakCollectionOperation();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streakCollection.getAllUserStreaks('test'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            var streaks = snapshot.data as List<Streak>;
            return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: List<Widget>.generate(
                    streaks.length,
                    (index) => StreakDisplayCard(
                        num: (index + 1) * 100, s: streaks.elementAt(index))));
          }
        });
  }
}
