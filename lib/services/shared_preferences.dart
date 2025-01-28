import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;

  SharedPreferencesService(this.sharedPreferences);

  Future<List<Map<String, dynamic>>> getTodo() async {
    final items = sharedPreferences.getStringList('items') ?? [];
    return items.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }

  Future<void> addToDoList(String name) async {
    final tasks = await getTodo();
    tasks.add({"name": name, "isDone": false});
    await _saveToPreferences(tasks);
  }

  Future<void> updateTodoList(int index, String updatedName) async {
    final tasks = await getTodo();
    tasks[index]['name'] = updatedName;
    await _saveToPreferences(tasks);
  }

  Future<void> toggleTaskCompletion(int index) async {
    final tasks = await getTodo();
    tasks[index]['isDone'] = !(tasks[index]['isDone'] as bool);
    await _saveToPreferences(tasks);
  }

  Future<void> removeTodoList(int index) async {
    final tasks = await getTodo();
    tasks.removeAt(index);
    await _saveToPreferences(tasks);
  }

  Future<void> _saveToPreferences(List<Map<String, dynamic>> tasks) async {
    final encodedTasks = tasks.map((task) => jsonEncode(task)).toList();
    await sharedPreferences.setStringList('items', encodedTasks);
  }
}
