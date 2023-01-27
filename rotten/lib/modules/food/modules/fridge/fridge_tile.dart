import 'package:flutter/material.dart';
import 'package:rotten/dummy_data.dart';
import 'package:rotten/modules/food/models/fridge_item.dart';
import 'package:rotten/modules/food/modules/fridge/fridge_item.dart';

class FridgeItemTile extends StatelessWidget {
  final FridgeItem item;
  FridgeItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FridgeItemView(item),
            ),
          );
        },
        onLongPress: () {
          print("long press pressed");
        },
        child: ListTile(
          title: Center(child: Text('${item.name} ')),
          subtitle: Center(
              child: Text(
            item.getExpiryText().text!,
            style: TextStyle(color: item.getExpiryText().color),
          )),
          leading: CircleAvatar(
            backgroundImage: item.imageUrl != null
                ? Image.network(item.imageUrl!).image
                : null,
          ),
          trailing: item.shouldBeEdited() ? Icon(Icons.edit_outlined) : null,
        ));
  }
}
