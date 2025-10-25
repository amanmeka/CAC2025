import 'package:flutter/material.dart';
import 'package:flutter_cac/data/constants.dart';
import 'package:flutter_cac/data/database_service.dart';
import 'package:flutter_cac/views/pages/home_page.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class NewTask extends StatelessWidget {
  const NewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskPage();
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Task> tasksList = [];

  void toggleTask(int index) {
    setState(() {
      tasksList[index].isDone = !tasksList[index].isDone;
    });
  }

  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      tasksList.add(Task(title: title));
    });
  }

  void _updateTask(int index, String newTitle) {
    if (newTitle.trim().isEmpty) return;
    setState(() {
      tasksList[index].title = newTitle;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasksList.removeAt(index);
    });
  }

  void _addToDatabase(String title, String path) {
    DatabaseService().create(path: path, data: {'name': title});
  }

  void _showAddTaskDialog() {
    String newTaskTitle = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter task title'),
            onChanged: (value) {
              newTaskTitle = value;
            },
            onSubmitted: (_) {
              _addTask(newTaskTitle);
              String path = 'task' + tasksList.length.toString();                   //!DatabaseService().read(path: 'tasksNumber').toString();
              _addToDatabase(newTaskTitle, path);
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask(newTaskTitle);
                Navigator.of(context).pop();
                
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTask(int index) {
    String editedTitle = tasksList[index].title;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            autofocus: true,
            controller: TextEditingController(text: tasksList[index].title),
            decoration: const InputDecoration(hintText: 'Edit task title'),
            onChanged: (value) {
              editedTitle = value;
            },
            onSubmitted: (_) {
              _updateTask(index, editedTitle);
              Navigator.of(context).pop();
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
                _updateTask(index, editedTitle);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
              onChanged: (value) => toggleTask(index),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration:
                    task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: task.isDone ? textStyles.color : null,
              ),
            ),
            onTap: () => toggleTask(index),
            onLongPress: () => _editTask(index),
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
