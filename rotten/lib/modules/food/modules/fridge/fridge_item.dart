import 'package:flutter/material.dart';
import 'package:rotten/modules/food/models/fridge_item.dart';

class FridgeItemView extends StatefulWidget {
  final FridgeItem item;
  final String fridgeId;

  FridgeItemView(this.item, this.fridgeId, {Key? key}) : super(key: key);

  @override
  State<FridgeItemView> createState() => _FridgeItemViewState();
}

class _FridgeItemViewState extends State<FridgeItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name)),
      body: Column(
        children: [
          Center(
              child: CircleAvatar(
            radius: 50,
            backgroundImage: widget.item.imageUrl != null
                ? Image.network(widget.item.imageUrl!).image
                : null,
          )),
          Text(
            'Item expired',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fridgeTileFab',
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container();
              });
        },
        child: Icon(Icons.list),
      ),
    );
  }
}
