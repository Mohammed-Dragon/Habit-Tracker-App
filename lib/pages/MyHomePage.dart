import 'package:flutter/material.dart';
import 'package:ler/database/habit_database.dart';
import 'package:ler/models/habit.dart';
import 'package:ler/themes/color_provider.dart';
import 'package:ler/themes/theme_provider.dart';
import 'package:ler/util/habit_uril.dart';
import 'package:ler/widgets/heatmap.dart';
import 'package:ler/widgets/hibit_tile.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int R = 20, G = 195, B = 29;

  List<Color> colors = [
    Color.fromARGB(255, 157, 47, 184),
    Color.fromARGB(255, 76, 77, 220),
    Color.fromARGB(255, 38, 170, 151),
    Color.fromARGB(255, 21, 121, 73),
    Color.fromARGB(255, 50, 182, 72),
    Color.fromARGB(255, 198, 124, 78),
  ];
  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  final TextEditingController textController = TextEditingController();

  void createNewHabit() {
    textController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit_note,
                  color: Theme.of(context).colorScheme.surface,
                  size: 50.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "New Habit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(
                fontSize: 17,
              ),
              controller: textController,
              decoration: InputDecoration(
                hintText: "Enter a new habit",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  String newHabitName = textController.text;
                  context.read<HabitDatabase>().addHabit(newHabitName);
                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 1,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitsCompletion(habit.id, value);
    }
  }

  void editHabitBox(Habit habit) {
    textController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.surface,
                  size: 40.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Edit The Habit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
        content: TextField(
          style: TextStyle(
            fontSize: 17,
          ),
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        actions: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  String newHabitName = textController.text;
                  context
                      .read<HabitDatabase>()
                      .updateHabitsName(habit.id, newHabitName);
                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 1,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  void deleteHabitBox(Habit habit) {
    textController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).colorScheme.surface,
                  size: 50.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Delete The Habit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to delete this habit?",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          Column(
            children: [
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  print(
                      'Before deletion: ${context.read<HabitDatabase>().currentHabits.length}');

                  await context.read<HabitDatabase>().deleteHabit(habit.id);

                  print(
                      'After deletion: ${context.read<HabitDatabase>().currentHabits.length}');

                  Navigator.pop(context);
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 1,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorProvider>(
      builder: (context, colorProvider, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Switch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(colorProvider),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Color>(
                    icon: Icon(
                      Icons.circle,
                      size: 35,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    onChanged: (Color? newColor) {
                      if (newColor != null) {
                        Provider.of<ColorProvider>(context, listen: false)
                            .updateThemeColor(
                          newColor,
                          Provider.of<ThemeProvider>(context, listen: false)
                              .isDarkMode,
                          context,
                        );
                      }
                    },
                    items: colors
                        .map((color) => DropdownMenuItem<Color>(
                              value: color,
                              child: CircleAvatar(
                                backgroundColor: color,
                              ),
                            ))
                        .toList(),
                  ),
                )),
          ],
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewHabit,
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildHeatMap(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    context.watch<HabitDatabase>().currentHabits.length, //
                itemBuilder: (context, index) {
                  final habitDatabase = context.watch<HabitDatabase>();
                  List<Habit> currentHabits = habitDatabase.currentHabits; //
                  final habit = currentHabits[index];
                  bool isCompletedToday =
                      isHabitCompletedToday(habit.completedDays);
                  return MyHabitTile(
                    isCompleted: isCompletedToday,
                    text: habit.name,
                    onChanged: (value) => checkHabitOnOff(value, habit),
                    editHabit: (context) => editHabitBox(habit),
                    deleteHabit: (context) => deleteHabitBox(habit),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeatMap() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    List<Habit> newHabits = habitDatabase.newHabits;
    List<Habit> allHabits = List.from(currentHabits)
      ..addAll(newHabits); // Combine both lists

    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirst(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateTime adjustedStartDate = DateTime(snapshot.data!.year,
              snapshot.data!.month - 1, snapshot.data!.day);
          return MyHeatMap(
            startDate: adjustedStartDate,
            datasets: prepHeatMapDataset(allHabits), // Use combined list
          );
        } else {
          return Container();
        }
      },
    );
  }
}
