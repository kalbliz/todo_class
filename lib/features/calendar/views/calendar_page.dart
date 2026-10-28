
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/features/calendar/notifiers/calendar_notifier.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:todo_class/features/calendar/views/calender2.dart';

/// Calendar tab inside the bottom-nav shell.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final CalendarNotifier _notifier;
  int _activeIndex = 0;
  int? _selectedValue = 1;

  @override
  void initState() {
    super.initState();
    _notifier = CalendarNotifier();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _notifier,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Calendar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: Column(
            children: [
              CustomWeekCalendarPage(),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 224, 218, 218),
                  ),
                  padding: const EdgeInsets.all(0),
                  // Optional: container background styling
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          // First Button: Current Page
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // 2. Change color to blue if active, otherwise grey
                                  backgroundColor: _activeIndex == 1
                                      ? Colors.blue
                                      : Colors.grey[400],
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(49),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _activeIndex = 0;
                                  });
                                  // 3. Add your navigation logic for the current page here if needed
                                },
                                child: const Text('Current Page'),
                              ),
                            ),
                          ),

                          // Second Button: New Page
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // 2. Change color to blue if active, otherwise grey
                                  backgroundColor: _activeIndex == 0
                                      ? Colors.blue
                                      : Colors.grey[400],
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(49),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _activeIndex = 1;
                                  });

                                  // 3. Navigate to your new page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Calendar2Page(),
                                    ),
                                  );
                                },
                                child: const Text('New Page'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 218, 218),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child:
                      // [
                      Row(
                    children: [
                      Radio<int>(
                        value: 1, // The unique value assigned to this specific radio button
                        groupValue: _selectedValue, // The currently active choice
                        onChanged: (int? value) {
                          // 2. Wrap the state update inside setState to trigger a redraw
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Do Math Homework",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              Text("Today At 16:45"),
                              SizedBox(
                                width: 25,
                              ),

                              // 1. The Blue Button
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.blue, // Sets button background to blue
                                  foregroundColor:
                                      Colors.white, // Sets text color to white
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 7.5,
                                  ),
                                  fixedSize: const Size(90, 29),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // Adjust the number for more/less roundness
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Iconsax.book),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "University",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ), // Adds spacing between the two buttons

                              // 2. The Transparent / Outlined Button
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      Colors.blue, // Sets text and border color
                                  side: const BorderSide(
                                    color: Colors.blue,
                                  ), // Blue border outline
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 7.5,
                                  ),
                                  fixedSize: const Size(20, 25),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // Adjust the number for more/less roundness
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Iconsax.flag),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "1",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomWeekCalendarPage extends StatefulWidget {
  const CustomWeekCalendarPage({super.key});

  @override
  State<CustomWeekCalendarPage> createState() =>
      _CustomWeekCalendarPageState();
}

class _CustomWeekCalendarPageState extends State<CustomWeekCalendarPage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // FIX: In 0.0.7, you must wrap the calendar in a sized container inside Columns
          SizedBox(
            height: 125, // Safely accommodates the top navbar and day items
            child: HorizontalWeekCalendar(
              minDate: DateTime.now().subtract(
                const Duration(days: 30),
              ),
              maxDate: DateTime.now().add(
                const Duration(days: 30),
              ),
              initialDate: selectedDate,
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
              monthColor: Colors.indigo,
              activeBackgroundColor: Colors.indigo,
              activeTextColor: Colors.white,
              inactiveBackgroundColor: Colors.indigo.withOpacity(0.08),
              inactiveTextColor: Colors.indigo,
              disabledBackgroundColor: Colors.grey.shade200,
              disabledTextColor: Colors.grey,
              weekStartFrom: WeekStartFrom.Monday,
            ),
          ),

          // const SizedBox(height: 40),
          // Text(
          //   "Selected Date:",
          //   style: TextStyle(color: Colors.grey[600], fontSize: 14),
          // ),
          // Text(
          //   "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
          //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
