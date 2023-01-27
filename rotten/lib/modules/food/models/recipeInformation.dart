class RecipeInformation {
  final int? id;
  final String? title;
  final int? serving;
  final int? readyInMinutes;
  final bool? vegetarian;
  final bool? vegan;
  final bool? diaryFree;
  final bool? veryHealthy;
  final bool? cheap;
  final bool? veryPopular;
  final bool? sustainable;
  final int? weightWatcherSmartPoints;
  final String? creditText;
  final String? sourceName;
  final String? sourceUrl;
  final String? summary;
  final String? spoonacularSourceUrl;
  final double? pricePerserving;
  final List<String>? diets;
  final List<RecipeIngredient>? extendedIngredients;
  final List<Instrcutions>? analyzedInstructions;
  
  //*https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51 for information on complex json parsing.
  RecipeInformation({this.id, this.title, this.serving, this.readyInMinutes, this.vegetarian, this.vegan, this.diaryFree, this.veryHealthy, this.cheap, this.veryPopular, this.sustainable, this.weightWatcherSmartPoints, this.creditText, this.sourceName, this.spoonacularSourceUrl, this.pricePerserving, this.sourceUrl, this.summary, this.diets, this.extendedIngredients, this.analyzedInstructions});

  factory RecipeInformation.fromJson(Map<String, dynamic> json) {
    var dietsParsedJson = json['diets'];
    var dietsList = List<String>.from(dietsParsedJson);

    var ingredientListJson = json['extendedIngredients'] as List;
    var instrcutionlistJson = json['analyzedInstructions'] as List;

    var ingredientList = ingredientListJson.map((i) => RecipeIngredient.fromJson(i)).toList();
    var instructionList = instrcutionlistJson.map((i) => Instrcutions.fromJson(i)).toList();

    return RecipeInformation(
      id: json['id'],
      title: json['title'],
      serving: json['servings'],
      readyInMinutes: json['readyInMinutes'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      diaryFree: json['diaryFree'],
      veryHealthy: json['veryHealthy'],
      veryPopular: json['veryPopular'],
      cheap: json['cheap'],
      sustainable: json['sustainable'],
      weightWatcherSmartPoints: json['weightWatcherSmartPoints'],
      creditText: json['creditText'],
      sourceName: json['sourceName'],
      sourceUrl: json['sourceUrl'],
      summary: json['summary'],
      spoonacularSourceUrl: json['spoonacularSourceUrl'],
      pricePerserving: json['pricePerserving'],
      diets: dietsList,
      extendedIngredients: ingredientList,
      analyzedInstructions: instructionList,
    );
  }
}


class RecipeIngredient {
  final int? id;
  final String? aisle;
  final String? name;
  final String? image;
  final double? amount;
  final String? unit;
  final String? unitShort;
  final String? unitLong;
  bool inFridge;

  RecipeIngredient({this.id, this.aisle, this.name, this.amount, this.unit, this.image, this.unitShort, this.unitLong, this.inFridge = false});
  
  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    var amount = json['amount'];
    double? amountDouble = amount != null ? amount.toDouble() : 0;
    return RecipeIngredient(
      id: json['id'], 
      aisle: json['aisle'] , 
      name: json['name'], 
      amount: amountDouble, 
      image: json['image'], 
      unit: json['unit'], 
      unitShort: json['unitShort'], 
      unitLong: json['unitLong']
    );
  }
}

class Instrcutions {
  final String? name;
  final List<InstrucionStep>? steps;

  Instrcutions({this.name, this.steps});

  factory Instrcutions.fromJson(Map<String, dynamic> json) {
    var stepListJson = json['steps'] as List;
    var stepList = stepListJson.map((i) => InstrucionStep.fromJson(i)).toList();

    return Instrcutions(
      name: json['name'],
      steps: stepList,
    );
}
}

class InstrucionStep {
  final int? number;
  final String? step;
  final List<RecipeIngredient>? ingredients;
  bool completed;

  InstrucionStep({this.number, this.step, this.ingredients, this.completed = false});

  factory InstrucionStep.fromJson(Map<String, dynamic> json) {
    var ingredientsJson = json['ingredients'] as List;
    var ingredients = ingredientsJson.map((i) => RecipeIngredient.fromJson(i)).toList();
    return InstrucionStep(
      number: json['number'],
      step: json['step'],
      ingredients: ingredients,
    );
  }
}