import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/color_palette.dart';
import '../utils/date_time_helper.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _submitData() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _selectedDate == null || _selectedTime == null) {
      // Tampilkan pesan error jika tanggal atau waktu belum dipilih
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mohon pilih tanggal dan waktu'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Validasi waktu tidak boleh di masa lalu
    final scheduledDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    if (scheduledDateTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Waktu tidak boleh di masa lalu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newTask = Task(
      id: DateTime.now().toString(),
      description: _descriptionController.text.trim(),
      date: _selectedDate!,
      time: _selectedTime!,
    );

    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Tidak bisa memilih tanggal di masa lalu
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) return;
      setState(() {
        _selectedTime = pickedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas Baru'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLength: 100, // Batasi panjang input
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  if (value.trim().length < 3) {
                    return 'Deskripsi minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Tanggal belum dipilih!'
                          : 'Tanggal: ${DateTimeHelper.formatDate(_selectedDate!)}',
                      style: TextStyle(
                        color: _selectedDate == null ? Colors.red : null,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text('Pilih Tanggal'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'Waktu belum dipilih!'
                          : 'Waktu: ${DateTimeHelper.formatTime(_selectedTime!)}',
                      style: TextStyle(
                        color: _selectedTime == null ? Colors.red : null,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentTimePicker,
                    child: const Text('Pilih Waktu'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.primaryLight,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    const Text('Tambah Tugas', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
