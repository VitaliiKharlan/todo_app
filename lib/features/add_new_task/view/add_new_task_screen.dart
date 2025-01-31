import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';

@RoutePage()
class Task {
  Task({
    required this.title,
    this.dateTime,
  });

  String title;
  DateTime? dateTime;
}

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final List<Task> _todoList = [];
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDateTime;

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todoList.add(Task(
          title: _controller.text,
          dateTime: _selectedDateTime,
        ));
        _controller.clear();
        _selectedDateTime = null;
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add New Task',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter a task',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectDateTime(context),
                  child: Text('Pick Date & Time'),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end ,
                  children: [

                    ElevatedButton(
                      onPressed: _addTodo,
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final todo = _todoList[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: todo.dateTime != null
                      ? Text(
                          '${todo.dateTime!.toLocal()}'.split(' ')[0] +
                              ' ' +
                              '${todo.dateTime!.toLocal()}'
                                  .split(' ')[1]
                                  .substring(0, 5),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
