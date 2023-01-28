import 'package:flutter/material.dart';
import 'package:rotten/dummy_data.dart';
import 'package:rotten/modules/food/models/category.dart';
import 'package:rotten/modules/food/modules/fridge/fridge_tile.dart';

class FridgeModule extends StatefulWidget {
  FridgeModule({Key? key}) : super(key: key);

  @override
  State<FridgeModule> createState() => _FridgeModuleState();
}

class _FridgeModuleState extends State<FridgeModule> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(categories.length, (index) {
        return categoryTile(categories.elementAt(index));
      }),
    );
  }

  Widget categoryTile(Category category) {
    return category.fridgeItems.isNotEmpty
        ? ExpansionTile(
            leading: CircleAvatar(backgroundImage: AssetImage(category.asset!)),
            title: Text(category.name),
            subtitle: Text(faker.commerce.productDescription()),
            children: List.generate(category.fridgeItems.length, (index) {
              return FridgeItemTile(category.fridgeItems.elementAt(index));
            }),
          )
        : SizedBox.shrink();
  }
}
