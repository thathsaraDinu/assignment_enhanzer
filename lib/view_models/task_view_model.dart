import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repository/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _repository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _repository.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _repository.deleteTask(id);
    await loadTasks();
  }
}
