import 'package:flutter/material.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/features/tasks/widgets/addCategory.dart';
import 'package:todo_class/utils/bottom_sheets/app_bottom_sheet.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/text_fields/app_text_field.dart';
import 'package:iconsax/iconsax.dart';



/// Bottom sheet used to create a todo (text fields + save button).
class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  /// Opens the create-task sheet from anywhere (FAB, buttons, etc.).
  static Future<void> show(BuildContext context) {
    return AppBottomSheets.show<void>(
      context: context,
      child: const AddTaskSheet(),
    );
  }

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {

int? selectedIndex; // Tracks the currently picked container index (0-9)

  void showNumberedBottomSheet(BuildContext  parentcontext) {
  

   showDialog(
    context: context,
    builder: (modalContext) {
      return Dialog(
        // Curve the corners of the dialog container
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
         insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              // MainAxisSize.min ensures the dialog shrinks to fit your content
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: const Text(
                      'Task Priority',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                          thickness: 1,
                          indent: 5,
                          endIndent: 6,
                        ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4, 
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: List.generate(10, (index) {
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            selectedIndex = index;
                          });
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: isSelected ? Colors.blueAccent : const Color(0xFFBDBDBD),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.flag, 
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${index + 1}', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  // 🟢 BUTTONS ADDED HERE
                    const SizedBox(height: 24), // Spacing between grid and buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Cancel Button
                        TextButton(
                          onPressed: () {
                            Navigator.of(modalContext).pop(); // Closes the dialog
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16, color:  Color.fromARGB(255, 45, 105, 209), fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 50),
                        // Ok Button
                        ElevatedButton(
                          
                          onPressed: () {
                            Navigator.of(modalContext).pop(); // Closes the dialog and saves
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(153, 48),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Save', style: TextStyle(fontSize: 16),),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}








    // Local cache variables for the UI
  DateTime? _cachedDate;
  TimeOfDay? _cachedTime;

  void _pickDateTime() async {
    // 1. Open the native Calendar with fully customized button styling
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              // 🟢 Customize the OK (Confirm) button style
              confirmButtonStyle: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded pill shape
                  ),
                ),
              ),
              // 🔴 Customize the CANCEL button style
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 38, 111, 144)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    // If "OK" is tapped, automatically move to the Time Picker
    if (pickedDate != null) {
      if (!mounted) return;

      // 2. Open the native Time Picker
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        // Optional: Wrap this builder too if you want matching buttons on the time picker
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                confirmButtonStyle: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                cancelButtonStyle: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 39, 94, 133)),
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      // If "OK" is tapped on the time picker, update the screen cache
      if (pickedTime != null) {
        setState(() {
          _cachedDate = pickedDate;
          _cachedTime = pickedTime;
        });
      }
    }
  }




  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);
    await TasksNotifier.instance.addTask(
      title: _titleController.text,
      description: _descriptionController.text, 
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Add Task', style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              AppTextField(
                controller: _titleController,
                label: 'Title',
                hint: 'What do you need to do?',
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Optional details',
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
               Row(
      // Spaces out the buttons evenly across the available horizontal room
      children: [
        IconButton(
          icon: const Icon(Icons.timer),
          tooltip: 'Timer',
          onPressed: _pickDateTime,
        ),
        IconButton(
          icon: const Icon(Icons.local_offer), // Can also use Icons.tag
          tooltip: 'Tag',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                    left: 10,
                    right: 10
                  ),
                  child: Container(
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.grey
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 103),
                          child: Text("Choose Category", style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          thickness: 1,
                          indent: 5,
                          endIndent: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            children: [
                                 Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 151, 233, 103),
                                        child:Center(
                                        child: Icon(Iconsax.shopping_bag, color: const Color.fromARGB(255, 3, 47, 15),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Grocery", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              
                             Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 227, 146, 123),
                                        child:Center(
                                        child: Icon(Iconsax.briefcase, color: const Color.fromARGB(255, 177, 31, 15),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Work", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 130, 231, 240),
                                        child:Center(
                                        child: Icon(Iconsax.weight, color: const Color.fromARGB(255, 14, 161, 53),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Sport", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 130, 231, 240),
                                        child:Center(
                                        child: Icon(Iconsax.pen_tool_2, color: const Color.fromARGB(255, 12, 148, 48),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Design", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 83, 170, 229),
                                        child:Center(
                                        child: Icon(Iconsax.book, color: const Color.fromARGB(255, 5, 38, 79),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("University", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 231, 117, 227),
                                        child:Center(
                                        child: Icon(Iconsax.game, color: const Color.fromARGB(255, 93, 7, 94),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Social", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 231, 117, 227),
                                        child:Center(
                                        child: Icon(Iconsax.music, color: const Color.fromARGB(255, 93, 7, 94),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Music", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 110, 235, 185),
                                        child:Center(
                                        child: Icon(Iconsax.health, color: const Color.fromARGB(255, 10, 99, 107),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Health", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                             Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 76, 164, 176),
                                        child:Center(
                                        child: Icon(Iconsax.video, color: const Color.fromARGB(255, 8, 78, 113),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Movie", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 227, 159, 12),
                                        child:Center(
                                        child: Icon(Iconsax.home, color: const Color.fromARGB(255, 106, 74, 4),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("|Home", style: TextStyle(color: Colors.white, fontSize: 14),))
                                  ],
                                ),
                              Column(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Card(
                                         color: const Color.fromARGB(255, 218, 235, 87),
                                        child:Center(
                                        child: Icon(Iconsax.add, color: const Color.fromARGB(255, 93, 98, 5),),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Text("Create new", style: TextStyle(color: Colors.white, fontSize: 14),)),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
  // Takes up 90% of the screen width and 80% of the screen height
  width: MediaQuery.of(context).size.width * 1,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 19),
    child: FilledButton(
      onPressed: () {
         Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Addcategory()),
    );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, 
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2), // Increased radius to look better at scale
        ),
        elevation: 2,
      ),
      child: const Text(
        'Add Category',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18, // Increased font size so it matches the giant button size
        ),
      ),
    ),
  ),
)
                      ],
                    ),
                  ),
                );
              }
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.flag),
          tooltip: 'Flag',
          onPressed: () => showNumberedBottomSheet(context),
        ),
        SizedBox(width: 152,),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.blue,),
          tooltip: 'Send',
          onPressed: _save
        ),
      ],
    ),
              AppButton(
                label: 'Save Task',
                icon: Icons.check,
                isLoading: _isSaving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
