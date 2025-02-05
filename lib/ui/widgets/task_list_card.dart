import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';

import 'base_container.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.home,
            color: Colors.deepPurple,
          ),
          Text('jjjjj'),
          // Text(state.tasks.first.toString()),
          Column(
            children: [
              Text(
                '29 Jan',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 4),
              Text(
                '23:24',
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

