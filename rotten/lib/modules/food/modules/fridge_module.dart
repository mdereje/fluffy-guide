import 'package:flutter/material.dart';

class FridgeModule extends StatefulWidget {
  FridgeModule({Key? key}) : super(key: key);

  @override
  State<FridgeModule> createState() => _FridgeModuleState();
}

class _FridgeModuleState extends State<FridgeModule> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('ExpansionTile 1'),
      subtitle: Text('Trailing expansion arrow icon'),
      children: <Widget>[
        ListTile(title: Text('This is tile number 1')),
      ],
    );
  }
}
