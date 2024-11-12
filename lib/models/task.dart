import 'package:flutter/material.dart';

class Task {
  final String id;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final bool isCompleted;

  Task({
    required this.id,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
