import 'package:flutter/material.dart';

class FridgeAddMain extends StatelessWidget {
  const FridgeAddMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add to fridge')),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 2,
              ),
              choiceCard(context),
              SizedBox(
                height: 2,
              ),
            ],
          ),
        ));
  }

  Widget choiceCard(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('Add manually'),
            subtitle: Text('Add a new fridge item manually from scratch'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Add from previous'),
                onPressed: () {
                  print("add from previous");
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Add new'),
                onPressed: () {
                  print("add from scratch");
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
