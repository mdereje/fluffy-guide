import 'package:rotten/modules/food/models/fridge_item.dart';

class Category {
  String name;
  DateTime expiry;
  String? description;
  int range;
  int daysAfterPurchase;
  String? asset;
  bool isExpanded;
  List<FridgeItem> fridgeItems;

  Category(this.name, this.expiry, this.range, this.daysAfterPurchase,
      {this.asset,
      this.isExpanded = false,
      this.fridgeItems = const [],
      this.description});
}
