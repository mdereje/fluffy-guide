import 'package:flutter/material.dart';
import 'package:rotten/modules/habits/add_session_alert_dialog.dart';
import 'package:rotten/modules/habits/database/streaks_collection.dart';
import 'package:rotten/modules/habits/models/streak.dart';

class StreakDisplayCard extends StatelessWidget {
  final int num;
  final Streak s;
  StreakDisplayCard({
    Key? key,
    required this.num,
    required this.s,
  }) : super(key: key);

  final streakCollection = StreakCollectionOperation();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[num],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                // Unsplash url saved takes only one keyword (faker)
                backgroundImage: Image.network(s.imageUrl!).image,
              ),
              Spacer(),
              Text(
                s.title,
                textAlign: TextAlign.end,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          ),

          Spacer(),
          ElevatedButton.icon(
              onPressed: () => showDialog<Streak>(
                    context: context,
                    builder: (BuildContext context) => SessionAlertDialog(
                      s: s,
                    ),
                  ).then((updatedStreak) {
                    streakCollection
                        .addOrUpdateStreak(
                            'test', updatedStreak?.id, updatedStreak!)
                        .whenComplete(() {
                      Duration? duration = updatedStreak.sessions?.last.end
                          ?.difference(
                              updatedStreak.sessions?.last.start as DateTime);
                      final snackBar = SnackBar(
                        content: Text(
                            '${duration?.inMinutes} min session added to ${updatedStreak.title}'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                            // Delete last session
                            Streak undoStreakSessionAdd = updatedStreak;
                            undoStreakSessionAdd.sessions?.removeLast();
                            streakCollection.addOrUpdateStreak(
                                'test', updatedStreak.id, undoStreakSessionAdd);
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }),
              icon: Icon(Icons.note_add),
              label: Text('Session'))
          // TableMultiExample()
        ],
      ),
    );
  }
}
