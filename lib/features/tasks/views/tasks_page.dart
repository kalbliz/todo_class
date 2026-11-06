import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/home/widgets/home_task_card.dart';
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
          body: RefreshIndicator(
            onRefresh: notifier.load,
            child: tasks.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        child: Center(
                          child: Text(
                            'No tasks yet.\nTap + to add one.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return HomeTaskCard(
                        task: task,
                        onToggleComplete: (_) =>
                            notifier.toggleComplete(task.id),
                        onTap: () =>
                            AppNavigator.goTaskDetail(context, task.id),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
