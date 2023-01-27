import 'package:flutter/material.dart';
import 'package:rotten/dummy_data.dart';

class FridgeModule extends StatefulWidget {
  FridgeModule({Key? key}) : super(key: key);

  @override
  State<FridgeModule> createState() => _FridgeModuleState();
}

class _FridgeModuleState extends State<FridgeModule> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(fridgeItems.length, (index) {
        return tile();
      }),
    );
  }

  Widget tile() {
    return ExpansionTile(
      title: Text('ExpansionTile 1'),
      subtitle: Text('Trailing expansion arrow icon'),
      children: <Widget>[
        ListTile(title: Text('This is tile number 1')),
      ],
    );
  }
}
