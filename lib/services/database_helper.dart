import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    debugPrint('Creating new database with version $version');
    await db.execute('''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        isCompleted INTEGER NOT NULL DEFAULT 0
      )
    ''');
    debugPrint('Database tables created successfully');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('Upgrading database from version $oldVersion to $newVersion');
    if (oldVersion < 1) {
      await db.execute(
          'ALTER TABLE tasks ADD COLUMN isCompleted INTEGER NOT NULL DEFAULT 0');
      debugPrint('Added isCompleted column to tasks table');
    }
  }

  Future<void> insertTask(Task task) async {
    try {
      final db = await database;
      await db.insert(
          'tasks',
          {
            'id': task.id,
            'description': task.description,
            'date': task.date.toIso8601String(),
            'time': '${task.time.hour}:${task.time.minute}',
            'isCompleted': task.isCompleted ? 1 : 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      debugPrint('Task inserted successfully: ${task.id}');
    } catch (e) {
      debugPrint('Error inserting task: $e');
      rethrow;
    }
  }

  Future<List<Task>> getTasks() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'tasks',
        orderBy: 'date ASC, time ASC',
      );
      debugPrint('Retrieved ${maps.length} tasks from database');

      return List.generate(maps.length, (i) {
        final timeStr = maps[i]['time'].split(':');
        return Task(
          id: maps[i]['id'],
          description: maps[i]['description'],
          date: DateTime.parse(maps[i]['date']),
          time: TimeOfDay(
            hour: int.parse(timeStr[0]),
            minute: int.parse(timeStr[1]),
          ),
          isCompleted: maps[i]['isCompleted'] == 1,
        );
      });
    } catch (e) {
      debugPrint('Error getting tasks: $e');
      return [];
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final db = await database;
      await db.update(
        'tasks',
        {
          'description': task.description,
          'date': task.date.toIso8601String(),
          'time': '${task.time.hour}:${task.time.minute}',
          'isCompleted': task.isCompleted ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [task.id],
      );
      debugPrint('Task updated successfully: ${task.id}');
    } catch (e) {
      debugPrint('Error updating task: $e');
      rethrow;
    }
  }

  Future<void> toggleTaskCompletion(String id, bool isCompleted) async {
    try {
      final db = await database;
      await db.update(
        'tasks',
        {'isCompleted': isCompleted ? 1 : 0},
        where: 'id = ?',
        whereArgs: [id],
      );
      debugPrint('Task completion toggled: $id, Completed: $isCompleted');
    } catch (e) {
      debugPrint('Error toggling task completion: $e');
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final db = await database;
      await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
      debugPrint('Task deleted successfully: $id');
    } catch (e) {
      debugPrint('Error deleting task: $e');
      rethrow;
    }
  }
}
