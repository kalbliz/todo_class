
// import 'package:flutter/material.dart';

// import 'package:todo_class/core/router/app_navigator.dart';
// import 'package:todo_class/core/theme/app_text_styles.dart';
// import 'package:todo_class/features/home/views/editTask.dart';
// import 'package:todo_class/features/home/views/index.dart';
// import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
// import 'package:todo_class/models/todo_model.dart';
// import 'package:todo_class/services/storage/local_storage_service.dart';


// // ============================================================
// // 1. HOME CONTROLLER
// // ============================================================

// /// Manages the HomePage state and business logic.
// ///
// /// This class handles:
// /// - Loading tasks from local storage.
// /// - Searching for tasks.
// /// - Filtering tasks.
// /// - Updating task completion status.
// ///
// /// ChangeNotifier allows the UI to rebuild whenever the state changes.
// class HomeController extends ChangeNotifier {

//   // Stores all tasks loaded from the task notifier.
//   List<TodoModel> _tasks = [];

//   // Stores the text entered into the search field.
//   String _searchText = '';

//   // Stores the currently selected task filter.
//   String _selectedFilter = 'Today';

//   // Indicates whether tasks are currently being loaded.
//   bool _isLoading = false;

//   // Stores an error message if loading tasks fails.
//   String? _errorMessage;


//   // ----------------------------------------------------------
//   // GETTERS
//   // ----------------------------------------------------------

//   /// Returns the complete list of tasks.
//   List<TodoModel> get tasks => _tasks;

//   /// Returns the currently selected filter.
//   String get selectedFilter => _selectedFilter;

//   /// Returns the current loading status.
//   bool get isLoading => _isLoading;

//   /// Returns the current error message, if any.
//   String? get errorMessage => _errorMessage;


//   // ----------------------------------------------------------
//   // LOAD TASKS
//   // ----------------------------------------------------------

//   /// Initializes local storage and retrieves saved tasks.
//   ///
//   /// notifyListeners() updates the UI when loading starts
//   /// and when the loading operation finishes.
//   Future<void> loadTasks() async {

