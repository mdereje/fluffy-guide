import 'package:flutter/material.dart';
import 'package:rotten/common/tab_navigator.dart';
import 'package:rotten/modules/food/modules/fridge/fridge_module.dart';
import 'package:rotten/modules/food/modules/groceries_module.dart';
import 'package:rotten/modules/food/modules/recipies_module.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({Key? key}) : super(key: key);

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(
              tabs: List.generate(
                navigation.length,
                (index) => Tab(
                    icon: navigation.elementAt(index).icon,
                    text: navigation.elementAt(index).label),
              ),
            )),
        body: TabBarView(
          children: List.generate(
              navigation.length, (index) => navigation.elementAt(index).page),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {print("pressed")},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

final List<TabNavigator> navigation = [
  TabNavigator(Icon(Icons.food_bank), 'Fridge', FridgeModule()),
  TabNavigator(Icon(Icons.restaurant_menu), 'Recipies', RecipiesModule()),
  TabNavigator(Icon(Icons.list), 'Groceries', GroceriesModule()),
];
