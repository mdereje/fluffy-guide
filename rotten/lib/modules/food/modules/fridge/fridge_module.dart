import 'package:flutter/material.dart';
import 'package:rotten/dummy_data.dart';
import 'package:rotten/modules/food/models/category.dart';
import 'package:rotten/modules/food/modules/fridge/add/fridge_add_main.dart';
import 'package:rotten/modules/food/modules/fridge/fridge_tile.dart';

class FridgeModule extends StatefulWidget {
  FridgeModule({Key? key}) : super(key: key);

  @override
  State<FridgeModule> createState() => _FridgeModuleState();
}

class _FridgeModuleState extends State<FridgeModule> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return categoryTile(categories.elementAt(index));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: theme.dividerColor,
          );
        },
        itemCount: categories.length,
        // children: List.generate(categories.length, (index) {

        // }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FridgeAddMain()),
          );
        },
        child: Icon(Icons.add),
      ),
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
