import 'package:flutter/material.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:todo_class/features/calendar/views/calender2.dart';
import 'package:todo_class/features/home/views/editTask.dart';
import 'package:todo_class/features/home/widgets/home_task_card.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/models/todo_model.dart';

/// Calendar tab inside the bottom-nav shell.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  /// Always starts on today.
  DateTime _selectedDate = DateTime.now();
  int _activeIndex = 0;

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Tasks whose [TodoModel.dueDate] falls on [_selectedDate].
  List<TodoModel> _tasksForSelectedDate(List<TodoModel> tasks) {
    return tasks.where((task) {
      final due = task.dueDate;
      if (due == null) return false;
      return _isSameDay(due, _selectedDate);
    }).toList();
  }

  void _onDateChanged(DateTime date) {
    setState(() => _selectedDate = date);
  }

  Future<void> _onRefresh() => TasksNotifier.instance.load();

  @override
  Widget build(BuildContext context) {
    final notifier = TasksNotifier.instance;

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        final filteredTasks = _tasksForSelectedDate(notifier.tasks);

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
              _WeekCalendar(
                selectedDate: _selectedDate,
                onDateChange: _onDateChanged,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 224, 218, 218),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _activeIndex == 0
                                    ? Colors.blue
                                    : Colors.grey[400],
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(49),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () {
                                setState(() => _activeIndex = 0);
                              },
                              child: const Text('Current Page'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _activeIndex == 1
                                    ? Colors.blue
                                    : Colors.grey[400],
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(49),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () {
                                setState(() => _activeIndex = 1);
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
              const SizedBox(height: 16),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: filteredTasks.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          children: [
                            const SizedBox(height: 48),
                            Text(
                              'No tasks due on '
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = filteredTasks[index];
                            return HomeTaskCard(
                              task: task,
                              onToggleComplete: (_) =>
                                  notifier.toggleComplete(task.id),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EditTask(),
                                  ),
                                );
                              },
                            );
                          },
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

class _WeekCalendar extends StatelessWidget {
  const _WeekCalendar({
    required this.selectedDate,
    required this.onDateChange,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChange;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 125,
        child: HorizontalWeekCalendar(
          minDate: today.subtract(const Duration(days: 30)),
          maxDate: today.add(const Duration(days: 30)),
          initialDate: selectedDate,
          onDateChange: onDateChange,
          monthColor: Colors.indigo,
          activeBackgroundColor: Colors.indigo,
          activeTextColor: Colors.white,
          inactiveBackgroundColor: Colors.indigo.withValues(alpha: 0.08),
          inactiveTextColor: Colors.indigo,
          disabledBackgroundColor: Colors.grey.shade200,
          disabledTextColor: Colors.grey,
          weekStartFrom: WeekStartFrom.Monday,
        ),
      ),
    );
  }
}
