import 'package:flutter/material.dart';
import 'package:flutter_cac/data/notifiers.dart';
import 'package:flutter_cac/data/database_service.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Task> tasksList = [];

  @override
  void initState() {
    super.initState();

    // Single safe listener for dialog trigger
    showAddTaskDialogNotifier.addListener(() {
      if (!mounted) return;
      if (showAddTaskDialogNotifier.value) {
        // Wait until page is fully built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _showAddTaskDialog();
        });
        // reset flag
        showAddTaskDialogNotifier.value = false;
      }
    });
  }

  void _addToDatabase(String title, String path) {
    DatabaseService().create(path: path, data: {'name': title});
  }

  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      tasksList.add(Task(title: title));
    });
    DatabaseService().create(
      path: 'task${tasksList.length}',
      data: {'name': title},
    );
  }

  void _showAddTaskDialog() {
    if (!mounted) return;

    showDialog<void>(
      context: context,
      barrierDismissible: true, // ESC or tapping outside allowed
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(hintText: 'Enter task title'),
            onSubmitted: (value) {
              final text = value.trim();
              if (text.isNotEmpty && mounted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  _addTask(text);
                  _addToDatabase(text, 'task${tasksList.length}');
                  Navigator.of(context).pop();
                });
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty && mounted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    _addTask(text);
                    _addToDatabase(text, 'task${tasksList.length}');
                    Navigator.of(context).pop();
                  });
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


  void _toggleTask(int index) {
    setState(() {
      tasksList[index].isDone = !tasksList[index].isDone;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasksList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          final task = tasksList[index];
          return ListTile(
            leading: Checkbox(
              value: task.isDone,
              onChanged: (_) => _toggleTask(index),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTask(index),
            ),
          );
        },
      ),
    );
  }
}