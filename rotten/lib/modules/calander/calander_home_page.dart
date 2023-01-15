import 'package:flutter/material.dart';

class CalanderHomePage extends StatefulWidget {
  CalanderHomePage({Key? key}) : super(key: key);

  @override
  State<CalanderHomePage> createState() => _CalanderHomePageState();
}

class _CalanderHomePageState extends State<CalanderHomePage> {
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 15)),
        lastDate: DateTime.now().add(Duration(days: 15)),
        onDateChanged: (date) {
          print("$date");
        });
  }
}
