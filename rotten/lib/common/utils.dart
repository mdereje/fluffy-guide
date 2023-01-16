library utils;

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
