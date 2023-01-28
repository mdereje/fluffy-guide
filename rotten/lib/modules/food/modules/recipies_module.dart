import 'package:flutter/material.dart';

class RecipiesModule extends StatefulWidget {
  RecipiesModule({Key? key}) : super(key: key);

  @override
  State<RecipiesModule> createState() => _RecipiesModuleState();
}

class _RecipiesModuleState extends State<RecipiesModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.abc), Icon(Icons.stacked_bar_chart)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("recipies tab pressed");
        },
        child: Icon(Icons.search),
      ),
      body: Text('Hello'),
    );
  }
}