//     // Show the loading indicator.
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {

//       // Initialize local storage before accessing saved data.
//       await LocalStorageService.instance.init();

//       // Retrieve tasks from the existing TasksNotifier.
//       // List.from creates a separate list for the Home controller.
//       _tasks = List<TodoModel>.from(
//         TasksNotifier.instance.tasks,
//       );

//     } catch (e) {

//       // Store an error message if something goes wrong.
//       _errorMessage = 'Unable to load tasks.';

//       debugPrint('Error loading tasks: $e');

//     } finally {

//       // Stop the loading indicator whether successful or not.
//       _isLoading = false;
//       notifyListeners();
//     }
//   }


//   // ----------------------------------------------------------
//   // SEARCH FUNCTION
//   // ----------------------------------------------------------

//   /// Updates the search text whenever the user types.
//   ///
//   /// The filteredTasks getter uses this value to search
//   /// through task titles.
//   void updateSearch(String value) {
//     _searchText = value;
//     notifyListeners();
//   }


//   // ----------------------------------------------------------
//   // FILTER FUNCTION
//   // ----------------------------------------------------------

//   /// Updates the selected filter.
//   ///
//   /// Available filters:
//   /// - Today: Shows tasks due today.
//   /// - Completed: Shows completed tasks.
//   /// - All: Shows every task.
//   void updateFilter(String value) {
//     _selectedFilter = value;
//     notifyListeners();
//   }


//   // ----------------------------------------------------------
//   // FILTERED TASK LIST
//   // ----------------------------------------------------------

//   /// Returns tasks based on the current search and filter.
//   ///
//   /// This is a getter because the filtered list is calculated
//   /// whenever the UI requests it.
//   List<TodoModel> get filteredTasks {

//     // Start with a copy of all available tasks.
//     List<TodoModel> result = List<TodoModel>.from(_tasks);


//     // SEARCH FILTER:
//     // Only keep tasks whose titles contain the search text.
//     if (_searchText.trim().isNotEmpty) {

//       result = result.where((task) {

//         return task.title
//             .toLowerCase()
//             .contains(_searchText.trim().toLowerCase());

//       }).toList();
//     }


//     // TODAY FILTER:
//     // Compare the task due date with today's date.
//     if (_selectedFilter == 'Today') {

//       final now = DateTime.now();

//       result = result.where((task) {

//         final date = task.dueDate;

//         return date != null &&
//             date.year == now.year &&
//             date.month == now.month &&
//             date.day == now.day;

//       }).toList();

//     }

//     // COMPLETED FILTER:
//     // Only display tasks marked as completed.
//     else if (_selectedFilter == 'Completed') {

//       result = result
//           .where((task) => task.isCompleted)
//           .toList();
//     }

//     // When the filter is All, no additional filtering is applied.
//     return result;
//   }


//   // ----------------------------------------------------------
//   // UPDATE TASK COMPLETION
//   // ----------------------------------------------------------

//   /// Changes the completion status of a selected task.
//   ///
//   /// The UI calls this function when the checkbox is tapped.
//   /// notifyListeners() rebuilds the affected UI.
//   void toggleTask(TodoModel task, bool value) {

//     task.isCompleted = value;

//     notifyListeners();
//   }
// }



// // ============================================================
// // 2. HOME PAGE
// // ============================================================

// /// Main Home screen displayed inside the bottom navigation shell.
// ///
// /// This widget combines the search bar, filter dropdown,
// /// empty state and task list.
// class HomePage extends StatefulWidget {

//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }


// class _HomePageState extends State<HomePage> {

//   // Creates the controller responsible for HomePage state.
//   late final HomeController controller;

//   // Controls the search TextField.
//   final TextEditingController searchController =
//       TextEditingController();


//   // ----------------------------------------------------------
//   // INITIALIZATION
//   // ----------------------------------------------------------

//   /// Called once when HomePage is first created.
//   ///
//   /// Creates the HomeController and loads the saved tasks.
//   @override
//   void initState() {
//     super.initState();

//     controller = HomeController();

//     // Retrieve tasks when the HomePage opens.
//     controller.loadTasks();
//   }


//   // ----------------------------------------------------------
//   // DISPOSE
//   // ----------------------------------------------------------

//   /// Releases resources when HomePage is removed.
//   ///
//   /// Prevents unnecessary memory usage and controller leaks.
//   @override
//   void dispose() {

//     searchController.dispose();
//     controller.dispose();

//     super.dispose();
//   }


//   // ----------------------------------------------------------
//   // BUILD METHOD
//   // ----------------------------------------------------------

//   /// Builds the main HomePage interface.
//   ///
//   /// AnimatedBuilder listens to the HomeController.
//   /// Whenever notifyListeners() is called, the UI rebuilds.
//   @override
//   Widget build(BuildContext context) {

//     return AnimatedBuilder(
//       animation: controller,

//       builder: (context, child) {

//         return Scaffold(

//           // Top application bar.
//           appBar: AppBar(
//             title: const Text('Index'),

//             // Filter icon in the AppBar.
//             leading: IconButton(
//               icon: const Icon(Icons.filter_list),
//               onPressed: () {},
//             ),

//             // Profile avatar on the right side.
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 16),

//                 child: GestureDetector(
//                   onTap: () {},

//                   child: const CircleAvatar(
//                     radius: 18,
//                     backgroundImage: AssetImage(
//                       'assets/images/backgrounds/images4.jpg',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Displays the appropriate body based on the current state.
//           body: _buildBody(),
//         );
//       },
//     );
//   }


//   // ----------------------------------------------------------
//   // BUILD BODY
//   // ----------------------------------------------------------

//   /// Decides which screen content should be displayed.
//   ///
//   /// 1. Loading indicator while tasks are loading.
//   /// 2. Error message if loading fails.
//   /// 3. Empty state if there are no tasks.
//   /// 4. Main task interface if tasks are available.
//   Widget _buildBody() {

//     // Display loading indicator.
//     if (controller.isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }


//     // Display error message.
//     if (controller.errorMessage != null) {
//       return Center(
//         child: Text(controller.errorMessage!),
//       );
//     }


//     // Display empty state when there are no saved tasks.
//     if (controller.tasks.isEmpty) {

//       return HomeEmptyState(

//         // Navigate to the Index screen to create a task.
//         onCreateTask: () {

