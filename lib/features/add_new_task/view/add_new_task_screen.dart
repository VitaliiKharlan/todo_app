import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';

@RoutePage()
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final List<Task> _todoList = [];
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDateTime;


  // passing a variable to a function
  void addTodo(AddNewTaskBloc bloc) {
    final taskTitle = _controller.text.trim();
    if (taskTitle.isNotEmpty) {
      bloc.add(AddNewTaskLoadedEvent(taskTitle));
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
    final bloc = BlocProvider.of<AddNewTaskBloc>(context);
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => addTodo(bloc),
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
                  subtitle: Text(todo.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  Task({
    required this.title,
    this.createdAt,
  });

  String title;
  DateTime? createdAt;

  // @override
  // String toString() {
  //   return 'Task(title: $title)';
  // }
}
