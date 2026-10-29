import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/home/views/editTask.dart';
import 'package:todo_class/features/home/views/index.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/models/todo_model.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';
import 'package:todo_class/utils/buttons/app_button.dart';

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
  final List<TodoModel> tasks = [];
  final List<TodoModel> filteredTasksByDay = [];

  Future<void> readTaskList() async {
    await LocalStorageService.instance.init();
    final loadedTasks = TasksNotifier.instance.tasks;
    setState(() {
      tasks.clear();
      tasks.addAll(loadedTasks);
    });
  }

  Future<void> filterTasksByDate() async {
    filteredTasksByDay.addAll(
      tasks.where((task) {
        return task.dueDate?.day == DateTime.now().day &&
            task.dueDate?.month == DateTime.now().month &&
            task.dueDate?.year == DateTime.now().year;
      }).toList(),
    );
    setState(() {
      filteredTasksByDay;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<TodoModel> get filteredTasks {
    List<TodoModel> filtered = tasks;

    if (searchText.isNotEmpty) {
      filtered = filtered.where((task) {
        final title = (task.title).toLowerCase();
        return title.contains(searchText.toLowerCase());
      }).toList();
    }

    if (selectedFilter == 'Today') {
      // Filter tasks for today
      filtered = filtered.where((task) {
        // Implement your logic to filter today's tasks
        return true; // Placeholder, replace with actual condition
      }).toList();
    } else if (selectedFilter == 'Completed') {
      // Filter completed tasks
      filtered = filtered.where((task) => task.isCompleted).toList();
    }

    return filtered;
  }

  @override
  void initState() {
    readTaskList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    readTaskList();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white;
    const cardColor = Color(0xFFF1F2F4);
    const mutedColor = Color(0xFF777777);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index'),
        leading: IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // Handle navigation drawer or back action
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Handle profile tap
              },
              child: const CircleAvatar(
                radius: 18, // Adjust the size as needed
                backgroundImage: AssetImage(
                  'assets/images/backgrounds/images4.jpg',
                ), // Your local asset path
              ),
            ),
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/images/backgrounds/images3.jpg"),
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
                  const SizedBox(height: 24),
                  // AppButton(
                  //   label: 'View all tasks',
                  //   onPressed: () => AppNavigator.pushTasks(context),
                  // ),
                  // const SizedBox(height: 12),
                  // AppOutlinedButton(
                  //   label: 'View stats',
                  //   onPressed: () => AppNavigator.pushStats(context),
                  // ),
                ],
              ),
            )
          : Column(
              children: [
                // Search bar
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 17),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Color(0xFFD5D7DA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Color(0xFF71D5E8)),
                      ),
                    ),
                  ),
                ),

                // Today / Completed filter
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

                // Task list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // Task completion checkbox
                            SizedBox(
                              width: 35,
                              child: Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) {
                                  setState(() {
                                    task.isCompleted = value ?? false;
                                  });
                                },
                                shape: const CircleBorder(),
                                side: const BorderSide(
                                  color: Color(0xFF888888),
                                  width: 1.7,
                                ),
                                activeColor: const Color(0xFF71D5E8),
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Task title and time
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EditTask(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      task.title,
                                      style: TextStyle(
                                        color: task.isCompleted
                                            ? mutedColor
                                            : Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        decoration: task.isCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      // Task time
                                      Text(
                                        "${task.dueDate?.hour.toString().padLeft(2, '0')}:${task.dueDate?.minute.toString().padLeft(2, '0')}",
                                        style: const TextStyle(
                                          color: mutedColor,
                                          fontSize: 14,
                                        ),
                                      ),

                                      // CHANGED: pushes both containers
                                      // toward the right side.
                                      const Spacer(),

                                      // Category container
                                      if ((task.categoryId as String)
                                          .isNotEmpty)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 7,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                task.category?.color ??
                                                Colors.grey,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(width: 3),
                                              Text(
                                                task.category?.name ??
                                                    'Uncategorized',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      const SizedBox(width: 7),

                                      // Priority container
                                      if ((task.priority) > 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 7,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFB0B0B0),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.flag_outlined,
                                                size: 15,
                                                color: mutedColor,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${task.priority}',
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
