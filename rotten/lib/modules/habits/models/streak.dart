class Streak {
  final String title;
  final int cheatDaysAllowedBeforeStreakReset;
  final List<Session>? sessions;
  final int? currentStreak;
  final DateTime? currentStreakStartDate;
  final int? maxStreak;
  final DateTime? maxStreakStartDate;
  final DateTime? maxStreakEndDate;
  final List<MileStone>? milestonesReached;

  Streak(this.title, this.cheatDaysAllowedBeforeStreakReset,
      {this.sessions,
      this.currentStreak,
      this.maxStreak,
      this.currentStreakStartDate,
      this.maxStreakStartDate,
      this.maxStreakEndDate,
      this.milestonesReached});
}

class Session {
  final DateTime start;
  final DateTime end;

  Session(this.start, this.end);
}

class MileStone {
  final String name;
  final int days;

  MileStone(this.name, this.days);
}
