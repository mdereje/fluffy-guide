import 'package:faker_dart/faker_dart.dart';
import 'package:rotten/common/pie_chart_input_model.dart';
import 'package:rotten/modules/food/constants.dart';
import 'package:rotten/modules/food/models/category.dart';
import 'package:rotten/modules/food/models/fridge_item.dart';

final faker = Faker.instance;

List<InputModel> transactionsSorted = List.generate(10, (index) {
  return InputModel(
    id: faker.datatype.number() + index,
    type: faker.commerce.product(),
    amount: faker.datatype.float(),
    category: faker.commerce.department(),
    description: faker.commerce.productDescription(),
    date: faker.date.past(DateTime.now()).toString(),
  );
});

List<FridgeItem> generateFridgeItems(int size) {
  return List.generate(size, (index) {
    return generateFridgeItem(index);
  });
}

FridgeItem generateFridgeItem(int i) {
  return FridgeItem(faker.datatype.string(), faker.datatype.string(),
      faker.commerce.productName(),
      id: i.toString(),
      quantity: faker.datatype.float(min: 1, max: 10, precision: 1).toInt(),
      volume: faker.datatype.float(min: 100, max: 250, precision: 1).toInt(),
      measurmentType: faker.commerce.productAdjective(),
      category: categoriesMap.entries
          .elementAt(faker.datatype
              .float(
                  min: 0,
                  max: categoriesMap.length.toDouble() - 1,
                  precision: 1)
              .toInt())
          .key,
      storeName: faker.company.companyName(),
      price: faker.datatype.float(min: 0, max: 50, precision: 2),
      dateOfPurchase: faker.date.past(DateTime.now(), rangeInYears: 1),
      expiry: faker.date.future(DateTime.now(), rangeInYears: 2),
      lastModifiedAt: faker.date.past(DateTime.now(), rangeInYears: 1),
      imageUrl: faker.internet.url(),
      categoryChecked: true);
}

List<Category> categories = categoriesMap.values.map((cat) {
  var category = cat;
  int itemCount = faker.datatype.float(min: 0, max: 10, precision: 1).ceil();
  // category.fridgeItems = generateFridgeItems(2);
  category.fridgeItems = generateFridgeItems(itemCount);
  return category;
}).toList();
