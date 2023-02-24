import 'package:flutter/material.dart';
import 'package:rotten/modules/habits/streaks_grid_view.dart';
import 'package:rotten/modules/habits/track_new_streak_form.dart';

class HabitsHomePage extends StatefulWidget {
  const HabitsHomePage({Key? key}) : super(key: key);

  @override
  State<HabitsHomePage> createState() => _HabitsHomePageState();
}

class _HabitsHomePageState extends State<HabitsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Track streaks'),
        ),
        body: StreaksGridView(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: ((context) {
                  return TrackNewStreakForm();
                }));
          },
          label: Row(children: [Icon(Icons.add), Text('Track New')]),
        ));
  }
}
