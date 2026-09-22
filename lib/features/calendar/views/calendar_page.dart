import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/features/calendar/notifiers/calendar_notifier.dart';

/// Calendar tab inside the bottom-nav shell.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final CalendarNotifier _notifier;

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
          appBar: AppBar(title: const Text('Calendar')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: TableCalendar<void>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2035, 12, 31),
              focusedDay: _notifier.focusedDay,
              selectedDayPredicate: (day) =>
                  isSameDay(_notifier.selectedDay, day),
              onDaySelected: _notifier.onDaySelected,
              onPageChanged: _notifier.onPageChanged,
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
