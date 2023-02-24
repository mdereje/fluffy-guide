import 'package:flutter/material.dart';
import 'package:rotten/dummy_data.dart';

class TrackNewStreak extends StatelessWidget {
  const TrackNewStreak({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(faker.animal.animal()),
      content: Text(faker.lorem.sentence()),
      actions: [
        TextButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
