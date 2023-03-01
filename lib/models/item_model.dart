import 'package:intl/intl.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.image,
    required this.dateTime,
  });

  final String id;
  final String name;
  final String gender;
  final String image;
  final DateTime dateTime;

  double myAge() {
    return dateTime.difference(DateTime.now()).inDays / 30;
  }

  String selectedDateFormatted() {
    return DateFormat.yMMMEd().format(dateTime);
  }
}
