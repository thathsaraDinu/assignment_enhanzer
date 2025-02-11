import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../view_models/task_view_model.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar:
          AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title')),
              TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description')),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = Task(
                      id: widget.task?.id, // Preserve the ID when editing
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );

                    if (widget.task == null) {
                      taskViewModel.addTask(task);
                    } else {
                      taskViewModel.updateTask(task); // Ensure update happens
                    }

                    Navigator.pop(context);
                  }
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