//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const Index(),
//             ),
//           ).then((_) => controller.loadTasks());
//         },

//         // Navigate to the task creation screen.
//         onAddTask: () => AppNavigator.pushTasks(context),
//       );
//     }


//     // Main Home interface when tasks are available.
//     return Column(
//       children: [

//         // Search bar widget.
//         HomeSearchBar(
//           controller: searchController,
//           onChanged: controller.updateSearch,
//         ),


//         // Dropdown for selecting task filters.
//         HomeFilterDropdown(
//           selectedFilter: controller.selectedFilter,
//           onChanged: controller.updateFilter,
//         ),


//         const SizedBox(height: 18),


//         // Expanded allows the task list to occupy remaining space.
//         Expanded(
//           child: HomeTaskList(

//             // Pass the filtered tasks to the list widget.
//             tasks: controller.filteredTasks,

//             // Handle checkbox changes.
//             onTaskChanged: controller.toggleTask,

//             // Navigate to the edit task screen.
//             onTaskTap: (task) {

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const EditTask(),
//                 ),
//               ).then((_) => controller.loadTasks());
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }



// // ============================================================
// // 3. EMPTY STATE WIDGET
// // ============================================================

// /// Displays the interface shown when the user has no tasks.
// ///
// /// Provides navigation options for creating or adding tasks.
// class HomeEmptyState extends StatelessWidget {

//   // Callback for navigating to the Index screen.
//   final VoidCallback onCreateTask;

//   // Callback for navigating to the task creation screen.
//   final VoidCallback onAddTask;


//   const HomeEmptyState({
//     super.key,
//     required this.onCreateTask,
//     required this.onAddTask,
//   });


//   /// Builds the empty state interface.
//   @override
//   Widget build(BuildContext context) {

//     return Padding(
//       padding: const EdgeInsets.all(20),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,

//         children: [

//           // Empty state illustration.
//           Image.asset(
//             'assets/images/backgrounds/images3.jpg',
//           ),


//           // Main empty state message.
//           Padding(
//             padding: const EdgeInsets.only(left: 53),

//             child: InkWell(
//               onTap: onCreateTask,

//               child: Text(
//                 'What do you want to do today?',
//                 style: AppTextStyles.heading3,
//               ),
//             ),
//           ),


//           const SizedBox(height: 8),


//           // Instruction telling the user how to add tasks.
//           Padding(
//             padding: const EdgeInsets.only(left: 103),

//             child: InkWell(
//               onTap: onAddTask,

//               child: Text(
//                 'Tap + to add you tasks',
//                 style: AppTextStyles.bodySmall,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// // ============================================================
// // 4. SEARCH BAR WIDGET
// // ============================================================

// /// Displays the task search TextField.
// ///
// /// Receives a TextEditingController and an onChanged callback
// /// from HomePage instead of managing its own search state.
// class HomeSearchBar extends StatelessWidget {

//   // Controls the text entered into the search field.
//   final TextEditingController controller;

//   // Sends updated search text back to the HomeController.
//   final ValueChanged<String> onChanged;


//   const HomeSearchBar({
//     super.key,
//     required this.controller,
//     required this.onChanged,
//   });


//   /// Builds the search input field.
//   @override
//   Widget build(BuildContext context) {

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),

//       child: TextField(

//         controller: controller,

//         // Notify the controller whenever the search text changes.
//         onChanged: onChanged,

//         style: const TextStyle(
//           color: Colors.black87,
//         ),

//         decoration: InputDecoration(

//           hintText: 'Search for your task...',

//           hintStyle: const TextStyle(
//             color: Color(0xFF777777),
//             fontSize: 14,
//           ),

//           // Search icon displayed inside the input.
//           prefixIcon: const Icon(
//             Icons.search,
//             color: Color(0xFF777777),
//             size: 28,
//           ),

//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 17,
//           ),

//           // Border displayed when the TextField is not focused.
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(7),
//             borderSide: const BorderSide(
//               color: Color(0xFFD5D7DA),
//             ),
//           ),

//           // Border displayed when the TextField is focused.
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(7),
//             borderSide: const BorderSide(
//               color: Color(0xFF71D5E8),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// // ============================================================
// // 5. FILTER DROPDOWN WIDGET
// // ============================================================

