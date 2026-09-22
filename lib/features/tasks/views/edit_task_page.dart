import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/text_fields/app_text_field.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.taskId});

  final String taskId;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSaving = false;
  bool _missing = false;

  @override
  void initState() {
    super.initState();
    final task = TasksNotifier.instance.findById(widget.taskId);
    if (task == null) {
      _missing = true;
      return;
    }
    _titleController.text = task.title;
    _descriptionController.text = task.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final existing = TasksNotifier.instance.findById(widget.taskId);
    if (existing == null) return;

    setState(() => _isSaving = true);
    await TasksNotifier.instance.updateTask(
      existing.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
      ),
    );
    if (!mounted) return;
    setState(() => _isSaving = false);
    AppNavigator.back(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_missing) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Task'),
          leading: AppIconButton(
            icon: Icons.arrow_back,
            onPressed: () => AppNavigator.back(context),
          ),
        ),
        body: Center(
          child: Text('Task not found.', style: AppTextStyles.bodySmall),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => AppNavigator.back(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Update task', style: AppTextStyles.heading3),
            const SizedBox(height: 20),
            AppTextField(
              controller: _titleController,
              label: 'Title',
              hint: 'Task title',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _descriptionController,
              label: 'Description',
              hint: 'Optional details',
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Update Task',
              icon: Icons.check,
              isLoading: _isSaving,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
