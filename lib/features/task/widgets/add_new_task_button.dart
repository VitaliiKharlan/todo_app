import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/base_container.dart';

class AddNewTaskButton extends StatelessWidget {
  const AddNewTaskButton({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(height: 12),
          Text(
            'Add new task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.hintColor.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }
}
