import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotten/common/utils.dart';

class FridgeItem {
  String? id;
  String? collectionId;
  String? addedByUserId;
  String name;
  bool isDeleted;
  DateTime? deletedDate;
  int? quantity;
  int? volume;
  String? measurmentType;
  String? category;
  double? price;
  bool fromScan;
  DateTime? scanDate;
  String? storeName;
  DateTime? dateOfPurchase;
  DateTime? expiry;
  Icon? icon;
  DateTime? lastModifiedAt;
  String? imageUrl;
  bool categoryChecked;

  bool selected; //used for local marking in a widget

  FridgeItem(
      this.collectionId, //Fridge id needs to be auto
      this.addedByUserId,
      this.name,
      {this.id,
      this.quantity = 1,
      this.volume = 1,
      this.measurmentType = 'N/A',
      this.category = 'Other',
      this.fromScan = false,
      this.isDeleted = false,
      this.deletedDate,
      this.scanDate,
      this.storeName,
      this.price = 0.0,
      DateTime? dateNow,
      this.expiry,
      this.imageUrl,
      this.categoryChecked = false,
      this.selected = false})
      : icon = Icon(
          Icons.fastfood,
          color: Colors.primaries[id.hashCode % Colors.primaries.length],
        ),
        dateOfPurchase = dateNow ?? DateTime.now(),
        lastModifiedAt = dateNow ?? DateTime.now();

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'addedByUserId': addedByUserId,
      'name': name,
      'isDeleted': isDeleted,
      'deleteDate': deletedDate,
      'quantity': quantity,
      'volume': volume,
      'measurmentType': measurmentType,
      'category': category,
      'price': price,
      'fromScan': fromScan,
      'scanDate': scanDate,
      'storeName': storeName,
      'dateOfPurchase': dateOfPurchase,
      'expiry': expiry,
      'categoryChecked': categoryChecked,
      'lastModifiedAt': lastModifiedAt,
      'imageUrl': imageUrl,
    };
  }

  dynamic get(String? propertyName) {
    var propertyMap = toJson();
    if (propertyMap.containsKey(propertyName)) {
      return propertyMap[propertyName!];
    } else {
      throw ArgumentError(
          '$propertyName not found as a property in the class FridgeItem');
    }
  }

  List<String> compare(FridgeItem second) {
    var propertyMap = toJson();
    var diffs = <String>[];

    for (var property in propertyMap.keys) {
      if (get(property) != second.get(property)) {
        diffs.add(property);
      }
    }

    return diffs;
  }

  FridgeItem.fromMap(Map<String, dynamic> map, String id)
      : assert(map['name'] != null),
        assert(map['expiry'] != null),
        assert(map['collectionId'] != null),
        assert(map['addedByUserId'] != null),
        id = map['id'] ?? id,
        collectionId = map['collectionId'],
        addedByUserId = map['addedByUserId'],
        name = map['name'],
        isDeleted = map['isDeleted'] ?? false,
        deletedDate = map['deleteDate'] == null
            ? null
            : (map['deleteDate'] as Timestamp).toDate(),
        quantity = map['quantity'],
        volume = map['volume'],
        measurmentType = map['measurmentType'],
        category = map['category'],
        fromScan = map['fromScan'] ?? false,
        scanDate = map['scanDate'] == null
            ? null
            : (map['scanDate'] as Timestamp).toDate(),
        storeName = map['storeName'],
        price = map['price'],
        dateOfPurchase = (map['dateOfPurchase'] as Timestamp).toDate(),
        categoryChecked = map['categoryChecked'] ?? false,
        expiry = (map['expiry'] as Timestamp).toDate(),
        imageUrl = map['imageUrl'],
        lastModifiedAt = map['lastModifiedAt'] == null
            ? null
            : (map['lastModifiedAt'] as Timestamp).toDate(),
        icon = null,
        selected = false;

  FridgeItem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);

  @override
  String toString() => '''
    id: $id 
    name: $name 
    quantity: $quantity 
    volume: $volume
    collectionId: $collectionId 
    addedByUserId: $addedByUserId 
    isDeleted: $isDeleted 
    deleteDate: $deletedDate
    fromScan: $fromScan 
    scanDate: $scanDate 
    storeName: $storeName
    measurmentType: $measurmentType
    category: $category 
    categoryChecked: $categoryChecked 
    price: $price 
    dateOfPurchase: $dateOfPurchase 
    lastModifiedAt: $lastModifiedAt 
    expiry: $expiry 
    imageUrl: $imageUrl;
  ''';

  ExpiryFormat getExpiryText() {
    var now = DateTime.now();
    var durationFromNow = (expiry!.difference(now).inHours / 24).ceil();

    if (durationFromNow == 1) {
      return ExpiryFormat(
          text: 'Item expiring tomorrow!', color: Colors.orangeAccent.shade700);
    } else if (durationFromNow <= 7 && durationFromNow > 1) {
      return ExpiryFormat(
          text: '$durationFromNow days until expiry',
          color: Colors.yellowAccent.shade700);
    } else if (durationFromNow < 1) {
      return ExpiryFormat(
          text: 'Item has expired!', color: Colors.redAccent.shade700);
    } else {
      return ExpiryFormat(
          text: 'Expiry: ${getDateFromDateTime(expiry!)}',
          color: Colors.green.shade700);
    }
  }

  bool shouldBeEdited() {
    var now = DateTime.now();
    if (fromScan && scanDate != null && lastModifiedAt == null) {
      var timeDiff = now.difference(scanDate!).inHours;
      return timeDiff < 1;
    } else {
      return false;
    }
  }
}

class ExpiryFormat {
  String? text;
  Color? color;
  ExpiryFormat({this.text, this.color});
}
