import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';
import '../utils/color_palette.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        backgroundColor: themeProvider.isDarkMode
            ? ColorPalette.primaryDark
            : ColorPalette.primaryLight,
        elevation: 4,
        shadowColor: themeProvider.isDarkMode ? Colors.black45 : Colors.black26,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Spacer di atas ListView
            const SizedBox(height: 16),
            // Wrapped ListView in Expanded
            Expanded(
              child: taskProvider.tasks.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada tugas',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? ColorPalette.mutedDark
                              : ColorPalette.mutedLight,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskProvider.tasks[index];
                        return TaskItem(task: task);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
        },
        backgroundColor: themeProvider.isDarkMode
            ? ColorPalette.accentDark
            : ColorPalette.accentLight,
        child: const Icon(Icons.add),
      ),
    );
  }
}
