import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rotten/common/model/record.dart';

class RecordsCollectionOperations {
  final CollectionReference fridgeRecordsCollection = FirebaseFirestore.instance
      .collection('records')
      .doc('fridgeEvents')
      .collection('events');

  final CollectionReference shoppingListRecordsCollection = FirebaseFirestore
      .instance
      .collection('records')
      .doc('shoppingListEvents')
      .collection('events');

  final CollectionReference shoppingItemRecordsCollection = FirebaseFirestore
      .instance
      .collection('records')
      .doc('shoppingItemEvents')
      .collection('events');

  final CollectionReference recipeRecordsCollection = FirebaseFirestore.instance
      .collection('records')
      .doc('recipeEvents')
      .collection('events');

  Future createFridgeItemEvent(String? uid, String? cid, Object json) async {
    return payload(fridgeRecordsCollection, 'CREATE', uid, cid, json);
  }

  Future deleteFridgeItemEvent(String? uid, String? cid, Object json) async {
    return payload(fridgeRecordsCollection, 'DELETE', uid, cid, json);
  }

  Future updateFridgeItemEvent(
      String? uid, String? cid, Object newState, Object? prevState) async {
    return payload(fridgeRecordsCollection, 'UPDATE', uid, cid, newState,
        previousState: prevState);
  }

  Future createShoppingListEvent(String? uid, String cid, Object? json) async {
    return payload(shoppingListRecordsCollection, 'CREATE', uid, cid, json);
  }

  Future deleteShoppingListEvent(String? uid, String? cid, Object? json) async {
    return payload(shoppingListRecordsCollection, 'DELETE', uid, cid, json);
  }

  Future updateShoppingListEvent(String? uid, String? cid, Object json) async {
    return payload(shoppingListRecordsCollection, 'UPDATE', uid, cid, json);
  }

  Future createShoppingItemEvent(String? uid, String? cid, Object json) async {
    return payload(shoppingItemRecordsCollection, 'CREATE', uid, cid, json);
  }

  Future deleteShoppingItemEvent(String? uid, String? cid, Object json) async {
    return payload(shoppingItemRecordsCollection, 'DELETE', uid, cid, json);
  }

  Future updateShoppingItemEvent(String uid, String cid, Object json) async {
    return payload(shoppingItemRecordsCollection, 'UPDATE', uid, cid, json);
  }

  Future createRecipeEvent(String? uid, String? cid, Object json) async {
    return payload(recipeRecordsCollection, 'CREATE', uid, uid, json);
  }

  Future deleteRecipeEvent(String? uid, String? cid, Object json) async {
    return payload(recipeRecordsCollection, 'DELETE', uid, uid, json);
  }

  Stream<List<Record>> getAllFridgeActivities(List<String> collectionIds) {
    return fridgeRecordsCollection
        .where('collection_id', whereIn: collectionIds)
        .where('date', isGreaterThan: DateTime.now().add(-Duration(days: 14)))
        .orderBy('date', descending: true)
        .snapshots()
        .map((qs) => _recordListFromSnapshot(qs, 'foods'));
  }

  List<Record> _recordListFromSnapshot(
      QuerySnapshot snapshot, String eventType) {
    return snapshot.docs.map((doc) {
      return Record.fromSnapshot(doc, eventType);
    }).toList();
  }

  Future payload(CollectionReference collection, String? operation, String? uid,
      String? cid, Object? newState,
      {Object? previousState}) async {
    return await collection.doc().set({
      'date': getDateTime(),
      'gps': 'empty',
      'newStateJSON': newState,
      'prevStateJson': previousState,
      'operation': operation,
      'user_id': uid,
      'collection_id': cid
    });
  }

  FieldValue getDateTime() {
    return FieldValue.serverTimestamp();
  }
}
