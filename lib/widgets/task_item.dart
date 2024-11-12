import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/edit_task_screen.dart';
import '../utils/color_palette.dart';
import '../utils/date_time_helper.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeProvider.isDarkMode
              ? ColorPalette.surfaceDark
              : ColorPalette.surfaceLight,
          title: Text(
            'Konfirmasi Hapus',
            style: TextStyle(
              color: themeProvider.isDarkMode
                  ? ColorPalette.textDark
                  : ColorPalette.textLight,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus tugas ini?',
            style: TextStyle(
              color: themeProvider.isDarkMode
                  ? ColorPalette.textDark
                  : ColorPalette.textLight,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Batal',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? ColorPalette.mutedDark
                      : ColorPalette.mutedLight,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false)
                    .deleteTask(task.id);
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Tugas berhasil dihapus'),
                    backgroundColor: themeProvider.isDarkMode
                        ? ColorPalette.deleteDark
                        : ColorPalette.deleteLight,
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              },
              child: Text(
                'Hapus',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? ColorPalette.deleteDark
                      : ColorPalette.deleteLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: 1.0,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(3),
          leading: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: task.isCompleted,
              activeColor: themeProvider.isDarkMode
                  ? ColorPalette.primaryDark
                  : ColorPalette.primaryLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (bool? value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .toggleTaskCompletion(task.id);
              },
            ),
          ),
          title: Text(
            task.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              color: task.isCompleted
                  ? (themeProvider.isDarkMode
                      ? ColorPalette.mutedDark
                      : ColorPalette.mutedLight)
                  : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                DateTimeHelper.formatDate(task.date),
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? ColorPalette.mutedDark
                      : ColorPalette.mutedLight,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              Text(
                DateTimeHelper.formatTime(task.time),
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? ColorPalette.mutedDark
                      : ColorPalette.mutedLight,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!task.isCompleted)
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: themeProvider.isDarkMode
                        ? ColorPalette.updateDark
                        : ColorPalette.updateLight,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskScreen(task: task),
                      ),
                    );
                  },
                ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: themeProvider.isDarkMode
                      ? ColorPalette.deleteDark
                      : ColorPalette.deleteLight,
                ),
                onPressed: () => _showDeleteConfirmation(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
