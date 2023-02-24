import 'package:flutter/material.dart';
import 'package:rotten/modules/habits/examples/range_example.dart';

import 'basic_example.dart';
import 'complex_example.dart';
import 'events_example.dart';
import 'multi_example.dart';

class CalanderExamples extends StatelessWidget {
  const CalanderExamples({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20.0),
        ElevatedButton(
          child: Text('Basics'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TableBasicsExample()),
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          child: Text('Range Selection'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TableRangeExample()),
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          child: Text('Events'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TableEventsExample()),
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          child: Text('Multiple Selection'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TableMultiExample()),
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          child: Text('Complex'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TableComplexExample()),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
