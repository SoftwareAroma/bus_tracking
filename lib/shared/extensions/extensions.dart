import 'package:recase/recase.dart';

/// custom extension to capitalize text
/// use [ReCase] package to convert text to to other cases
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => ReCase(this).titleCase;
  String toSnakeCase() => ReCase(this).snakeCase;
}

/// extension on data
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
}
