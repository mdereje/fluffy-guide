class Category {
  String name;
  DateTime expiry;
  int range;
  int daysAfterPurchase;
  String? asset;
  bool isExpanded;
  Category(this.name, this.expiry, this.range, this.daysAfterPurchase,
      {this.asset, this.isExpanded = false});
}
