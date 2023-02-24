library utils;

import 'package:cloud_firestore/cloud_firestore.dart';

String getDateFromDateTime(DateTime dateTime) {
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
}

bool stringIsValid(String? string) {
  return string != null && string.isNotEmpty && string != '';
}

double getDateNormalized(
    DateTime? startDate, DateTime? endDate, DateTime dateToNormalize) {
  return 0.1;
}

DateTime? getDateTimeFromFirebaseMap(
    Map<String, dynamic> map, String propertyName) {
  return map[propertyName] == null
      ? null
      : (map[propertyName] as Timestamp).toDate();
}
