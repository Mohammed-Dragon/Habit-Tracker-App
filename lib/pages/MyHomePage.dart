import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ler/database/habit_database.dart';
import 'package:ler/models/habit.dart';
import 'package:ler/themes/color_provider.dart';
import 'package:ler/themes/theme_provider.dart';
import 'package:ler/util/habit_uril.dart';
import 'package:ler/widgets/heatmap.dart';
import 'package:ler/widgets/hibit_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = [
    const Color.fromARGB(255, 157, 47, 184),
    const Color.fromARGB(255, 76, 77, 220),
    const Color.fromARGB(255, 38, 170, 151),
    const Color.fromARGB(255, 21, 121, 73),
    const Color.fromARGB(255, 50, 182, 72),
    const Color.fromARGB(255, 198, 124, 78),
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
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit_note,
                  color: Theme.of(context).colorScheme.surface,
                  size: MediaQuery.of(context).size.width / 8,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 50,
                bottom: MediaQuery.of(context).size.height / 70,
              ),
              child: Text(
                "New Habit",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 17,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
        content: TextField(
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 23,
          ),
          controller: textController,
          decoration: InputDecoration(
            hintText: "Enter a new habit",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        actions: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 19,
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
                    fontSize: MediaQuery.of(context).size.width / 23,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 150,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 19,
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
                    fontSize: MediaQuery.of(context).size.width / 23,
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
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.surface,
                  size: MediaQuery.of(context).size.width / 10,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 50,
                bottom: MediaQuery.of(context).size.height / 70,
              ),
              child: Text(
                "Edit The Habit",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 17,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
        content: TextField(
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 23,
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 19,
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
                    fontSize: MediaQuery.of(context).size.width / 23,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 150,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 19,
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
                    fontSize: MediaQuery.of(context).size.width / 23,
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
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).colorScheme.surface,
                  size: MediaQuery.of(context).size.width / 10,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 50,
              ),
              child: Text(
                "Delete The Habit",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 17,
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 19,
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
                    fontSize: MediaQuery.of(context).size.width / 23,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 150,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 19,
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
                    fontSize: MediaQuery.of(context).size.width / 23,
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
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 2 / 3,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 15,
                ),
                child: Text(
                  'Habit Tracker',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.orbitron(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: MediaQuery.of(context).size.width / 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 50,
                  bottom: MediaQuery.of(context).size.height / 70,
                ),
                child: Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              ListTile(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                leading: Icon(
                  size: MediaQuery.of(context).size.width / 17,
                  Icons.home,
                  color: Colors.grey,
                ),
                title: Text(
                  "Home Page",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 25,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                trailing: Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(colorProvider),
                ),
                leading: Icon(
                  Provider.of<ThemeProvider>(context).isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: Colors.grey,
                ),
                title: Text(
                  Provider.of<ThemeProvider>(context).isDarkMode
                      ? "Dark Mode"
                      : "Light Mode",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 25,
                  ),
                ),
                onTap: () => Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(colorProvider),
              ),
              ListTile(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton2<Color>(
                    isDense: true,
                    buttonStyleData: ButtonStyleData(
                      height: MediaQuery.of(context).size.height / 22,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      elevation: 0,
                      width: MediaQuery.of(context).size.width / 6,
                      offset: Offset(
                        MediaQuery.of(context).size.width / 18,
                        MediaQuery.of(context).size.height / 17,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 50,
                        ),
                        child: Icon(
                          Icons.circle,
                          size: MediaQuery.of(context).size.width / 12,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
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
                ),
                leading: Icon(
                  size: MediaQuery.of(context).size.width / 17,
                  Icons.color_lens,
                  color: Colors.grey,
                ),
                title: Text(
                  "App Color",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 25,
                  ),
                ),
                onTap: () => {},
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 100,
                ),
                child: ListTile(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  selectedTileColor: Colors.transparent,
                  leading: Icon(
                    Icons.logout,
                    size: MediaQuery.of(context).size.width / 17,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Exit",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                    ),
                  ),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(
            size: MediaQuery.of(context).size.width / 16,
          ),
        ),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width / 8,
          child: FloatingActionButton(
            onPressed: createNewHabit,
            backgroundColor: Theme.of(context).colorScheme.background,
            shape: CircleBorder(),
            child: Icon(
              size: MediaQuery.of(context).size.width / 16,
              Icons.add,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
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
                itemCount: context.watch<HabitDatabase>().currentHabits.length,
                itemBuilder: (context, index) {
                  final habitDatabase = context.watch<HabitDatabase>();
                  List<Habit> currentHabits = habitDatabase.getValidHabits();
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

    List<Habit> validCurrentHabits = habitDatabase.getValidHabits();
    List<Habit> validNewHabits =
        habitDatabase.newHabits.where((habit) => habit.isActive).toList();
    List<Habit> allValidHabits = List.from(validCurrentHabits)
      ..addAll(validNewHabits); // Combine both lists

    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirst(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateTime adjustedStartDate = DateTime(snapshot.data!.year,
              snapshot.data!.month - 1, snapshot.data!.day);
          return MyHeatMap(
            startDate: adjustedStartDate,
            datasets:
                prepHeatMapDataset(allValidHabits), // Use combined valid list
          );
        } else {
          return Container();
        }
      },
    );
  }
}