// /// Displays the dropdown used to filter tasks.
// ///
// /// The selected filter is controlled by HomeController.
// /// This widget only displays the dropdown and reports changes.
// class HomeFilterDropdown extends StatelessWidget {

//   // Currently selected dropdown option.
//   final String selectedFilter;

//   // Sends the selected option back to the controller.
//   final ValueChanged<String> onChanged;


//   const HomeFilterDropdown({
//     super.key,
//     required this.selectedFilter,
//     required this.onChanged,
//   });


//   /// Builds the filter dropdown interface.
//   @override
//   Widget build(BuildContext context) {

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),

//       child: Align(
//         alignment: Alignment.centerLeft,

//         child: Container(

//           // Space around the dropdown text.
//           padding: const EdgeInsets.symmetric(horizontal: 12),

//           decoration: BoxDecoration(
//             color: const Color(0xFFF1F2F4),
//             borderRadius: BorderRadius.circular(8),
//           ),

//           child: DropdownButtonHideUnderline(

//             child: DropdownButton<String>(

//               value: selectedFilter,

//               dropdownColor: Colors.white,

//               icon: const Icon(
//                 Icons.keyboard_arrow_down,
//                 color: Colors.black87,
//               ),

//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 14,
//               ),

//               // Available task filter options.
//               items: ['Today', 'Completed', 'All']
//                   .map(
//                     (item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(item),
//                     ),
//                   )
//                   .toList(),

//               // Notify the controller when a filter is selected.
//               onChanged: (value) {
//                 if (value != null) {
//                   onChanged(value);
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// // ============================================================
// // 6. TASK LIST WIDGET
// // ============================================================

// /// Displays multiple task cards using ListView.builder.
// ///
// /// Receives the filtered task list from HomePage.
// /// It does not perform filtering or manage task state.
// class HomeTaskList extends StatelessWidget {

//   // List of tasks that should be displayed.
//   final List<TodoModel> tasks;

//   // Callback for updating task completion.
//   final Function(TodoModel, bool) onTaskChanged;

//   // Callback for opening an individual task.
//   final Function(TodoModel) onTaskTap;


//   const HomeTaskList({
//     super.key,
//     required this.tasks,
//     required this.onTaskChanged,
//     required this.onTaskTap,
//   });


//   /// Builds the scrollable task list.
//   @override
//   Widget build(BuildContext context) {

//     // Display a message when search or filtering returns no results.
//     if (tasks.isEmpty) {
//       return const Center(
//         child: Text(
//           'No tasks found.',
//           style: TextStyle(
//             color: Colors.grey,
//             fontSize: 14,
//           ),
//         ),
//       );
//     }


//     // Build task cards only when they are needed.
//     return ListView.builder(

//       padding: const EdgeInsets.symmetric(horizontal: 24),

//       itemCount: tasks.length,

//       itemBuilder: (context, index) {

//         // Get the task at the current list position.
//         final task = tasks[index];

//         // Create an individual card for this task.
//         return HomeTaskCard(

//           task: task,

//           // Pass checkbox changes to HomePage.
//           onChanged: (value) {
//             onTaskChanged(task, value);
//           },

//           // Pass task taps to HomePage.
//           onTap: () {
//             onTaskTap(task);
//           },
//         );
//       },
//     );
//   }
// }



// // ============================================================
// // 7. INDIVIDUAL TASK CARD WIDGET
// // ============================================================

// /// Displays information about a single task.
// ///
// /// Each card contains:
// /// - Completion checkbox.
// /// - Task title.
// /// - Due time.
// /// - Task category.
// /// - Task priority.
// ///
// /// This widget is only responsible for presentation.
// /// Changes are sent back to HomePage through callbacks.
// class HomeTaskCard extends StatelessWidget {

//   // The task whose information should be displayed.
//   final TodoModel task;

//   // Callback triggered when the completion checkbox changes.
//   final ValueChanged<bool> onChanged;

//   // Callback triggered when the user taps the task title.
//   final VoidCallback onTap;


//   const HomeTaskCard({
//     super.key,
//     required this.task,
//     required this.onChanged,
//     required this.onTap,
//   });


