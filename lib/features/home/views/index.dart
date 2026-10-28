
import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_class/features/home/views/editTask.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final TextEditingController searchController =
      TextEditingController();

  String searchText = '';
  String selectedFilter = 'Today';

  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Do Math Homework',
      'time': 'Today At 16:45',
      'category': 'University',
      'priority': 1,
      'completed': false,
      'color': const Color(0xFF71D5E8),
      'icon': Iconsax.book,
    },
    {
      'title': 'Tack out dogs',
      'time': 'Today At 18:20',
      'category': 'Home',
      'priority': 2,
      'completed': false,
      'color': const Color(0xFFFFAAAA),
      'icon': Iconsax.home,
    },
    {
      'title': 'Business meeting with CEO',
      'time': 'Today At 08:15',
      'category': 'Work',
      'priority': 3,
      'completed': false,
      'color': const Color(0xFFFFD39B),
      'icon': Iconsax.briefcase,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      final matchesSearch = (task['title'] as String)
          .toLowerCase()
          .contains(searchText.toLowerCase());

      final matchesFilter = selectedFilter == 'All'
          ? true
          : selectedFilter == 'Today'
              ? !(task['completed'] as bool)
              : task['completed'] as bool;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white;
    const cardColor = Color(0xFFF1F2F4);
    const mutedColor = Color(0xFF777777);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Index',
          style: AppTextStyles.heading3.copyWith(
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.filter_list, size: 27),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home_outlined),
                        title: const Text('Index'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.calendar_month_outlined,
                        ),
                        title: const Text('Calendar'),
                        onTap: () {
                          Navigator.pop(context);
                          // Connect your Calendar page later.
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text('Profile'),
                        onTap: () {
                          Navigator.pop(context);
                          // Connect your Profile page later.
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                // Connect your Profile page later.
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  'assets/images/backgrounds/images4.jpg',
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
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
                          value: task['completed'] as bool,
                          onChanged: (value) {
                            setState(() {
                              task['completed'] = value ?? false;
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
                                task['title'] as String,
                                style: TextStyle(
                                  color: task['completed'] as bool
                                      ? mutedColor
                                      : Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  decoration:
                                      task['completed'] as bool
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
                                  task['time'] as String,
                                  style: const TextStyle(
                                    color: mutedColor,
                                    fontSize: 14,
                                  ),
                                ),

                                // CHANGED: pushes both containers
                                // toward the right side.
                                const Spacer(),

                                // Category container
                                if ((task['category'] as String)
                                    .isNotEmpty)
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: task['color'] as Color,
                                      borderRadius:
                                          BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          task['icon'] as IconData,
                                          size: 13,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          task['category'] as String,
                                          overflow:
                                              TextOverflow.ellipsis,
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
                                if ((task['priority'] as int) > 0)
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFB0B0B0),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(5),
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
                                          '${task['priority']}',
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

      // No bottomNavigationBar here.
      // Your existing app navigation shell will display it.
    );
  }
}


