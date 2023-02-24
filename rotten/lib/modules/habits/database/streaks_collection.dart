import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/streak.dart';

class StreakCollectionOperation {
  StreakCollectionOperation();

  final CollectionReference streakCollection =
      FirebaseFirestore.instance.collection('habits');

  CollectionReference userStreaksCollection(String? userId) {
    return streakCollection.doc(userId).collection('streaks');
  }

  Stream<List<Streak>> getAllUserStreaks(String userId) {
    return userStreaksCollection(userId).snapshots().map(streaksFromSnapshot);
  }

  Future<void> addOrUpdateStreak(
      String userId, String? streakId, Streak newStreak) async {
    await userStreaksCollection(userId).doc(streakId).set(newStreak.toJson());
  }

  List<Streak> streaksFromSnapshot(QuerySnapshot qs) {
    return qs.docs.map((doc) {
      return Streak.fromSnapshot(doc);
    }).toList();
  }
}
