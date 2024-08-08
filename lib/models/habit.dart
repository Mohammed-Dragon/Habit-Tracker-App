import 'package:isar/isar.dart';

part 'habit.g.dart';

@Collection()
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  DateTime creationDate = DateTime.now();
  List<DateTime> completedDays = [];
  bool isActive = true;

  List<DateTime> get validCompletedDays {
    DateTime today = DateTime.now();
    return completedDays.where((date) {
      return date.isBefore(today) ||
          (date.year == today.year &&
              date.month == today.month &&
              date.day == today.day);
    }).toList();
  }
}
