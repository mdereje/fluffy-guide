import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rotten/common/database/record_collection.dart';
import 'package:rotten/modules/food/models/fridge_item.dart';

class FridgeCollectionOperations {
  final String? fridgeId;
  String? loggedUID;

  FridgeCollectionOperations({this.fridgeId, this.loggedUID});

  final RecordsCollectionOperations recordsCollectionOperations =
      RecordsCollectionOperations();

  final CollectionReference fridgeCollection =
      FirebaseFirestore.instance.collection('fridges');

  CollectionReference itemsCollection(String? id) {
    return fridgeCollection.doc(id).collection('items');
  }

  Stream<List<FridgeItem>> getFridgeItems(String? uid,
      {bool isDeleted = false}) {
    return itemsCollection(uid ?? fridgeId)
        .where('isDeleted', isEqualTo: isDeleted)
        .snapshots()
        .map(_itemListFromSnapshot);
  }

  Future<List<FridgeItem>> expiredFridgeItems(
      String uid, DateTime lastExpiryDay) async {
    return await itemsCollection(fridgeId).get().then((ds) {
      var fridgeItems = <FridgeItem>[];
      for (var element in ds.docs) {
        var item = FridgeItem.fromSnapshot(element);
        if (item.expiry!.isBefore(lastExpiryDay)) {
          fridgeItems.add(item);
        }
      }
      return fridgeItems;
    });
  }

  // Stream<List<FridgeItem>> getAllFridgeItems(String uid) {
  //   return itemsCollection(uid).snapshots().map(_itemListFromSnapshot);
  // }

  Future<String> getNameOfList(String? fridgeId) async {
    return fridgeCollection.doc(fridgeId).get().then((ds) {
      var name = (ds.data() as Map)['name'] ?? fridgeId;
      return name;
    });
  }

  Future<FridgeItem> getFridgeItemByName(String? fridgeId, String name) async {
    return itemsCollection(fridgeId)
        .where('name', isEqualTo: name)
        .get()
        .then((value) => FridgeItem.fromSnapshot(value.docs.first));
  }

  Future<List<FridgeItem>> getAllFridgeItemsWithMatchingName(
      String? fridgeId, String name) async {
    return itemsCollection(fridgeId)
        .where('name', isEqualTo: name)
        .get()
        .then((value) {
      return value.docs.map((e) => FridgeItem.fromSnapshot(e)).toList();
    });
  }

  List<FridgeItem> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FridgeItem.fromSnapshot(doc);
    }).toList();
  }

  Future<FridgeItem> getSingleFridgeItem(String itemId) {
    return itemsCollection(fridgeId).doc(itemId).get().then((ds) {
      return FridgeItem.fromSnapshot(ds);
    });
  }

// We are going to never delete an item instead set the flag to true.
// We need to make sure all fridgeItems have fridgeId associated within the object.
  Future<void> deleteFridgeItem(FridgeItem item,
      {bool completelyRemove = false}) async {
    item.deletedDate = DateTime.now().toLocal();
    await recordsCollectionOperations.deleteFridgeItemEvent(
        loggedUID, item.collectionId, item.toJson());
    if (completelyRemove) {
      return await itemsCollection(fridgeId).doc(item.id).delete();
    } else {
      var deletedItem = item;
      deletedItem.isDeleted = true;
      item.lastModifiedAt = DateTime.now();
      deletedItem.deletedDate = DateTime.now();
      // Item already tracked as a delete. Turning off upsert track.
      await upsertFridgeItem(deletedItem, track: false);
    }
  }

  Future upsertFridgeItem(FridgeItem item, {bool track = true}) async {
    if (item.id != null) {
      item.lastModifiedAt = DateTime.now();
      await itemsCollection(item.collectionId).doc(item.id).get().then((value) {
        var previousItemState =
            value.data() != null ? FridgeItem.fromSnapshot(value) : null;
        if (track) {
          recordsCollectionOperations.updateFridgeItemEvent(loggedUID,
              item.collectionId, item.toJson(), previousItemState?.toJson());
        }
      });
    } else {
      await recordsCollectionOperations.createFridgeItemEvent(
          loggedUID, item.collectionId, item.toJson());
    }
    return await itemsCollection(item.collectionId)
        .doc(item.id)
        .set(item.toJson());
  }

  Future<int> getNumberOfUsersOnFridgeList(String fridgeId) async {
    return fridgeCollection.doc(fridgeId).get().then((ds) {
      var userIdList = (ds.data() as Map)['userIds'].toString();
      return userIdList.length;
    });
  }

//Can add a smaller user object instead so that we can manage roles.
  Future addUserIdToFridge(String idToAdd, String? shoppingDocumentId) async {
    return await fridgeCollection.doc(shoppingDocumentId).update({
      'userIds': FieldValue.arrayUnion([idToAdd])
    });
  }

  Future<bool> deleteUserIdFromFridge(
      String idToRemove, String shoppingDocumentId) {
    var result = Future.value(true);
    fridgeCollection.doc(shoppingDocumentId).update({
      'userIds': FieldValue.arrayRemove([idToRemove])
    }).catchError((error) {
      result = Future.value(false);
    });
    return result;
  }
}
