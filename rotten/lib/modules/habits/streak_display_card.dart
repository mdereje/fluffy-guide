import 'package:flutter/material.dart';
import 'package:rotten/modules/habits/models/streak.dart';

class StreakDisplayCard extends StatelessWidget {
  final int num;
  final Streak s;
  const StreakDisplayCard({
    Key? key,
    required this.num,
    required this.s,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[num],
      child: Text(s.title),
    );
  }
}
