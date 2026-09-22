import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/utils/buttons/app_button.dart';

/// Tasks list page — reads from shared [TasksNotifier] (persisted).
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = TasksNotifier.instance;

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        final tasks = notifier.tasks;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
            leading: AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () => AppNavigator.back(context),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => AppNavigator.showAddTask(context),
            child: const Icon(Icons.add),
          ),
          body: tasks.isEmpty
              ? Center(
                  child: Text(
                    'No tasks yet.\nTap + to add one.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(
                        task.title,
                        style: AppTextStyles.body.copyWith(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: task.description.isEmpty
                          ? null
                          : Text(
                              task.description,
                              style: AppTextStyles.bodySmall,
                            ),
                      trailing: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) => notifier.toggleComplete(task.id),
                      ),
                      onTap: () =>
                          AppNavigator.goTaskDetail(context, task.id),
                    );
                  },
                ),
        );
      },
    );
  }
}
