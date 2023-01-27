import 'package:faker_dart/faker_dart.dart';
import 'package:rotten/common/pie_chart_input_model.dart';
import 'package:rotten/modules/food/constants.dart';
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

List<FridgeItem> fridgeItems = List.generate(10, (index) {
  return FridgeItem(faker.datatype.string(), faker.datatype.string(),
      faker.commerce.productName(),
      id: faker.datatype.string(length: 5),
      quantity: faker.datatype.float(min: 1, max: 10, precision: 0).toInt(),
      volume: faker.datatype.float(min: 100, max: 250, precision: 0).toInt(),
      measurmentType: faker.commerce.productAdjective(),
      category: categories[faker.datatype
              .float(
                  min: 0, max: categories.length.toDouble() - 1, precision: 0)
              .toInt()]
          ?.name,
      storeName: faker.company.companyName(),
      price: faker.datatype.float(min: 0, max: 50, precision: 2),
      dateOfPurchase: faker.date.past(DateTime.now(), rangeInYears: 1),
      expiry: faker.date.future(DateTime.now(), rangeInYears: 2),
      lastModifiedAt: faker.date.past(DateTime.now(), rangeInYears: 1),
      imageUrl: faker.internet.url(),
      categoryChecked: true);
});
