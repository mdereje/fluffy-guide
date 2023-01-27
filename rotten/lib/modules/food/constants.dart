import 'package:rotten/modules/food/models/category.dart';

final categoriesMap = {
  'Other': Category('Other', DateTime.now().add(Duration(days: 1000)), 0, 1000,
      asset: 'assets/images/toilet-paper.png'),
  'Alcohol': Category(
      'Alcohol', DateTime.now().add(Duration(days: 180)), 0, 180,
      asset: 'assets/images/soda.png'),
  'Baking Supplies': Category(
      'Baking Supplies', DateTime.now().add(Duration(days: 180)), 7, 180,
      asset: 'assets/images/wheat.png'),
  'Bread & Baked Goods': Category(
      'Bread & Baked Goods', DateTime.now().add(Duration(days: 7)), 2, 7,
      asset: 'assets/images/bread.png'),
  'Cereal': Category('Cereal', DateTime.now().add(Duration(days: 180)), 10, 180,
      asset: 'assets/images/wheat.png'),
  'Condiments': Category(
      'Condiments', DateTime.now().add(Duration(days: 365)), 10, 365,
      asset: 'assets/images/condiments.png'),
  'Drinks': Category('Drinks', DateTime.now().add(Duration(days: 270)), 7, 270,
      asset: 'assets/images/soda.png'),
  'Frozen': Category('Frozen', DateTime.now().add(Duration(days: 180)), 0, 180,
      asset: 'assets/images/ice-cream.png'),
  'Fruits': Category('Fruits', DateTime.now().add(Duration(days: 7)), 3, 7,
      asset: 'assets/images/harvest.png'),
  'Meat & Deli': Category(
      'Meat & Deli', DateTime.now().add(Duration(days: 10)), 3, 10,
      asset: 'assets/images/meat.png'),
  'Milk & Dairy': Category(
      'Milk & Dairy', DateTime.now().add(Duration(days: 7)), 2, 7,
      asset: 'assets/images/milk.png'),
  'Seafood': Category('Seafood', DateTime.now().add(Duration(days: 3)), 1, 3,
      asset: 'assets/images/meat.png'),
  'Snacks': Category('Snacks', DateTime.now().add(Duration(days: 30)), 7, 30,
      asset: 'assets/images/pickles.png'),
  'Spices': Category(
      'Spices', DateTime.now().add(Duration(days: 1000)), 0, 1000,
      asset: 'assets/images/salt.png'),
  'Vegetables': Category(
      'Vegetables', DateTime.now().add(Duration(days: 7)), 2, 7,
      asset: 'assets/images/vegetables.png')
};
