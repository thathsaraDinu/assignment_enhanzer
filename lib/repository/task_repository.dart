import '../database/task_database.dart';
import '../models/task.dart';

class TaskRepository {
  final TaskDatabase _database = TaskDatabase.instance;

  Future<List<Task>> getTasks() async {
    return await _database.getTasks();
  }

  Future<void> addTask(Task task) async {
    await _database.insertTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _database.updateTask(task);
  }

  Future<void> deleteTask(int id) async {
    await _database.deleteTask(id);
  }
}