//   // Shared colors used throughout the task card.
//   static const mutedColor = Color(0xFF777777);
//   static const cardColor = Color(0xFFF1F2F4);


//   /// Builds the individual task card.
//   @override
//   Widget build(BuildContext context) {

//     // Retrieve the task due date.
//     final dueDate = task.dueDate;

//     // Convert the due time into HH:MM format.
//     // Display --:-- if no due date is available.
//     final time = dueDate == null
//         ? '--:--'
//         : '${dueDate.hour.toString().padLeft(2, '0')}:'
//           '${dueDate.minute.toString().padLeft(2, '0')}';


//     return Container(

//       // Space between task cards.
//       margin: const EdgeInsets.only(bottom: 16),

//       // Inner spacing inside the card.
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 16,
//       ),

//       // Card background and rounded corners.
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(8),
//       ),

//       child: Row(
//         children: [

//           // ----------------------------------------------------
//           // TASK COMPLETION CHECKBOX
//           // ----------------------------------------------------

//           SizedBox(
//             width: 35,

//             child: Checkbox(

//               // Current completion status of the task.
//               value: task.isCompleted,

//               // Notify HomeController when the checkbox changes.
//               onChanged: (value) {
//                 onChanged(value ?? false);
//               },

//               shape: const CircleBorder(),

//               side: const BorderSide(
//                 color: Color(0xFF888888),
//                 width: 1.7,
//               ),

//               activeColor: const Color(0xFF71D5E8),
//             ),
//           ),


//           const SizedBox(width: 10),


//           // ----------------------------------------------------
//           // TASK INFORMATION
//           // ----------------------------------------------------

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               children: [

//                 // Task title.
//                 InkWell(
//                   onTap: onTap,

//                   child: Text(
//                     task.title,

//                     // Completed tasks appear grey and crossed out.
//                     style: TextStyle(
//                       color: task.isCompleted
//                           ? mutedColor
//                           : Colors.black87,

//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,

//                       decoration: task.isCompleted
//                           ? TextDecoration.lineThrough
//                           : TextDecoration.none,
//                     ),
//                   ),
//                 ),


//                 const SizedBox(height: 10),


//                 // ------------------------------------------------
//                 // TASK TIME, CATEGORY AND PRIORITY
//                 // ------------------------------------------------

//                 Row(
//                   children: [

//                     // Display the task due time.
//                     Text(
//                       time,
//                       style: const TextStyle(
//                         color: mutedColor,
//                         fontSize: 14,
//                       ),
//                     ),


//                     // Push category and priority to the right.
//                     const Spacer(),


//                     // ------------------------------------------------
//                     // TASK CATEGORY
//                     // ------------------------------------------------

//                     // Only display the category if categoryId is not empty.
//                     if (task.categoryId!.isEmpty)

//                       Container(

//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 7,
//                           vertical: 10,
//                         ),

//                         decoration: BoxDecoration(

//                           // Use the category's assigned color.
//                           // Grey is used if no category color exists.
//                           color: task.category?.color ??
//                               Colors.grey,

//                           borderRadius: BorderRadius.circular(5),
//                         ),

//                         child: Text(
//                           task.category?.name ?? 'Uncategorized',

//                           overflow: TextOverflow.ellipsis,

//                           style: const TextStyle(
//                             color: Colors.black54,
//                             fontSize: 10,
//                           ),
//                         ),
//                       ),


//                     const SizedBox(width: 7),


//                     // ------------------------------------------------
//                     // TASK PRIORITY
//                     // ------------------------------------------------

//                     // Only display priority when its value is greater than zero.
//                     if (task.priority > 0)

//                       Container(

//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 7,
//                           vertical: 8,
//                         ),

//                         decoration: BoxDecoration(

//                           border: Border.all(
//                             color: const Color(0xFFB0B0B0),
//                           ),

//                           borderRadius: BorderRadius.circular(5),
//                         ),

//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,

//                           children: [

//                             // Flag icon indicating task priority.
//                             const Icon(
//                               Icons.flag_outlined,
//                               size: 15,
//                               color: mutedColor,
//                             ),

//                             const SizedBox(width: 4),

//                             // Display the priority number.
//                             Text(
//                               '${task.priority}',

//                               style: const TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
