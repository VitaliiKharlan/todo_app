import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/router/router.dart';

class TaskLocationFieldWidget extends StatefulWidget {
  const TaskLocationFieldWidget({
    super.key,
    required this.taskLocation,
    required this.onLocationPicked,
  });

  final LocationDetailsModel? taskLocation;
  final ValueChanged<LocationDetailsModel?> onLocationPicked;

  @override
  State<TaskLocationFieldWidget> createState() =>
      _TaskLocationFieldWidgetState();
}

class _TaskLocationFieldWidgetState extends State<TaskLocationFieldWidget> {
  Future<void> _getLocationFromPreviousScreen() async {
    final result =
        await context.router.push<LocationDetailsModel>(LocationSearchRoute());
    if (result != null) {
      widget.onLocationPicked(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () => {
              _getLocationFromPreviousScreen(),
            },
            icon: const Icon(Icons.location_city),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                Text(
                  widget.taskLocation == null
                      ? 'Pick a place'
                      : widget.taskLocation?.description ?? '',
                  style: widget.taskLocation == null
                      ? theme.textTheme.headlineMedium
                      : theme.textTheme.headlineLarge,
                ),
              ],
            ),
            // ✅ style defined in ThemeData
          ),
        ),
      ],
    );
  }
}
