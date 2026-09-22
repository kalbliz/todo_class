import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/dialogs/app_dialog.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final notifier = TasksNotifier.instance;

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        final task = notifier.findById(taskId);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Task Detail'),
            leading: AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () => AppNavigator.back(context),
            ),
            actions: [
              if (task != null)
                AppIconButton(
                  icon: Icons.edit,
                  onPressed: () =>
                      AppNavigator.goEditTask(context, taskId),
                ),
            ],
          ),
          body: task == null
              ? Center(
                  child: Text(
                    'Task not found.',
                    style: AppTextStyles.bodySmall,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: AppTextStyles.heading2),
                      const SizedBox(height: 8),
                      Text(
                        task.description.isEmpty
                            ? 'No description'
                            : task.description,
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        task.isCompleted ? 'Completed' : 'Pending',
                        style: AppTextStyles.label,
                      ),
                      const Spacer(),
                      AppButton(
                        label: task.isCompleted
                            ? 'Mark as pending'
                            : 'Mark as done',
                        icon: task.isCompleted
                            ? Icons.undo
                            : Icons.check_circle_outline,
                        onPressed: () => notifier.toggleComplete(task.id),
                      ),
                      const SizedBox(height: 12),
                      AppOutlinedButton(
                        label: 'Delete task',
                        icon: Icons.delete_outline,
                        textColor: AppColors.error,
                        borderColor: AppColors.error,
                        onPressed: () async {
                          final confirmed = await AppDialogs.confirm(
                            context: context,
                            title: 'Delete task?',
                            message: 'This cannot be undone.',
                            confirmLabel: 'Delete',
                            isDestructive: true,
                          );
                          if (confirmed != true || !context.mounted) return;
                          await notifier.deleteTask(task.id);
                          if (!context.mounted) return;
                          AppNavigator.back(context);
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
