import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String? id;
  String? collectionId;
  DateTime? activityDate;
  Object? item;
  String? operation;
  String? userId;
  String eventType;

  Record(this.id, this.collectionId, this.activityDate, this.item,
      this.operation, this.userId, this.eventType);

  factory Record.fromMap(
      Map<dynamic, dynamic> map, String id, String eventType) {
    return Record(
        map['id'] = id,
        map['collection_id'],
        map['date'] == null ? null : (map['date'] as Timestamp).toDate(),
        map['newStateJSON'] = map['newStateJSON'],
        map['operation'],
        map['user_id'],
        map['eventType'] = eventType);
  }

  factory Record.fromSnapshot(DocumentSnapshot snapshot, String eventType) =>
      Record.fromMap(
          snapshot.data() as Map<dynamic, dynamic>, snapshot.id, eventType);

  @override
  String toString() => '''
    recordId: $id
    collectionId: $collectionId
    activityDate: $activityDate
    item: ${item.toString()}
    operation: $operation
    userId:$userId
    eventType:$eventType
  ''';
}
