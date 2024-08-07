import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:ler/models/app_settings.dart';
import 'package:ler/models/habit.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  Future<void> saveFirst() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  Future<DateTime?> getFirst() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  final List<Habit> currentHabits = [];
  final List<Habit> newHabits = [];

  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()
      ..name = habitName
      ..isActive = true;
    await isar.writeTxn(() => isar.habits.put(newHabit));
    newHabits.add(newHabit);
    readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> fetchedHabits =
        await isar.habits.filter().isActiveEqualTo(true).findAll();
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);
    notifyListeners();
  }

  Future<void> updateHabitsCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(
        () async {
          if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
            final today = DateTime.now();
            habit.completedDays.add(
              DateTime(
                today.year,
                today.month,
                today.day,
              ),
            );
          } else {
            habit.completedDays.removeWhere((date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day);
          }
          await isar.habits.put(habit);
        },
      );
      final updatedHabit = await isar.habits.get(id);
      if (updatedHabit != null) {
        final index = currentHabits.indexWhere((h) => h.id == id);
        if (index != -1) {
          currentHabits[index] = updatedHabit;
          notifyListeners();
        }
      }
    }
  }

  Future<void> updateHabitsName(int id, String newName) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
      // Refresh only the updated habit
      final updatedHabit = await isar.habits.get(id);
      if (updatedHabit != null) {
        final index = currentHabits.indexWhere((h) => h.id == id);
        if (index != -1) {
          currentHabits[index] = updatedHabit;
          notifyListeners();
        }
      }
    }
  }

  Future<void> deleteHabit(int id) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.isActive = false; // Mark the habit as inactive
        await isar.habits.put(habit);
      });
      // Refresh the list after modification
      readHabits();
    }
  }
}
