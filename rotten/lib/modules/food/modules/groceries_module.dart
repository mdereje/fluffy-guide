import 'package:flutter/material.dart';

class GroceriesModule extends StatefulWidget {
  GroceriesModule({Key? key}) : super(key: key);

  @override
  State<GroceriesModule> createState() => _GroceriesModuleState();
}

class _GroceriesModuleState extends State<GroceriesModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.abc), Icon(Icons.stacked_bar_chart)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("groceries tab pressed");
        },
        child: Icon(Icons.add),
      ),
      body: Text('Hello'),
    );
  }
}
