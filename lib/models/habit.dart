import 'package:isar/isar.dart';

part 'habit.g.dart';

@Collection()
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  DateTime creationDate = DateTime.now();
  List<DateTime> completedDays = [];
  bool isActive = true; // Add isActive field
}
