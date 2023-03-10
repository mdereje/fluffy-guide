library utils;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

DateTime dateTimeFromTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
}
