import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/notification_service.dart';
import '../services/database_helper.dart';
import '../utils/date_time_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final NotificationService _notificationService = NotificationService();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  TaskProvider() {
    _initTasks();
    _notificationService.init();
  }

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> _initTasks() async {
    _tasks = await _databaseHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _databaseHelper.insertTask(task);
    _tasks.add(task);
    _scheduleNotification(task);
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      await _databaseHelper.updateTask(updatedTask);
      _tasks[index] = updatedTask;
      _scheduleNotification(updatedTask);
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _databaseHelper.deleteTask(id);
      await _notificationService.cancelNotification(id.hashCode);
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
      debugPrint('Task and its notification deleted: $id');
    } catch (e) {
      debugPrint('Error deleting task and notification: $e');
    }
  }

  void _scheduleNotification(Task task) {
    try {
      final scheduledDate = DateTime(
        task.date.year,
        task.date.month,
        task.date.day,
        task.time.hour,
        task.time.minute,
      );

      if (scheduledDate.isAfter(DateTime.now())) {
        debugPrint('Scheduling notification for task: ${task.description}');
        _notificationService.showNotification(
          id: task.id.hashCode,
          title: 'Pengingat Tugas',
          body: 'Waktunya untuk: ${task.description}\n'
              'Pada: ${DateTimeHelper.formatDate(task.date)} '
              '${DateTimeHelper.formatTime(task.time)}',
          scheduledDate: scheduledDate,
        );
      } else {
        debugPrint('Skipping notification for past task: ${task.description}');
      }
    } catch (e) {
      debugPrint('Error scheduling notification for task: $e');
    }
  }

  Future<void> toggleTaskCompletion(String id) async {
    try {
      final taskIndex = _tasks.indexWhere((task) => task.id == id);
      if (taskIndex != -1) {
        final task = _tasks[taskIndex];
        final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
        await _databaseHelper.toggleTaskCompletion(id, updatedTask.isCompleted);
        _tasks[taskIndex] = updatedTask;

        if (updatedTask.isCompleted) {
          await _notificationService.cancelNotification(id.hashCode);
          debugPrint('Notification cancelled for completed task: $id');
        } else {
          _scheduleNotification(updatedTask);
        }

        notifyListeners();
        debugPrint(
            'Task completion toggled: $id, Completed: ${updatedTask.isCompleted}');
      }
    } catch (e) {
      debugPrint('Error toggling task completion: $e');
    }
  }
}
