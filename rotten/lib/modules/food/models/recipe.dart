class Recipe {
  final int? id;
  final String? title;
  final String? image;
  final int? usedIngredientCount;
  final int? missedIngredientCount;
  final int? likes;

  bool selected;

  Recipe(
      {this.id,
      this.title,
      this.image,
      this.usedIngredientCount,
      this.missedIngredientCount,
      this.likes,
      this.selected = false});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        usedIngredientCount: json['usedIngredientCount'],
        missedIngredientCount: json['missedIngredientCount'],
        selected: json['selected'] ?? false,
        likes: json['likes']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'usedIngredientCount': usedIngredientCount,
        'missedIngredientCount': missedIngredientCount,
        'likes': likes,
        'selected': selected
  };
}
