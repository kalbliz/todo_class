import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/home/views/editTask.dart';
import 'package:todo_class/features/home/views/index.dart';
import 'package:todo_class/features/home/widgets/home_task_card.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/models/todo_model.dart';

/// Home tab inside the bottom-nav shell.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';
  String selectedFilter = 'Today';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<TodoModel> _filteredTasks(List<TodoModel> tasks) {
    var filtered = tasks;

    if (searchText.isNotEmpty) {
      filtered = filtered.where((task) {
        return task.title.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    }

    if (selectedFilter == 'Completed') {
      filtered = filtered.where((task) => task.isCompleted).toList();
    } else if (selectedFilter == 'Today') {
      final now = DateTime.now();
      filtered = filtered.where((task) {
        final due = task.createdAt;
        if (due == null) return true;
        return due.year == now.year &&
            due.month == now.month &&
            due.day == now.day;
      }).toList();
    }

    return filtered;
  }

  Future<void> _onRefresh() => TasksNotifier.instance.load();

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFFF1F2F4);
    const mutedColor = Color(0xFF777777);
    final notifier = TasksNotifier.instance;

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        final tasks = notifier.tasks;
        final filteredTasks = _filteredTasks(tasks);

        debugPrint('--- Home todos (${filteredTasks.length}) ---');
        for (final task in filteredTasks) {
          debugPrint(filteredTasks.toString());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Index'),
            leading: IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(
                      'assets/images/backgrounds/images4.jpg',
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: tasks.isEmpty
              ? RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    children: [
                      Image.asset('assets/images/backgrounds/images3.jpg'),
                      Padding(
                        padding: const EdgeInsets.only(left: 53),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Index(),
                              ),
                            );
                          },
                          child: Text(
                            'What do you want to do today?',
                            style: AppTextStyles.heading3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 103),
                        child: InkWell(
                          onTap: () => AppNavigator.pushTasks(context),
                          child: Text(
                            'Tap + to add you tasks',
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Search for your task...',
                          hintStyle: const TextStyle(
                            color: mutedColor,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: mutedColor,
                            size: 28,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 17,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                              color: Color(0xFFD5D7DA),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                              color: Color(0xFF71D5E8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedFilter,
                              dropdownColor: Colors.white,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black87,
                              ),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                              items: ['Today', 'Completed', 'All']
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedFilter = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.builder(
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
