import 'package:flutter/material.dart';
import 'package:rotten/dummy_data.dart';
import 'package:rotten/modules/food/constants.dart';
import 'package:rotten/modules/food/database/fridge_collection.dart';
import 'package:rotten/modules/food/models/category.dart';
import 'package:rotten/modules/food/models/fridge_item.dart';
import 'package:rotten/modules/food/modules/fridge/add/fridge_add_main.dart';
import 'package:rotten/modules/food/modules/fridge/fridge_tile.dart';

class FridgeModule extends StatefulWidget {
  FridgeModule({Key? key}) : super(key: key);

  @override
  State<FridgeModule> createState() => _FridgeModuleState();
}

class _FridgeModuleState extends State<FridgeModule> {
  var fridgeCollectionOperations = FridgeCollectionOperations();
  // var categoriesStream =
  //     fridgeCollectionOperations.getFridgeItems('test').map((event) {
  //   return categoriesMap.values.map((e) {
  //     e.fridgeItems = event;
  //   });
  // });
  var size = 0;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: fridgeCollectionOperations
            .getFridgeItems('test')
            .map((fridgeItems) => categoryListFromItemList(fridgeItems)),
        builder: (BuildContext context, snapshot) {
          return ListView.separated(
            itemBuilder: (context, index) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                var categories = snapshot.data as List<Category>;
                return categoryTile(categories.elementAt(index));
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: theme.dividerColor,
              );
            },
            itemCount: size,
          );
        },
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

  List<Category>? categoryListFromItemList(List<FridgeItem> items) {
    Map<String, Category> categoriesForDisplay = categoriesMap;

    for (var item in items) {
      categoriesForDisplay.map((key, value) {
        if (key == item.category) {
          if (value.fridgeItems.isEmpty) {
            value.fridgeItems = [item];
          } else {
            value.fridgeItems.add(item);
          }
        }
        return MapEntry(key, value);
      });
    }
    var finalList = categoriesForDisplay.values
        .where((element) => element.fridgeItems.isNotEmpty)
        .toList();
    size = finalList.length;
    return finalList;
  }
}
