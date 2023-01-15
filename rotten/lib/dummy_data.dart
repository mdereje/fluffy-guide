import 'package:faker_dart/faker_dart.dart';
import 'package:rotten/common/pie_chart_input_model.dart';

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
