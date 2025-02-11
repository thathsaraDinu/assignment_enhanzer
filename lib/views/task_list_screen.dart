import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../view_models/task_view_model.dart';
import 'add_edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TaskViewModel>(context, listen: false).loadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: Consumer<TaskViewModel>(
        builder: (context, taskViewModel, child) {
          if (taskViewModel.tasks.isEmpty) {
            return const Center(child: Text('No tasks available'));
          }

          return ListView.builder(
            itemCount: taskViewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = taskViewModel.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditTaskScreen(task: task),
                          ),
                        );
                        taskViewModel.loadTasks(); // Refresh after edit
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        taskViewModel.deleteTask(task.id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditTaskScreen()),
          );
          // ignore: use_build_context_synchronously
          Provider.of<TaskViewModel>(context, listen: false)
              .loadTasks(); // Refresh after adding
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
