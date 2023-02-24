import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rotten/common/utils.dart';

class Streak {
  String title;
  int cheatDaysAllowedBeforeStreakReset;
  int cheatDaysRefreshPeriod;
  bool isSessionized;
  DateTime createdAt;
  List<Session>? sessions;
  int? currentStreak;
  DateTime? currentStreakStartDate;
  int? maxStreak;
  DateTime? maxStreakStartDate;
  DateTime? maxStreakEndDate;
  List<MileStone>? milestonesReached;

  Streak(this.title, this.cheatDaysAllowedBeforeStreakReset,
      this.cheatDaysRefreshPeriod, this.isSessionized, this.createdAt,
      {this.sessions,
      this.currentStreak,
      this.maxStreak,
      this.currentStreakStartDate,
      this.maxStreakStartDate,
      this.maxStreakEndDate,
      this.milestonesReached});

  Streak.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        cheatDaysRefreshPeriod = map['cheatDaysRefreshPeriod'],
        cheatDaysAllowedBeforeStreakReset =
            map['cheatDaysAllowedBeforeStreakReset'],
        isSessionized = map['isSessionized'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        sessions = map['sessions']?.map<Session>((item) {
          return Session.fromMap(item);
        }).toList(),
        currentStreak = map['currentStreak'],
        maxStreak = map['maxStreak'],
        currentStreakStartDate = map['currentStreakStartDate'],
        maxStreakStartDate =
            getDateTimeFromFirebaseMap(map, 'maxStreakStartDate'),
        maxStreakEndDate = getDateTimeFromFirebaseMap(map, 'maxStreakEndDate'),
        milestonesReached = map['milestonesReached']?.map<MileStone>((item) {
          return MileStone.fromMap(item);
        }).toList();

  Streak.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);
}

class Session {
  DateTime start;
  DateTime? end;

  Session(this.start, this.end);

  Session.fromMap(Map<String, dynamic> map)
      : start = (map['start'] as Timestamp).toDate(),
        end = getDateTimeFromFirebaseMap(map, 'end');
}

class MileStone {
  String title;
  int days;

  MileStone(this.title, this.days);

  MileStone.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        days = map['days'];
}
